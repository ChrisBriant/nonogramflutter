import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import '../environment.dart';

class NonogramProvider with ChangeNotifier {
  static const String BASEURL = 'https://nonogram-api.cb-arcade.co.uk/api';

  Nonogram? _nonogram;

  //API CALLS
  Future<bool> getNonogram() async {
    Map<String, String> _headers = {
        'Authorization' : Environment().apiKey,
        'Content-Type': 'application/json'
    };

    final _uri = Uri.parse('${BASEURL}/getnonogram/');
    var _res = await http.get(_uri, headers: _headers);

    if(_res.statusCode == 200) {
      //Set the nonogram data
      final _responseData = json.decode(_res.body);
      _nonogram = Nonogram(id: _responseData['id'], word: _responseData['word']);
      return true;
    }  else {
      return false;
    }
  }

  Future<bool> sendWords(wordString) async {
    print('Sending Words');
    print(wordString);
    return true;
  }

  //GET METHODS
  get nonogram {
    return _nonogram;
  }
}

class Nonogram {
  int id;
  String word;

  Nonogram({
    required this.id,
    required this.word
  });
}