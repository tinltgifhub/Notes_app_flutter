import 'package:flutter/material.dart';
import 'package:learn_flutter/util/my_button.dart';
import 'package:flutter/services.dart';


class newNote extends StatelessWidget {
  final title_controller,content_controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  newNote({
    super.key,
    required this.title_controller,
    required this.content_controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.blue,
      //   centerTitle: true,
      //   title: Text("New Task"),
      //   elevation: 0.0,
      // ),
      backgroundColor: Colors.white,
      body:GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap:() {
        FocusScope.of(context).unfocus();
      },
      child: 
        Container(
          padding: EdgeInsets.only(top:screenHeight*0.03),
        // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: 12,
                child: Container(
                  // color: Colors.green,
                  margin: EdgeInsets.symmetric(vertical: screenHeight*0.01,horizontal: screenWidth*0.03),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.3,
                      ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Flexible(
                    child: TextField(
                      controller: title_controller,
                      textAlign: TextAlign.center,
                      autofocus: true,
                      style: TextStyle(                  
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                        border: InputBorder.none,
                        hintText: "Title...",
                      ),
                    ),
                  ),
                ),
              ),

              Expanded(
                flex: 78,
                child:Container(
                  margin: EdgeInsets.symmetric(vertical: screenHeight*0.01,horizontal: screenWidth*0.03),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.3,
                      ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  // color: Colors.lightBlue,
                  child:Flexible(
                    child: TextField(
                      controller: content_controller,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                        border: InputBorder.none,
                        hintText: "Content...",
                      ),
                    ),
                  ),
                ),
              ),


              Expanded(
                flex: 10,
                child: Container(
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // IconButton(onPressed: () => {}, icon: Icon(Icons.add)),
                      MyButton(
                        text: "Save", 
                        onPressed: onSave),
                      MyButton(
                        text: "Cancel", 
                        onPressed: onCancel),
                    ],
                  ),
                ),
              ),
            ]
          ),
        ),
      ),
    );
  }
}