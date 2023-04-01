import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class trashList extends StatelessWidget {

  final item;
  Function(BuildContext)? deleteFunction;
  VoidCallback openTrash;

  trashList({
    super.key,
    required this.item,
    required this.deleteFunction,
    required this.openTrash,
  });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(
        left: screenWidth*0.04,
        right: screenWidth*0.04,
        bottom: screenHeight*0.015
      ),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(), 
          children:[
            SlidableAction(
              onPressed:deleteFunction,
              icon: Icons.delete,
              backgroundColor: Color.fromARGB(255, 255, 80, 49),
              borderRadius: BorderRadius.circular(12),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: openTrash,
          behavior: HitTestBehavior.translucent,
          child: 
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.green,
                width: 2.3,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(children: [
              ListTile(
                title: Text(
                  item[0],
                  style: TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 23,
                    color: Colors.black,
                  ), 
                  maxLines: 2,
                ),

                subtitle: Text(
                  item[1],
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontSize: 15,
                    color: Colors.black,
                  ),
                  maxLines: 3,
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}