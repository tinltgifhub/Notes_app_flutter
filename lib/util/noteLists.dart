import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';


class noteLists extends StatelessWidget {
  final item;
  String query;
  
  Function(BuildContext)? deleteFunction;
  
  VoidCallback openNote;
  VoidCallback onLove;
  VoidCallback selectNote;

  bool isSelect;

  noteLists({super.key,
    required this.item,
    required this.query,
    required this.deleteFunction,
    required this.openNote,
    required this.onLove,
    required this.selectNote,
    required this.isSelect,
    // required this.isSelect,
    });

  List<TextSpan> highlightOccurrences(String source, String query) {
    if (query.isEmpty) {
      return [TextSpan(text: source)];
    }

    List<TextSpan> spans = [];
    RegExp regex = RegExp(query, caseSensitive: false);
    Iterable<Match> matches = regex.allMatches(source);

    int lastMatchEnd = 0;
    for (Match match in matches) {
      if (match.start > lastMatchEnd) {
        spans.add(TextSpan(
          text: source.substring(lastMatchEnd, match.start),

          ));
      }
      spans.add(TextSpan(
        text: source.substring(match.start, match.end),
        style: TextStyle(fontWeight: FontWeight.bold, backgroundColor: Colors.blue),
      ));
      lastMatchEnd = match.end;
    }

    if (lastMatchEnd < source.length) {
      spans.add(TextSpan(text: source.substring(lastMatchEnd)));
    }

    return spans;
  }
  

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

  return Stack(
    children: [
      Padding(
        padding: EdgeInsets.only(
          left: screenWidth*0.04,
          right: screenWidth*0.04,
          bottom: screenHeight*0.015),
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
            onTap:openNote,
            onLongPress: selectNote,
            behavior: HitTestBehavior.translucent,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              padding: EdgeInsets.all(0),
              decoration: BoxDecoration(
                color:item[6]? Colors.blue.shade100:Colors.transparent,
                border: Border.all(
                  color:Colors.blue,
                  width: 2.3,
                ),
                borderRadius: BorderRadius.circular(12),
              ), 
              child:Column(               
                children:[ 
                  ListTile(
                    title:RichText(
                      text:TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 23,
                          color: Colors.black,
                          // backgroundColor: Colors.red,
                        ),
                        children: highlightOccurrences(item[0], query),
                      ),
                      maxLines: 2,
                    ),
                    subtitle: RichText(
                      text:TextSpan(
                        style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 15,
                          color: Colors.black,
                          // backgroundColor: Colors.red,
                        ),
                        children: highlightOccurrences(item[1], query),
                      ),
                      maxLines: 2,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: screenWidth*0.03,vertical: screenHeight*0.005),
                    // color: Colors.red,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(item[5]?
                          'Edited at '+DateFormat('dd-MM-yyyy – kk:mm').format(item[4])
                          :
                          'Create at '+ DateFormat('dd-MM-yyyy – kk:mm').format(item[4]),
                          style: TextStyle(fontSize: 13),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),

      !isSelect? Positioned(
        top: 0,
        right: screenWidth*0.04,
        child: IconButton(
          icon: Icon(
            item[2]==0?Icons.favorite:Icons.favorite_border,
            color: Color.fromARGB(255, 255, 107, 156),
            fill: 0.5,
          ),
          splashColor:  Color.fromARGB(255, 255, 107, 156),
          onPressed:onLove,
        ),
      )
      :
      Positioned(
        top: 0,
        right: screenWidth*0.04,
        child: IconButton(
          icon: Icon(
            item[6]?Icons.check_box_outlined:Icons.check_box_outline_blank,
            color: Colors.blue,
            fill: 0.5,
          ),
          splashColor:  Color.fromARGB(255, 60, 180, 255),
          onPressed:(){},
        ),
      ),
    ],
  );
}
}