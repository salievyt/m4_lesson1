import 'package:flutter/material.dart';

class CounterModel extends ChangeNotifier{

  int _count = 0;
  String _name = "";
  String _desc = "";


  int get count => _count;
  String get name => _name;
  String get desc => _desc;
  
  void increment(){
    _count++;
    notifyListeners();
  }

  void setName(String text){
    _name = text;
    notifyListeners();
  }

  void setDesc(String text){
    _desc = text;
    notifyListeners();
  }

}