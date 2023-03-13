import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_flutter/data/database.dart';
import 'package:learn_flutter/util/newNote.dart';
import 'package:learn_flutter/util/noteLists.dart';
import 'package:flutter/services.dart';



class HomePage extends StatefulWidget {
  

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final _mybox=Hive.box('mybox');

  ToDoDataBase db=ToDoDataBase();

  final title_controller=TextEditingController();
  final content_controller=TextEditingController();

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

  // void checkBoxChanged(bool? value,int index){
  //     setState(() {
  //       db.toDoList[index].isDone=!db.toDoList[index].isDone;
  //     });
  //     db.updateDataBase();
  // }

  void saveNewNote(){
    setState(() {
      db.toDoList.add([title_controller.text,content_controller.text,1]);
      title_controller.clear();
      content_controller.clear();
    });
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void saveNote(int index){
    db.toDoList[index][0]=title_controller.text;
    db.toDoList[index][1]=content_controller.text;
    db.updateDataBase();
    Navigator.of(context).pop();
  }

  void handleOnCancel(){
    setState(() {
      title_controller.clear();
      content_controller.clear();
    });
    Navigator.of(context).pop();
    }

  void createNewNote(){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
        return newNote(
          title_controller: title_controller ,
          content_controller: content_controller,
          onSave: saveNewNote,
          onCancel: handleOnCancel,
        );
      }
    ));
  }

  void deleteNote(int index){
    setState(() {
      db.toDoList.removeAt(index);
    });
    db.updateDataBase();
  }

  void openNote(int index){
    setState(() {
      title_controller.text=db.toDoList[index][0];
      content_controller.text=db.toDoList[index][1];
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
        return newNote(
          title_controller: title_controller ,
          content_controller: content_controller,
          onSave:()=>saveNote(index),
          onCancel: handleOnCancel,
        );
      }
    ));
  }


  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

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
        onPressed:createNewNote,
        child: Icon(Icons.add),
        ),

      body: Container( 
        margin: EdgeInsets.only(top: 0),
        child: ListView.builder(
          itemCount: db.toDoList.length,
          itemBuilder: (context, index) {
            return noteLists(
              title: db.toDoList[index][0],
              content: db.toDoList[index][1],
              // taskCompleted: db.toDoList[index].isDone,
              // onChanged: (value)=>checkBoxChanged(value,index),
              deleteFunction: (context)=>deleteNote(index),
              openNote: (context)=>openNote(index),
            );
            },
        ), 
      ),
    );
  }
}