import 'package:flutter/material.dart';

class TextInputFieldProvider extends ChangeNotifier {
  String _text = '';

  String get text => _text;

  set text(String value) {
    _text = value;
    notifyListeners();
  }
}
