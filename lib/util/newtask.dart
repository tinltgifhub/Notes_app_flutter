import 'package:flutter/material.dart';
import 'package:learn_flutter/util/my_button.dart';
import 'package:flutter/services.dart';


class newTask extends StatelessWidget {
  final controller;
  VoidCallback onSave;
  VoidCallback onCancel;

  newTask({
    super.key,
    required this.controller,
    required this.onSave,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
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
      child: Container(
        // color: Colors.red,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
          Flexible(
          child: TextField(
            controller: controller,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Add a new task",
            ),
          ),),
          SizedBox(height: 16.0,),
          Row(
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
        ]),
        ),
        ),
    );
  }
}