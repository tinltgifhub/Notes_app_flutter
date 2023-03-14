import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class noteLists extends StatelessWidget {
  final String title;
  final String content;
  Function(BuildContext)?openNote;
  // final bool taskCompleted;
  // Function(bool?)?onChanged;
  Function(BuildContext)?deleteFunction;
  bool isSelected;

  noteLists({super.key,
    required this.title,
    required this.content,
    // required this.taskCompleted,
    // required this.onChanged,
    required this.deleteFunction,
    required this.openNote,
    this.isSelected=false,
    });

  void _handleTap(BuildContext context) {
    if (openNote != null) {
      openNote!(context);
      isSelected=true;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth*0.04,
        right: screenWidth*0.04,
        bottom: screenHeight*0.015),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children:[
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red,
              borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
      child: GestureDetector(
        onTap:()=>_handleTap(context),
        behavior: HitTestBehavior.translucent,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          padding: EdgeInsets.all(0),
          decoration: BoxDecoration(
            border: Border.all(
              color:Colors.blue,
              width: 2.3,
            ),
            borderRadius: BorderRadius.circular(12),
          ), 
          child:Column(          
            
            children:[ 
              // Checkbox(
              //   value: taskCompleted, 
              //   onChanged: onChanged,
              //   activeColor: Colors.black38,
              //   ),
              ListTile(
                title:Text(
                  title,
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                    color: false
                    ? Colors.black38:Colors.black,
                  ),
                ),
                subtitle: Text(
                  content,
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: false
                    ? Colors.black38:Colors.black,
                  ),
                  maxLines: 4,
                  ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}