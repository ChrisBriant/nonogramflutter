import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nonogram_provider.dart';
import '../widgets/nonogram.dart';
import '../widgets/wordinput.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Nonogram'),),
      body: SingleChildScrollView(
        child: FutureBuilder<bool>(
          future: _nonogramProvider.getNonogram(),
          builder: (ctx,sn) => sn.connectionState == ConnectionState.waiting
            ? CircularProgressIndicator()
            : Consumer<NonogramProvider>(builder: (ctx,data,_) => Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  NonogramWidget(word: data.nonogram.word),
                  const WordInput(),
                ],
              )
            ),
          ),
      ),
    );
  }
}