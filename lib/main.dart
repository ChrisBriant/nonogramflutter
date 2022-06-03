import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './screens/home.dart';
import './providers/nonogram_provider.dart';

void main() {
  runApp(const Nonogram());
}

class Nonogram extends StatelessWidget {
  const Nonogram({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => NonogramProvider()
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Home(),
      )
    );
  }
}

