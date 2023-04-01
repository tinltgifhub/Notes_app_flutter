import 'package:flutter/material.dart';
import 'package:learn_flutter/pages/home_page.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter/services.dart';

void main() async {

  await Hive.initFlutter();

  var box=await Hive.openBox('mybox'); 
  var trash_box=await Hive.openBox('trashBox');

  // SystemChrome.setEnabledSystemUIOverlays([]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context){
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme:ThemeData(primarySwatch: Colors.blue),
      home: HomePage(),
    );
  }
}
