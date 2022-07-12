// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/nonogram_provider.dart';
import './wordlistdisplay.dart';
import '../environment.dart';


class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: true);

    return Drawer(
      backgroundColor: Environment().appDrawerBackgroundColor,
      child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 50,),
          const Text(
            'My Found Words',
            style: TextStyle(fontSize: 22),
          ),
          WordSection(wordCount: 3, words: _nonogramProvider.nonogram.foundWords[3]),
          WordSection(wordCount: 4, words: _nonogramProvider.nonogram.foundWords[4]),
          WordSection(wordCount: 5, words: _nonogramProvider.nonogram.foundWords[5]),
          WordSection(wordCount: 6, words: _nonogramProvider.nonogram.foundWords[6]),
          WordSection(wordCount: 7, words: _nonogramProvider.nonogram.foundWords[7]),
          WordSection(wordCount: 8, words: _nonogramProvider.nonogram.foundWords[8]),
          WordSection(wordCount: 9, words: _nonogramProvider.nonogram.foundWords[9]),
        ]
      )
      ),
    );
  }
}

class WordSection extends StatelessWidget {
  final List<String> words;
  final int wordCount;

  const WordSection({ 
    required this.words,
    required this.wordCount,
    Key? key 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: prefer_is_empty
    if(words.length <= 0) {
      return const SizedBox(height: 0,);
    }
    return Column(children: [
                const SizedBox(height: 50,),
                Text(
                  '${wordCount.toString()} Letter Words',
                  style: const TextStyle(fontSize: 20),
                ),
                WordListDisplay(background: Environment().appDrawerBackgroundColor, wordList: words),
                const Divider(),
    ]);
  }
}