import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nonogram_provider.dart';
import '../providers/textprovider.dart';
import '../widgets/nonogram.dart';
import '../widgets/wordinput.dart';
import '../widgets/appdrawer.dart';
import '../widgets/wordsfloatingdisplay.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);
    //final viewPortHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      //appBar: AppBar(title: const Text('Nonogram'),),
      drawer: AppDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<Nonogram?>(
          future: _nonogramProvider.getNonogram(),
          builder: (ctx,sn) => sn.connectionState == ConnectionState.waiting
            ? const CircularProgressIndicator()
            : sn.hasError
            ? Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                  const Text('Connection Error!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10) ,
                      width: MediaQuery.of(context).size.width * .8,
                      child: Image.asset('assets/images/sad.png',fit: BoxFit.fitWidth, ),
                  ),
                  const Text('Unfortunately we are unable to retrieve the nonogram. Please check that you have Internet connectivity and try again or try again later.',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            )
            :
              //Consumer<NonogramProvider>(builder: (ctx,data,_) => Stack(
              //children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    //mainAxisSize: MainAxisSize.min,
                    children: [
                      NonogramWidget(word: _nonogramProvider.nonogram.word),
                      const WordInput()
                    ],
                  ),
                ),
                // Column(children: [
                //   SizedBox(height: MediaQuery.of(context).size.height *0.2,),
                //   WordsFloatingDisplay()
                // ]) 
              //])
            //)
            ),
      ),
        );
  }
}