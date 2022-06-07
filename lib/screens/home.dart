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

    return Scaffold(
      //appBar: AppBar(title: const Text('Nonogram'),),
      resizeToAvoidBottomInset: false, 
      drawer: AppDrawer(),
      body: FutureBuilder<bool>(
        future: _nonogramProvider.getNonogram(),
        builder: (ctx,sn) => sn.connectionState == ConnectionState.waiting
          ? const CircularProgressIndicator()
          : Consumer<NonogramProvider>(builder: (ctx,data,_) => Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  NonogramWidget(word: data.nonogram.word),
                  ChangeNotifierProvider(
                    create: (ctx) => TextProvider(),
                    child: const WordInput(),
                  )
                ],
              ),
              ChangeNotifierProvider(
                create: (ctx) => TextProvider(),
                child: Column(children: [
                  SizedBox(height: MediaQuery.of(context).size.height *0.2,),
                  Consumer<TextProvider>(builder: (ctx,data,_) => data.displayFloatingWords
                    ? WordsFloatingDisplay()
                    : SizedBox(height: 0,),
                  ) 
                ]),
              )
            ]
          )
          ),
        ),
    );
  }
}