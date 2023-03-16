import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';



class linktext extends StatelessWidget {
  final String text;

  linktext({required this.text});

  @override
  Widget build(BuildContext context) {
    final words = text.split(' ');

    final spans = <TextSpan>[];
    bool isLink;
    for (var i = 0; i < words.length; i++) {
      final word = words[i];

      isLink = RegExp(r'^https?:\/\/').hasMatch(word);

      if (isLink) {
        spans.add(
          TextSpan(
            text: word+isLink.toString(),
            style: TextStyle(
              color: Colors.blue,
              decoration: TextDecoration.underline,
            ),
            recognizer: TapGestureRecognizer()
              ..onTap = () async {
                if (await canLaunch(word)) {
                  await launch(word);
                }
              },
          ),
        );
      } else {
        spans.add(
          TextSpan(
            text: word+isLink.toString(),
            style: TextStyle(color: Colors.black),
          ),
        );
      }

      if (i < words.length - 1) {
        spans.add(TextSpan(
          text: ' ',
          style: TextStyle(color: Colors.black),
          ));
      }
    }

    return 
    Container(
      color: Colors.red,
      child: RichText(
        textDirection: TextDirection.ltr,
        text: TextSpan(children: spans),
      ),
    );
  }
}
