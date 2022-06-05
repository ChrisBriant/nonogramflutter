import 'package:flutter/material.dart';
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

  _saveForm() {
    print('Form saves here');
    print(_wordsString);

    _formKey.currentState!.save();
    if(_nonogramProvider != null) {
      _nonogramProvider!.sendWords(_wordsString);
    }
  
  }


bool _checkWordInWord(String word1, String word2) {
  if(word1.isEmpty) {
    return true;
  }
  String newWord2 = word2;
  String newWord1 = word1;
  // print(newWord2);
  String letter = word1.characters.take(1).toString();
  int letterIndex = newWord2.characters.toList().indexWhere((element) => element == letter);
  // print('letter index $letterIndex');
  // print(newWord2);
  if(letterIndex == -1) {
    // print('word not valid');
    return false;
  } else {
    //newWord2 = newWord2.characters.toList().removeAt(letterIndex);
    // print('Word list');
    List<String> newWord2List = newWord2.characters.toList();
    newWord2List.removeAt(letterIndex);
    List<String> newWord1List = newWord1.characters.toList();
    newWord1List.removeAt(0);
    //Need to conver the array to string
    // print('Word valid ${newWord2List.join('')}');
    return _checkWordInWord(newWord1List.join(''), newWord2List.join(''));
    //return true;
  }
}



  //Performs word matching
  _matchWords(wordText) {
    print('three seconds passed');
    print(wordText);
    String testStr = '3';
    String nonogramWord = _nonogramProvider!.nonogram.word;


    for(int i=3;i<10;i++) {
      //final String regExStr = '\b\\w{$i}\b';
      final RegExp? regEx = regExMap[i];
      print('$i letter matches');
      regEx!.allMatches(wordText.toLowerCase()).forEach((word) { 
        bool validWord = true; 
        // word.group(0).toString().characters.forEach((letter) {  
        //   if(!nonogramWord.contains(letter)) {
        //     print('$letter NOT IN WORD');
        //     validWord = false;
        //   }
        // });
        if(_checkWordInWord(word.group(0).toString(), nonogramWord)) {
          //Add the word
          print(word.group(0));
          _nonogramProvider!.addNLetterWord(i,word.group(0).toString());
        } else {
          print('INVALID ${word.group(0)}');
        }

      });
    }
  }

  _readWords(val) {
    print('Reading words here');
    //print(_inputContoller.text);
    if(_timer != null) {
      _timer!.cancel();
      _timer = Timer(Duration(seconds: 3), () {
          _matchWords(val);
        }
      );
    } else {
      _timer = Timer(Duration(seconds: 3), () {
          _matchWords(val);
        }
      );
    }

    // _timer = Timer(Duration(seconds: 3), () {
    //     print('three seconds passed');
    //     print(val);
    //   }
    // );


    // _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
    //   print('one second passed');
    //   print(val);
    // });
    // for(int i=3;i<10;i++) {
    //   //final String regExStr = '\b\\w{$i}\b';
    //   final regEx = RegExp(r'\b\w{' + i.toString() + '}\b',multiLine: true);
    //   print(regEx.allMatches(val));
    // }
    
  }

  @override
  Widget build(BuildContext context) {
    _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);
    _checkWordInWord('kkeey','emskkyeok');

    return Column(
      children: [
        Form(
          key: _formKey,
          child: TextFormField(
                    //initialValue: '',
                    controller: _inputContoller,
                    onChanged: (value) { _readWords(value); },
                    decoration: const InputDecoration(labelText: 'Enter words below:'),
                    keyboardType: TextInputType.text,
                    //validator: (value) => Validators.validText(value),
                    onSaved: (value) { _wordsString = value; },
                  ),
        ),
        ElevatedButton(
          onPressed: _saveForm, 
          child: const Text('Score')
        )
      ],
    );
  }
}