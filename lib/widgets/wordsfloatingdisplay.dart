import 'package:flutter/material.dart';

class WordsFloatingDisplay extends StatelessWidget {
  const WordsFloatingDisplay({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      child: const Text('THIS IS A FLOATING WIDGET'),
      color: const Color.fromARGB(220, 206, 147, 216),
    );
  }
}