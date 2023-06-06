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
import 'package:learn_flutter/util/trash.dart';
import 'package:learn_flutter/util/trashList.dart';



class RecycleBin extends StatefulWidget {
  const RecycleBin({super.key});

  @override
  State<RecycleBin> createState() => _RecycleBinState();
}

class _RecycleBinState extends State<RecycleBin> {
  
  ToDoDataBase db=ToDoDataBase();
  @override

  void initState() {
    db.loadData();
    super.initState();
  }

  void dltforever(String id){
    setState(() {
      db.trashList.removeWhere((element) => element[3]==id);
    });
    db.updateTrashDataBase();
  }

  void handleRestore(String id){
    setState(() {
      var restoreItem = db.trashList.firstWhere((element) => element[3] == id);  
      db.trashList.remove(restoreItem);
      db.toDoList.add(restoreItem);
      db.updateDataBase();
      db.updateTrashDataBase();
      Navigator.of(context).pop();
    });
  }

  void openTrash(List item){
    showDialog(
      context: context, 
      builder: (context){
        return TrashItem(
          title: item[0],
          content: item[1],
          onRestore:()=> handleRestore(item[3]),
          onCancel:()=>{ Navigator.of(context).pop()},
        );
      },
    );
  }

  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: GestureDetector(
        child: Container(
          margin: EdgeInsets.only(top: screenHeight*0.04),
          child: Column(children: [
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.only(top: screenHeight*0.02),
                // color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    IconButton(onPressed: (){ Navigator.of(context).pop();}, icon: Icon(Icons.arrow_back)),
                    Text(
                      '           Recycle Bin',
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                      ),
                      ),
                ],)
              ),
            ),
            Expanded(
              flex: 10,
              child: Container(
                child: ListView.builder(
                  padding: EdgeInsets.only(top: screenHeight*0.01),
                  itemCount: db.trashList.length,
                  itemBuilder: (context, index) {
                    return trashList(
                      item:db.trashList[index],
                      deleteFunction: (context)=>dltforever(db.trashList[index][3]),
                      openTrash: ()=>openTrash(db.trashList[index]),
                    );
                  },
                ),
              ),
            ),

          ]),
        ),
      ),
    );
  }
}