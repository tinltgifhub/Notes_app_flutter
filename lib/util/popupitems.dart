import 'package:flutter/material.dart';

class PopupItemss extends StatelessWidget {
  final String text;
  final IconData ic;
  final bool bor;

  const PopupItemss({
    super.key,
    required this.text,
    required this.ic,
    this.bor=true,
    });

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Container(
      width: screenWidth*0.346,
      height: screenHeight*0.05,
      decoration: BoxDecoration(
        border: Border(
          bottom: bor? BorderSide(
            color: Colors.pink,
            width: 2.0,
          ):BorderSide.none,
        ),
        // color: Colors.red,
      ),
      child:Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Text(
            text,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.pink,
            ),
            ),
          Icon(
            ic,
            size: 25,
            color: Colors.pink,
            ),
        ]
      )
    );
  }
}