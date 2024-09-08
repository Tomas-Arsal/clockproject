import 'package:flutter/material.dart';
import 'Home_Layout.dart';

void main() {
  runApp( MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home_Layout(),
    );
  }
}