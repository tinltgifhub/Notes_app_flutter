import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class ToDoTile extends StatelessWidget {
  final String taskName;
  final bool taskCompleted;
  Function(bool?)?onChanged;
  Function(BuildContext)?deleteFunction;

  ToDoTile({super.key,
    required this.taskName,
    required this.taskCompleted,
    required this.onChanged,
    required this.deleteFunction,
    });

  @override
  Widget build(BuildContext context) {
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
        padding: EdgeInsets.all(10),
        child:Row( 
          children:[ 
            Checkbox(
              value: taskCompleted, 
              onChanged: onChanged,
              activeColor: Colors.black38,
              ),
            Text(
              taskName,
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 20,
                color: taskCompleted
                ? Colors.black38:Colors.black,
              ),
            ),
          ],
          ),
          decoration: BoxDecoration(
            color:taskCompleted? Colors.black38:Colors.blue,
            borderRadius: BorderRadius.circular(12),
          ),
      
      ),
      ),
    );
  }
}