import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/nonogram_provider.dart';
import '../widgets/nonogram.dart';

class Home extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    final _nonogramProvider = Provider.of<NonogramProvider>(context,listen: false);

    return Scaffold(
      appBar: AppBar(title: const Text('Nonogram'),),
      body: FutureBuilder<bool>(
        future: _nonogramProvider.getNonogram(),
        builder: (ctx,sn) => sn.connectionState == ConnectionState.waiting
          ? CircularProgressIndicator()
          : Consumer<NonogramProvider>(builder: (ctx,data,_) => Column(
              //crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                NonogramWidget(word: data.nonogram.word)
                // Text(data.nonogram.id.toString()),
                // Text(data.nonogram.word)
              ],
            )
          ),
        ),
    );
  }
}