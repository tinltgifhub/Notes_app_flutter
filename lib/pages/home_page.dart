import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_flutter/data/database.dart';
import 'package:learn_flutter/util/newNote.dart';
import 'package:learn_flutter/util/todo_tile.dart';
import 'package:flutter/services.dart';



class HomePage extends StatefulWidget {
  

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _mybox=Hive.box('mybox');

  ToDoDataBase db=ToDoDataBase();

  final _controller=TextEditingController();

  @override

  void initState() {
    // TODO: implement initState
    if(_mybox.get('TODOLIST')==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    super.initState();
  }

  void checkBoxChanged(bool? value,int index){
      setState(() {
        db.toDoList[index][1]=!db.toDoList[index][1];
      });
      db.updateDataBase();
  }

  void saveNewTask(){
    setState(() {
      db.toDoList.add([_controller.text,false]);
      _controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void handleOnCancel(){
    setState(() {
      _controller.clear();
    });
    Navigator.of(context).pop();
    }

  void createNewTask(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
        return newNote(
          controller: _controller ,
          onSave: saveNewTask,
          onCancel: handleOnCancel,
        );
      }
    ));
  }

  void deleteTask(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }



  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      appBar: AppBar(
        title: Text('TO DO',
          style: TextStyle(
            color: Colors.blue,
            fontSize: 35,
            fontWeight: FontWeight.w800,
          ),
        ),
        toolbarHeight: 70,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        ),

      floatingActionButton: FloatingActionButton(
        onPressed:createNewTask,
        child: Icon(Icons.add),
        ),

      body: Container( 
        margin: EdgeInsets.only(top: 0),
        child: ListView.builder(
        itemCount: db.toDoList.length,
        itemBuilder: (context, index) {
            return ToDoTile(
              taskName: db.toDoList[index][0],
              taskCompleted: db.toDoList[index][1],
              onChanged: (value)=>checkBoxChanged(value,index),
              deleteFunction: (context)=>deleteTask(index),
            );
        },
      ), 
      ),
    );
  }
}