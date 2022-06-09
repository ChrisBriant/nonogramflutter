

import 'package:flutter/widgets.dart';

class TextProvider with ChangeNotifier {
  bool _displayFloatingWords = false;

  set displayFloatingWords(bool val) {
    _displayFloatingWords = val;
  }

  bool get displayFloatingWords {
    return _displayFloatingWords;
  }
}