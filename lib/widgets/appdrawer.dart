// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/nonogram_provider.dart';
import './wordlistdisplay.dart';


class AppDrawer extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: true);

    return Drawer(
      backgroundColor: Colors.amber.shade200,
      child: SingleChildScrollView(
        child: Container(
            child: Column(
              children: [
                const SizedBox(height: 50,),
                const Text(
                  'My Found Words',
                  style: TextStyle(fontSize: 22),
                ),
                const SizedBox(height: 50,),
                const Text(
                  '3 Letter Words',
                  style: TextStyle(fontSize: 20),
                ),
                WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[3]),
                const Divider(),
                const SizedBox(height: 50,),
                // const Text(
                //   '4 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[4]),
                // const Divider(),
                // const SizedBox(height: 50,),
                // const Text(
                //   '5 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[5]),
                // const Divider(),
                // const SizedBox(height: 50,),
                // const Text(
                //   '6 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[6]),
                // const Divider(),
                // const SizedBox(height: 50,),
                // const Text(
                //   '7 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[7]),
                // const Divider(),
                // const SizedBox(height: 50,),
                // const Text(
                //   '8 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[8]),
                // const Divider(),
                // const SizedBox(height: 50,),
                // const Text(
                //   '9 Letter Words',
                //   style: TextStyle(fontSize: 22),
                // ),
                // WordListDisplay(wordList: _nonogramProvider.nonogram.foundWords[9]),
                // const Divider(),
                // const SizedBox(height: 50,),
              ]
            )
          ),
      ),
    );
  }
}

// class WordListDisplay extends StatelessWidget {
//   final List<String> wordList;

//   const WordListDisplay({
//     Key? key,
//     required this.wordList,
//   }) : super(key: key);


//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Row(
//         children:
//           wordList.map((e) {
//             return Container(
//               child:Text(e),
//               padding: EdgeInsets.symmetric(horizontal: 2),
//             );}).toList()
//         ),
//     );
//   }
// }
