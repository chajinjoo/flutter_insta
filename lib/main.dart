import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/material_white_color.dart';
import 'package:flutterinsta/main_page.dart';
import 'package:flutterinsta/screens/auth_page.dart';
import 'package:flutterinsta/widgets/my_progress_indicator.dart';

void main() => runApp(MyApp());

bool isItFirstData = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: white),
      home: StreamBuilder<FirebaseUser>(
        //유저가 로그인하면 스트림 통해서 파이어베이스유저를 주고,
        //로그아웃 하면 null값을 줌
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          //데이터<FirebaseUser>가 있다면(유저가 있다면) 메인페이지로 가고,
          if (isItFirstData) {
            isItFirstData = false;
            return MyProgressIndicator();
          } else {
            if (snapshot.hasData) {
              return MainPage();
            }
            return AuthPage();
          }
        },
      ),
    );
  }
}
