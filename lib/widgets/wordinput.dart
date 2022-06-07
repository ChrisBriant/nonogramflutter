import 'package:flutter/material.dart';
import 'package:nonogramflutter/screens/results.dart';
import 'package:provider/provider.dart';
import 'dart:async';

import '../providers/nonogram_provider.dart';

class WordInput extends StatefulWidget {
  const WordInput({ Key? key }) : super(key: key);

  @override
  State<WordInput> createState() => _WordInputState();
}

class _WordInputState extends State<WordInput> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _inputContoller = TextEditingController();
  NonogramProvider? _nonogramProvider;
  String? _wordsString;
  Timer? _timer;
  String tempWord = '';
  bool processingWordList = true;

  //Define regex expressions
  final Map<int,RegExp> regExMap = {
    3 : RegExp(r'\b\w{3}\b',multiLine: true),
    4 : RegExp(r'\b\w{4}\b',multiLine: true),
    5 : RegExp(r'\b\w{5}\b',multiLine: true),
    6 : RegExp(r'\b\w{6}\b',multiLine: true),
    7 : RegExp(r'\b\w{7}\b',multiLine: true),
    8 : RegExp(r'\b\w{8}\b',multiLine: true),
    9 : RegExp(r'\b\w{9}\b',multiLine: true),
  };

  // _saveForm() {
  //   print('Form saves here');
  //   print(_wordsString);

  //   _formKey.currentState!.save();
  //   if(_nonogramProvider != null) {
  //     //_nonogramProvider!.sendWords(_wordsString);
  //   }
  
  // }


bool _checkWordInWord(String word1, String word2) {
  if(word1.isEmpty) {
    return true;
  }
  String newWord2 = word2;
  String newWord1 = word1;
  String letter = word1.characters.take(1).toString();
  int letterIndex = newWord2.characters.toList().indexWhere((element) => element == letter);
  if(letterIndex == -1) {
    return false;
  } else {
    List<String> newWord2List = newWord2.characters.toList();
    newWord2List.removeAt(letterIndex);
    List<String> newWord1List = newWord1.characters.toList();
    newWord1List.removeAt(0);
    //Need to conver the array to string
    return _checkWordInWord(newWord1List.join(''), newWord2List.join(''));
  }
}

  //Performs word matching
  _matchWords(wordText) {
    String testStr = '3';
    String nonogramWord = _nonogramProvider!.nonogram.word;


    for(int i=3;i<10;i++) {
      final RegExp? regEx = regExMap[i];
      regEx!.allMatches(wordText.toLowerCase()).forEach((word) { 
        if(_checkWordInWord(word.group(0).toString(), nonogramWord)) {
          //Add the word
          _nonogramProvider!.addNLetterWord(i,word.group(0).toString());
        }
      });
    }
  }

  _readWords(val) {
    //print(_inputContoller.text);
    setState(() {
      processingWordList =  true;
    });
    if(_timer != null) {
      _timer!.cancel();
      _timer = Timer(Duration(seconds: 3), () {
          _matchWords(val);
          setState(() {
            processingWordList = false;
          });
          
        }
      );
    } else {
      _timer = Timer(Duration(seconds: 3), () {
          _matchWords(val);
          setState(() {
            processingWordList = false;
          });
        }
      );
    }
    
  }

  _submitWords() async {
    try {
      bool success = await _nonogramProvider!.sendWords();
      if(success) {
        Navigator.of(context).pushNamed(ResultsScreen.routeName);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('An error occred retrieving the results'),
        ));
      }
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(err.toString()),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);
    _checkWordInWord('kkeey','emskkyeok');

    return Container(
      padding: EdgeInsets.all(8),
      color: Colors.purple.shade900,
      child: Column(
        children: [
          SizedBox(height: 10,),
          Form(
            key: _formKey,
            child: Container(
              child: TextFormField(
                        initialValue: null,
                        maxLines: 6,
                        controller: _inputContoller,
                        onChanged: (value) { _readWords(value); },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                          labelText: 'Enter words here.',
                          border: OutlineInputBorder(),
                          fillColor: Colors.white,
                          filled: true,
                          focusedBorder:  OutlineInputBorder(),
                        ),
                        onSaved: (value) { _wordsString = value; },
                      ),
            ),
          ),
          ElevatedButton(
            onPressed: processingWordList ? null : _submitWords, 
            child: const Text('Score')
          )
        ],
      ),
    );
  }
}