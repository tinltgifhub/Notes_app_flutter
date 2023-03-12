import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class noteLists extends StatelessWidget {
  final String title;
  final String content;
  // final bool taskCompleted;
  // Function(bool?)?onChanged;
  Function(BuildContext)?deleteFunction;

  noteLists({super.key,
    required this.title,
    required this.content,
    // required this.taskCompleted,
    // required this.onChanged,
    required this.deleteFunction,
    });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Padding(
      padding: const EdgeInsets.only(left: 15,right: 15,top: 20),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children:[
            SlidableAction(
              onPressed: deleteFunction,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade300,
              borderRadius: BorderRadius.circular(12),
                ),
              ],
            ),
         
      child: Container(
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
    );
  }
}