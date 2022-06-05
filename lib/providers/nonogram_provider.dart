import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';

class NonogramProvider with ChangeNotifier {
  static const String BASEURL = 'https://nonogram-api.cb-arcade.co.uk/api';

  Nonogram? _nonogram;

  //API CALLS
  Future<bool> getNonogram() async {
    Map<String, String> _headers = {
        'Authorization' : Environment().apiKey,
        'Content-Type': 'application/json'
    };

    final _uri = Uri.parse('${BASEURL}/getnonogram/');
    var _res = await http.get(_uri, headers: _headers);

    if(_res.statusCode == 200) {
      //Set the nonogram data
      final _responseData = json.decode(_res.body);
      _nonogram = Nonogram(
        id: _responseData['id'], 
        word: _responseData['word'],
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
      return true;
    }  else {
      return false;
    }
  }

  Future<bool> sendWords(wordString) async {
    print('Sending Words');
    print(wordString);
    return true;
  }

  addNLetterWord(int i,String word) {
    List<String>? _wordList = _nonogram!.foundWords![i];

    if(!_wordList!.contains(word)) {
      _wordList.add(word);
    }
    _nonogram!.foundWords![i] = _wordList;
    notifyListeners();
  }

  //GET METHODS
  get nonogram {
    return _nonogram;
  }
}


class Nonogram {
  int id;
  String word;
  Map<int,List<String>>? foundWords;

  Nonogram({
    required this.id,
    required this.word,
    this.foundWords,
  });
}