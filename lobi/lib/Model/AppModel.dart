import 'package:flutter/material.dart';

class AppModel extends ChangeNotifier {
  String _scrKey ="";
  String get srcKey => _scrKey;
 
  void setKey(String key) {
    _scrKey = key;
  }

}