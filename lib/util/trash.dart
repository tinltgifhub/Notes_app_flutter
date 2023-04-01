import 'package:flutter/material.dart';

class TrashItem extends StatelessWidget {
  String title;
  String content;
  VoidCallback onRestore;
  VoidCallback onCancel;

  TrashItem({
    super.key,
    required this.title,
    required this.content,
    required this.onRestore,
    required this.onCancel,
    });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return AlertDialog(
      contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
      content: Container(
        height: screenHeight*0.7,
        width: screenWidth*0.8,

        child:Column(children: [
          Expanded(
            flex: 12,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: screenWidth*0.03,vertical: screenHeight*0.01),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.green,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(8),
                ),
              // color: Colors.blue,
              alignment: Alignment.center,
              // padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
              child:SingleChildScrollView(
                child: Text(
                  title,
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),

          Expanded(
            flex: 75,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.green,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                alignment: Alignment.topLeft,
                margin: EdgeInsets.symmetric(horizontal: screenWidth*0.031),
                padding: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                child: 
                SingleChildScrollView(child: Text(
                  content,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ),
              ),
            ),

            Expanded(
              flex: 10,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: screenWidth*0.03),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                  ElevatedButton(
                    onPressed: onRestore,
                    child: Icon(Icons.restart_alt_outlined,color: Colors.black,),
                    // backgroundColor: Colors.blue,
                  ),
                  SizedBox(width: screenWidth*0.01,),
                  ElevatedButton(
                    onPressed: onCancel, 
                    child: Text('x',style: TextStyle(fontSize: 25,color: Colors.black,fontWeight: FontWeight.w400),),
                    // backgroundColor: Colors.blue,
                  ),
                ],),
              ),
            )
        ],)
      ),
    );
  }
}