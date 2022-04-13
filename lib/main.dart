import 'package:book_track/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BookTracker',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GetStartedPage(),
    );
  }
}

