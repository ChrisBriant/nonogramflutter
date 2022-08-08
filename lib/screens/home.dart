import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nonogram_provider.dart';
import '../widgets/nonogram.dart';
import '../widgets/wordinput.dart';
import '../widgets/appdrawer.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);
  static String routeName = '/home'; 

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);

    return Scaffold(
      drawer: const AppDrawer(),
      body: SingleChildScrollView(
        child: FutureBuilder<Nonogram?>(
          future: _nonogramProvider.getNonogram(),
          builder: (ctx,sn) => sn.connectionState == ConnectionState.waiting
            ? Container(height: 300,child: Center(child: const CircularProgressIndicator()))
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
                      padding: const EdgeInsets.symmetric(vertical: 10) ,
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
            : Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisSize: MainAxisSize.min,
                children: [
                  NonogramWidget(word: _nonogramProvider.nonogram.word),
                  const WordInput()
                ],
              ),
            ),
      ),
        );
  }
}