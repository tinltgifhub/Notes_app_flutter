import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_flutter/data/database.dart';
import 'package:learn_flutter/util/newNote.dart';
import 'package:learn_flutter/util/noteLists.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// 0 title
// 1 content 
// 2 type
// 3 id 
// 4 time
// 5 isEdit
// 6 isSelect

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
  final search_text=TextEditingController();
  int searchbox_size=5;
  List <String> List_selected=[];
  bool isSelectMode=false;
  bool sort_by=true;

  @override

  void initState() {
    // TODO: implement initState
    if(_mybox.get('TODOLIST')==null){
      db.createInitialData();
    }else{
      db.loadData();
    }
    sort_list();
    super.initState();
  }


  void saveNewNote(){
    setState(() {
      String id=DateTime.now().toString().trim();
      id=id.replaceAll(new RegExp(r'[-:,. ]'), '');
      db.toDoList.add([title_controller.text,content_controller.text,1,id,DateTime.now(),false,false]);
      title_controller.clear();
      content_controller.clear();
    });
    db.updateDataBase();
    sort_list();
    Navigator.of(context).pop();
  }

  void saveNote(String id){
    db.toDoList.forEach((element) {
      if(element[3]==id)
      {
        element[0]=title_controller.text;
        element[1]=content_controller.text;
        element[4]=DateTime.now();
        element[5]=true;
      }
    });
    db.updateDataBase();
    sort_list();
    Navigator.of(context).pop();
  }

  void handleOnCancel(){
    setState(() {
      title_controller.clear();
      content_controller.clear();
    });
    // print(db.toDoList);
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

  void deleteNote(String id){
    setState(() {
      // int idx=db.toDoList.indexWhere((element) => element[3]==id);
      // db.toDoList.removeAt(idx);
      db.toDoList.removeWhere((element) => element[3]==id);
    });
    db.updateDataBase();
  }

  void openNote(String id){
    if(isSelectMode){
      setState(() {
        if(List_selected.contains(id))
          List_selected.remove(id);
        else List_selected.add(id);
        db.toDoList.forEach((element) {
          if(element[3]==id){
            element[6]=!element[6];
          }
        });
      });
      return;
    }
    setState(() {
      var temp=db.toDoList.firstWhere((element) => element[3]==id);
      title_controller.text=temp[0];
      content_controller.text=temp[1];
    });
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context){
        return newNote(
          title_controller: title_controller ,
          content_controller: content_controller,
          onSave:()=>saveNote(id),
          onCancel: handleOnCancel,
        );
      }
    ));
  }

  void sort_list(){
    setState(() {
      if(sort_by){
        db.toDoList.sort((a,b)=>a[4].compareTo(b[4]));
        // db.updateDataBase();
      }
      else{
        db.toDoList.sort((a,b)=>b[4].compareTo(a[4]));
        // db.updateDataBase();
      }
    });
  }
  
  void handle_search(String text){
    text=text.trim();
    setState(() {
      if(text.length==0)
      {
        db.loadData();
        return;
      }
      db.toDoList=db.toDoList.where((element) =>
        element[0].toLowerCase().contains(text.toLowerCase())||
        element[1].toLowerCase().contains(text.toLowerCase())
      ).toList();
    });
  }

  void handleLove(String id){
    setState(() {
      db.toDoList.forEach((element) {
        if(element[3]==id){
          element[2]==0?element[2]=1:element[2]=0;
        }
      });
    });
    db.updateDataBase();
  }

  void handleSelect(String id){
    setState(() {
      isSelectMode=true;
      List_selected.add(id);
      db.toDoList.forEach((element) {
        if(element[3]==id){
          element[6]=true;
        }
      });
    });
  }
  
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      // appBar: AppBar(
      //   title: Text('TO DO',
      //     style: TextStyle(
      //       color: Colors.blue,
      //       fontSize: 35,
      //       fontWeight: FontWeight.w800,
      //     ),
      //   ),
      //   toolbarHeight: 70,
      //   centerTitle: true,
      //   elevation: 0,
      //   backgroundColor: Colors.transparent,
      //   ),

      floatingActionButton: FloatingActionButton(
        onPressed:createNewNote,
        child: Icon(Icons.add),
        ),

      body:GestureDetector( 
        behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).unfocus();
        setState(() {
          search_text.clear();
          db.loadData();
          isSelectMode=false;
          List_selected.clear();
          db.toDoList.forEach((element) {element[6]=false;});
        });
        searchbox_size=5;
      },
        child: Container( 
        margin: EdgeInsets.only(top: screenHeight*0.03),
        child:Column(
          children:[
            Expanded(
              flex: 5,
              child: Container(
                // color: Colors.red,
                child: Row(
                  children:[
                    Text(
                      "HELLO TINLT",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                  ],                
                ),
              ),
            ),

            Expanded(
              flex: searchbox_size,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth*0.04),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue,
                    width: 3,
                  ),
                  borderRadius: BorderRadius.circular(10),
                ),
                child:Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: TextField(
                        controller: search_text,
                        autocorrect: false,
                        onChanged:(text){handle_search(text);},
                        decoration: InputDecoration(border: InputBorder.none), 
                        style: TextStyle(fontSize: 20),
                        textAlignVertical: TextAlignVertical.center,
                        onTap:()=>searchbox_size=8,
                      ),
                    ),
                    Expanded(flex: 1, child: Icon(Icons.search))
                  ],
                ),
              ),
            ),

            Expanded(
              flex: 5,
              child: Container(
                // color: Colors.red,
                margin: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text("Sort by time | ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                    GestureDetector(
                      onTap:(){
                        setState(() {
                          sort_by=!sort_by;
                        });
                        sort_list();
                      },
                      child:Text(sort_by?'Earliest':'Latest',style: TextStyle(fontSize: 20,fontWeight: FontWeight.w700),),
                    ),
                  ],
                ),
              ),
            ), 

            Expanded(
              flex: 70,
              child:Container(
                // color: Colors.amber,
                child:
                ListView.builder(
                  padding: EdgeInsets.only(top: screenHeight*0.01),
                  itemCount: db.toDoList.length,
                  itemBuilder: (context, index) {
                    return noteLists(
                      item: db.toDoList[index],
                      query: search_text.text,
                      deleteFunction: (context)=>deleteNote(db.toDoList[index][3]),
                      openNote: ()=>openNote(db.toDoList[index][3]),
                      onLove: ()=>handleLove(db.toDoList[index][3]),
                      selectNote: ()=>handleSelect(db.toDoList[index][3]),
                      isSelect: isSelectMode,
                    );
                  },
                ),
              ),
            ),
          ], 
        ),
      ),
      ),
    );
  }
}