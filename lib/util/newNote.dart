import 'package:flutter/material.dart';
import 'package:learn_flutter/util/linktext.dart';
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
  int size=15;
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
        size=10;
      },
      child: 
        Container(
          padding: EdgeInsets.only(top:screenHeight*0.03),
        // color: Colors.red,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Expanded(
                flex: size,
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
                    child: TextFormField(
                      onTap: () => {size=15},
                      controller: title_controller,
                      autofocus: true,
                      textAlign: TextAlign.center,
                      textAlignVertical: TextAlignVertical.center,
                      // autofocus: true,
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

              // Expanded(
              //   flex:70,
              //   child: linktext(text: content_controller.text,)
              // ),

              Expanded(
                flex: 70,
                child:Container(
                  margin: EdgeInsets.only(
                    left: screenWidth*0.03,
                    right: screenWidth*0.03,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.blue,
                      width: 2.3,
                      ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  // color: Colors.lightBlue,
                  child:Flexible(
                    child: TextFormField( 
                      onTap: () => {size=15},
                      controller: content_controller,
                      // autofocus: true,
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
                  padding: EdgeInsets.only(
                    bottom: screenHeight*0.01,
                    left:screenWidth*0.03,
                    right: screenWidth*0.03,
                    top: screenHeight*0.003,
                    ),
                  // color: Colors.red,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: onSave,
                        child: Icon(Icons.check,color: Colors.black,),
                        // backgroundColor: Colors.blue,
                      ),
                      SizedBox(width: screenWidth*0.01,),
                      ElevatedButton(
                        onPressed: onCancel, 
                        child: Text('x',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w400),),
                        // backgroundColor: Colors.blue,
                      ),
                      // MyButton(
                      //   text: "Save", 
                      //   onPressed: onSave),
                      // MyButton(
                      //   text: "Cancel", 
                      //   onPressed: onCancel),
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