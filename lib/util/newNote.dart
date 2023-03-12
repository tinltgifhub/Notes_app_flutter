import 'package:flutter/material.dart';
import 'package:learn_flutter/util/my_button.dart';
import 'package:flutter/services.dart';


class newNote extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  newNote({
    super.key,
    required this.controller,
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
                flex: 1,
                child: Container(
                  color: Colors.green,
                  child: Flexible(
                    child: TextField(
                      textAlign: TextAlign.center,
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
                flex: 8,
                child:Container(
                  color: Colors.lightBlue,
                  child:Flexible(
                    child: TextField(
                      controller: controller,
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
                flex: 1,
                child: Container(
                  color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
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