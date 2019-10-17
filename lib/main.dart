import 'package:flutter/material.dart';
//import 'getscreen.dart';
import 'graphpage.dart';
import 'scopepage.dart';
import 'simplepiechart.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ScopePage(),
    );
  }
}
