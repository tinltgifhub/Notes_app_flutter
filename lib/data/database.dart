import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class ToDoDataBase{
  List toDoList=[];
  final _mybox=Hive.box('mybox');

  void createInitialData(){
    toDoList=[
    ];
  }

  void loadData(){
    toDoList=_mybox.get("TODOLIST");
  }

  void updateDataBase(){
    _mybox.put('TODOLIST', toDoList);
  }
}
