import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nonogram_provider.dart';

class WordListDisplay extends StatelessWidget {
  final List<String> wordList;

  const WordListDisplay({
    Key? key,
    required this.wordList,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Wrap(
        children:
          wordList.map((word) {
            return Container(
              child: RichText(
                text: TextSpan(
                  children:word.characters.map((e) { 
                      if(e == _nonogramProvider.nonogram.special ){
                        return TextSpan(
                          text:e,
                          style: TextStyle(
                            color: Colors.purple.shade700,
                            fontSize: 18,
                          )
                        );
                      }
                      return TextSpan(
                        text:e,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                        )
                      );
                    }).toList(),
                    //TextSpan(text:'hello'),
                    //TextSpan(text:'world'),
                  
                ),
              ),
              // child: Row(
              //   children: word.characters.map((e) { 
              //     if(e == _nonogramProvider.nonogram.special ){
              //       return Text(
              //         e,
              //         style: TextStyle(
              //           color: Colors.purple.shade700,
              //         ),
              //       );
              //     }
              //     return Text(e);
              //   }).toList()
              // ),
              //child:Text(e),
              padding: const EdgeInsets.symmetric(horizontal: 2),
            );}).toList()
        ),
    );
  }
}
