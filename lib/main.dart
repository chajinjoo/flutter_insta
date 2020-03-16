import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/material_white_color.dart';
import 'package:flutterinsta/main_page.dart';
import 'package:flutterinsta/screens/signin_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: white),
      home: MainPage(),
    );
  }
}
