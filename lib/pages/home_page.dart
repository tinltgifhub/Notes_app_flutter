import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:learn_flutter/data/database.dart';
import 'package:learn_flutter/pages/recycle_bin.dart';
import 'package:learn_flutter/util/my_button.dart';
import 'package:learn_flutter/util/newNote.dart';
import 'package:learn_flutter/util/noteLists.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:learn_flutter/util/popupitems.dart';
import 'recycle_bin.dart';


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
  final _trashBox=Hive.box('trashBox');

  ToDoDataBase db=ToDoDataBase();

  final title_controller=TextEditingController();
  final content_controller=TextEditingController();
  final search_text=TextEditingController();
  int searchbox_size=5;
  List <String> List_selected=[];
  bool isSelectMode=false;
  bool sort_by=true;
  List <dynamic> Note_List=[];


  @override

  void initState() {
    // TODO: implement initState

    if(_mybox.get('TODOLIST')==null&&_trashBox.get('TRASHLIST')==null){
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
    var targetElement = db.toDoList.firstWhere((element) => element[3] == id, orElse: () => null);
    targetElement[0] = title_controller.text;
    targetElement[1] = content_controller.text;
    targetElement[4] = DateTime.now();
    targetElement[5] = true;
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
      var removedItem = db.toDoList.firstWhere((element) => element[3] == id);  
      db.toDoList.remove(removedItem);
      db.trashList.add(removedItem);
      Note_List.remove(removedItem);
    });
    db.updateDataBase();
    db.updateTrashDataBase();
    print(db.trashList);
  }

  void openNote(String id){
    if(isSelectMode){
      setState(() {
        if(List_selected.contains(id))
          List_selected.remove(id);
        else List_selected.add(id);
        var targetElement = db.toDoList.firstWhere((element) => element[3]==id);
        targetElement[6] = !targetElement[6];
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
      }
      else{
        db.toDoList.sort((a,b)=>b[4].compareTo(a[4]));
      }
    });
    Note_List=List.from(db.toDoList);
  }
  
  void handle_search(String text){ 
    text=text.trim();
    setState(() {
      if(text.length==0)
      {
        Note_List=List.from(db.toDoList);
        return;
      }
      Note_List=db.toDoList.where((element) =>
        element[0].toLowerCase().contains(text.toLowerCase())||
        element[1].toLowerCase().contains(text.toLowerCase())
      ).toList();
    });
  }

  void handleLove(String id){
    setState(() {
      var a=db.toDoList.firstWhere((element) => element[3] == id);
      a[2]==1?a[2]=0:a[2]=1;
    });
    db.updateDataBase();
  }

  void handleSelect(String id){
    if(search_text.text.length>0)
      return;
    setState(() {
      isSelectMode=true;
      List_selected.add(id);
      db.toDoList.firstWhere((element) => element[3]==id)[6]=true;
    });
  }

  void deleteMultiItems(){
    setState(() {
      List<dynamic> removedItems =db.toDoList.where((element) => List_selected.contains(element[3])).toList();
      db.toDoList.removeWhere((element) => List_selected.contains(element[3]));
      db.trashList.addAll(removedItems);    
      db.updateDataBase();
      db.updateTrashDataBase();
      Note_List.removeWhere((element) => List_selected.contains(element[3]));
    });
  }


  void handleFavorite(int vl){
    setState(() {
      if(vl==0){
        Note_List=Note_List.where((element) => element[2]==vl).toList();
      }else{
        sort_list();
      }
      
    });
  }

  void handleRecycleBin() {
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => RecycleBin()),
  );
}

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 255, 255, 255),

      floatingActionButton: !isSelectMode?
      FloatingActionButton(
        onPressed:createNewNote,
        child: Icon(Icons.add),
        ):null,

      body:GestureDetector( 
        behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).unfocus();
        setState(() {
          if(search_text.text.length>0){
            search_text.clear();
            Note_List=db.toDoList;
          };
          isSelectMode=false;
          List_selected.clear();
          db.toDoList.forEach((element) {element[6]=false;});
        });
        searchbox_size=5;
      },
        child: Container( 
        margin: EdgeInsets.only(top: screenHeight*0.03),
        child: Column(
          children:[
            Expanded(
              flex: 6,
              child: Container(
                margin: EdgeInsets.only(left: screenWidth*0.05,right: screenWidth*0.03),
                // color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children:[
                    Text(
                      "HELLO TINLT",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w500
                      ),
                    ),
                    PopupMenuButton(
                      onSelected: (value)=>{if(value==3) handleRecycleBin()},
                      icon: Icon(Icons.add_circle_outline,size: 35,color: Colors.blue,),
                      itemBuilder:(context)=>[
                        PopupMenuItem(
                          onTap:()=>handleFavorite(1),
                          child: PopupItemss(
                            text: "Notes",
                            ic: Icons.mode_edit,
                          ),
                          value: 1,
                        ),
                        PopupMenuItem(
                          onTap:()=>handleFavorite(0),
                          child: PopupItemss(
                            text: "Favorite",
                            ic: Icons.favorite,
                          ),
                          value: 2,
                        ),
                        PopupMenuItem(
                          child: PopupItemss(
                            text: "Recycle Bin",
                            ic: Icons.delete,
                          ),
                          value: 3,
                        ),
                      ]
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
                // color: isSelectMode?Colors.black12:Colors.transparent,
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
                // margin: EdgeInsets.symmetric(horizontal: screenWidth*0.08),
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
              flex: 68,
              child: Stack(
                children:[
                  Container(
                    color: isSelectMode?Colors.black12:Colors.transparent,
                    child:
                    ListView.builder(
                      padding: EdgeInsets.only(top: screenHeight*0.01),
                      itemCount: Note_List.length,
                      itemBuilder: (context, index) {
                        return noteLists(
                          item: Note_List[index],
                          query: search_text.text,
                          deleteFunction: (context)=>deleteNote(Note_List[index][3]),
                          openNote: ()=>openNote(Note_List[index][3]),
                          onLove: ()=>handleLove(Note_List[index][3]),
                          selectNote: ()=>handleSelect(Note_List[index][3]),
                          isSelect: isSelectMode,
                        );
                      },
                    ),
                  ),
                  Positioned(
                    bottom: screenWidth*0.02,
                    left: screenWidth*0.04,
                    right: screenWidth*0.04,
                    top: screenWidth*1.4,
                    child:isSelectMode?
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.red,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                            onPressed: deleteMultiItems, 
                            child: Icon(
                              Icons.delete,
                              size: 25,
                              ),
                            style: ButtonStyle(
                              fixedSize: MaterialStateProperty.all(Size(20, 50)),
                              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)
                              ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
                    :
                    Container(),
                  ),
            ],),
            ),
          ], 
        ),
      ),
      ),
    );
  }
}