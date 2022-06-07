import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../environment.dart';

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
    print(getRows(word));

    return Column(
      children: [
        SizedBox(height: 10,),
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
          //children: word.characters.map((e) { return Text(e.toString()); }).toList(),
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
        //   style: ElevatedButton.styleFrom(
        //     primary: Environment().backgroundColor,

        //     // onPrimary: Colors.transparent,
        //     // onSurface: Colors.transparent,
        //     // shadowColor: Colors.transparent
        //   ).merge(
        //     ButtonStyle(
        //       elevation: MaterialStateProperty.resolveWith<double>(
        //         (Set<MaterialState> states) {
        //           if (states.contains(MaterialState.pressed))
        //             return 0;
        //           return 0;
        //         },
        //       ),
        //     ),
        ),
      ],
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
        padding: EdgeInsets.all(4),
          child: Text(letter, style: TextStyle(
            fontSize: boxDimension - boxDimension * .3,
          ),
        ), 
      ),
    );
  }
}