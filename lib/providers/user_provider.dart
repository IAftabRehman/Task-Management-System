import 'package:flutter/material.dart';

class user_provider with ChangeNotifier{
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void changeIndex(int newIndex) {
    _selectedIndex = newIndex;
    notifyListeners();
  }


}