import 'package:flutter/material.dart';

class NonogramWidget extends StatelessWidget {
  final String word;

  const NonogramWidget({ 
    Key? key,
    required this.word 
  }) : super(key: key);

  List<List> getRows(String word) {
    int rowLength = word.characters.length ~/ 3;
    List<List> rows = [];
    for(int i=0; i<rowLength; i++) {
      rows.add(word.characters.skip(rowLength*i).take(rowLength).toList());
    }
    return rows;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 200, 226, 188),
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
          Column(
            children: getRows(word).asMap().entries.map((group) { return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: group.value.asMap().entries.map((e) { 
                  //Get special character
                  Color bgColor;
                  if(group.key == 1 && e.key == 1) {
                    bgColor = Colors.purple.shade200;
                  } else {
                    bgColor = Colors.amber.shade200;
                  }
                  return  Letter(letter: e.value, bgColor: bgColor,); 
                }).toList()
            );}).toList(),
          ),
          TextButton(
            onPressed: () { Scaffold.of(context).openDrawer(); }, 
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.arrow_back,
                  color: Colors.deepOrange.shade700,
                ),
                Text(
                  'View my Words',
                  style: TextStyle(
                    color: Colors.deepOrange.shade700
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class Letter extends StatelessWidget {
  final String letter;
  final Color bgColor;

  const Letter({ 
      Key? key,
      required this.letter,
      required this.bgColor,
    
    }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double boxDimension = (MediaQuery.of(context).size.width - MediaQuery.of(context).size.width * .2) / 3;

    return Container(
      width: boxDimension,
      height: boxDimension,
      alignment: Alignment.bottomCenter,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        color: bgColor,
      ),
      child:Padding(
        padding: const EdgeInsets.all(4),
          child: Text(letter, style: TextStyle(
            fontSize: boxDimension - boxDimension * .3,
          ),
        ), 
      ),
    );
  }
}