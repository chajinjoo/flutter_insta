import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/material_white_color.dart';
import 'package:flutterinsta/data/provider/my_user_data.dart';
import 'package:flutterinsta/firebase/firestore_provider.dart';
import 'package:flutterinsta/main_page.dart';
import 'package:flutterinsta/screens/auth_page.dart';
import 'package:flutterinsta/widgets/my_progress_indicator.dart';
import 'package:provider/provider.dart';

//ChangeNotifierProvider<갖고올 데이타가 있는 클래스> 를 create 를 이용해서 갖고오거나,
//void main() {
// MyUserData userdata = MyUserData();
// return reuApp(ChangeNotifierProvider<MyUserData>.value(
//    value: userdata, child: MyApp()));   요론 식으로 주거나 두가지 방법이 있다
void main() => runApp(ChangeNotifierProvider<MyUserData>(
    create: (context) => MyUserData(), child: MyApp()));

//첫번째 데이터
bool isItFirstData = true;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: white),
      home: StreamBuilder<FirebaseUser>(
        //유저가 로그인하면 스트림 통해서 onAuthStateChanged가 트리거가 되서,
        //<FirebaseUser> 를 snapshot 을 통해 던져주면 MainPage로 이동
        //**중요! 여기서 던져지는 첫번째 데이터 값은 snapshot에 데이터가 없는 null값이다. (버려야하는 값)
        stream: FirebaseAuth.instance.onAuthStateChanged,
        builder: (context, snapshot) {
          //첫번째 데이터가 들어오면 false 로 바꾸고 (버려야하는 값이니까), 로딩을 돌린다
          if (isItFirstData) {
            isItFirstData = false;
            return MyProgressIndicator();
            //두번째 데이터부터는 <FirebaseUser>가 있다면(유저가 있다면) MainPage로 가고,
            //없으면 AuthPage 로 이동
          } else {
            if (snapshot.hasData) {
              //파베auth에서 유저키를 가져와서 데이터 존재유무 확인후 , 존재하지 않으면 유저데이터를 생성해줌
              firestoreProvider.attemptCreateUser(
                  userKey: snapshot.data.uid, email: snapshot.data.email);
              //Provider.of<가져올 데이터를 명시>
              var myUserData = Provider.of<MyUserData>(context);
              //존재하는 유저 데이터 연결하기
              firestoreProvider
                  .connectMyUserData(snapshot.data.uid)
                  .listen((user) {
                myUserData.setUserData(user);
              });
              return MainPage();
            }
            return AuthPage();
          }
        },
      ),
    );
  }
}
