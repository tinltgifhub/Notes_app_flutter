import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ToDoDataBase{
  List toDoList = [];
  List trashList = [];
  final _mybox = Hive.box('mybox');
  final _trashBox = Hive.box('trashBox'); 

  void createInitialData(){
    toDoList=[];
    trashList=[];
  }

  void loadData() {
    try {
      toDoList = _mybox.get("TODOLIST");
      trashList = _trashBox.get("TRASHLIST");  
    } catch (e) {
      if (toDoList.isEmpty) createInitialData();
    }
  }
  
  void updateDataBase(){
    _mybox.put('TODOLIST', toDoList);
  }
  void updateTrashDataBase(){
    _trashBox.put('TRASHLIST', trashList);
  }


}

