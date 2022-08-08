import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';

class NonogramProvider with ChangeNotifier {
  // ignore: constant_identifier_names
  static const String BASEURL = 'https://nonogram-api.cb-arcade.co.uk/api';

  Nonogram? _nonogram;
  Result? _result;
  Result? _solution;

  //API CALLS
  Future<Nonogram?> getNonogram() async {
    if(_nonogram != null) {
      return _nonogram;
    } else {
      Map<String, String> _headers = {
          'Authorization' : Environment().apiKey,
          'Content-Type': 'application/json'
      };

      final _uri = Uri.parse('$BASEURL/getnonogram/');
      var _res = await http.get(_uri, headers: _headers);

      if(_res.statusCode == 200) {
        //Set the nonogram data
        final _responseData = json.decode(_res.body);
        _nonogram = Nonogram(
          id: _responseData['id'], 
          word: _responseData['word'],
          special: _responseData['word'].toString().characters.toList()[4].toString(),
          foundWords: {
            3 : [],
            4 : [],
            5 : [],
            6 : [],
            7 : [],
            8 : [],
            9 : [],
          }
        );
      } else {
        return Future.error('CONNECTION ERROR!');
      }
      
      return _nonogram; 
    }

  }

  _generateResults(Map<dynamic,dynamic> resultData) {

    //CREATE THE USER RESULTS PART
    List<WordScore> userWordScoreList = [];

    Map<dynamic,dynamic> results = resultData['result'];
    for(int i=3;i<10;i++) {
      Map<String,dynamic> result = results['${i.toString()}letter'];
      WordScore wordScore = WordScore(
        numLetters: i, 
        score:  result['score'], 
        scoredWords: List<String>.from(result['scoredWords']), 
        unscoredWords: List<String>.from(result['unscoredWords']), 
        wordsChecked: List<String>.from(result['wordsChecked'])
      );
      userWordScoreList.add(wordScore);
    }

    //Create the provided result
    _result = Result(
      solvedWord: resultData['solvedWord'], 
      totalScore: resultData['totalScore'], 
      wordScore: userWordScoreList
    );

    //CREATE THE SOLTION RESULT PART
    List<WordScore> solutionWordScoreList = [];
    
    Map<dynamic,dynamic> solutionResults = resultData['solution']['result'];
    for(int i=3;i<10;i++) {
      Map<String,dynamic> result = solutionResults['${i.toString()}letter'];
      WordScore wordScore = WordScore(
        numLetters: i, 
        score:  result['score'], 
        scoredWords: List<String>.from(result['scoredWords']), 
        unscoredWords: List<String>.from(result['unscoredWords']), 
        wordsChecked: List<String>.from(result['wordsChecked'])
      );
      solutionWordScoreList.add(wordScore);
    }

    //Create the provided solution
    _solution = Result(
      solvedWord: resultData['solvedWord'], 
      totalScore: resultData['solution']['totalScore'], 
      wordScore: solutionWordScoreList
    );

  }

  Future<bool> sendWords() async {
    //Collect all the words to send
    List<String>? allWords = [];
    for(int i=3;i<10; i++) {
      if(_nonogram!.foundWords![i] != null) {
        // ignore: avoid_function_literals_in_foreach_calls
        _nonogram!.foundWords![i]!.forEach((element) {
          allWords.add(element);
        });
      }
    }

    if(allWords.isEmpty) {
      throw Exception('The word list is empty, you must enter at least one word!');
    }

    Map<String, String> _headers = {
        'Authorization' : Environment().apiKey,
        'Content-Type': 'application/json'
    };

    final uri = Uri.parse('$BASEURL/scoreword/');
    var _res = await http.post(
      uri,
      body: json.encode({
        'id' : _nonogram!.id,
        'special' : _nonogram!.special,
        'word' : _nonogram!.word,
        'word_list' : allWords,
      }),
      headers: _headers 
    );

    if(_res.statusCode == 200) {
      final _responseData = json.decode(_res.body);
      _generateResults(_responseData);
      return true;
    }

    return false;
  }

  addNLetterWord(int i,String word) {
    List<String>? _wordList = _nonogram!.foundWords![i];

    if(!_wordList!.contains(word)) {
      _wordList.add(word);
    }
    _nonogram!.foundWords![i] = _wordList;
  }

  resetData() {
    _nonogram = null;
    _result = null;
    _solution = null;
  }

  //GET METHODS
  get nonogram {
    return _nonogram;
  }

  get result {
    return _result;
  }

  get solution {
    return _solution;
  }

  get wordListEmpty {
    List<String>? allWords = [];
    for(int i=3;i<10; i++) {
      if(_nonogram!.foundWords![i] != null) {
        // ignore: avoid_function_literals_in_foreach_calls
        _nonogram!.foundWords![i]!.forEach((element) {
          allWords.add(element);
        });
      }
    }
    return allWords.isEmpty;
  }

}


class WordScore {
  int numLetters;
  int score;
  List<String> scoredWords;
  List<String> unscoredWords;
  List<String> wordsChecked;

  WordScore({
    required this.numLetters,
    required this.score,
    required this.scoredWords,
    required this.unscoredWords,
    required this.wordsChecked,
  });
}

class Result {
  String solvedWord;
  int totalScore;
  List<WordScore> wordScore;

  Result({
    required this.solvedWord,
    required this.totalScore,
    required this.wordScore,
  });

}


class Nonogram {
  int id;
  String word;
  String special;
  Map<int,List<String>>? foundWords;

  Nonogram({
    required this.id,
    required this.word,
    required this.special,
    this.foundWords,
  });
}