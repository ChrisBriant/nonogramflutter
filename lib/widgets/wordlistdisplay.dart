import 'package:flutter/material.dart';

class WordListDisplay extends StatelessWidget {
  final List<String> wordList;

  const WordListDisplay({
    Key? key,
    required this.wordList,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children:
          wordList.map((e) {
            return Container(
              child:Text(e),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            );}).toList()
        ),
    );
  }
}
