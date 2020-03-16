import 'package:flutter/material.dart';
import 'package:flutterinsta/screens/signin_page.dart';
import 'package:flutterinsta/utils/styles.dart';
import 'package:flutterinsta/widgets/sign_in_form.dart';
import 'package:flutterinsta/widgets/sign_up_form.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //창의 아래쪽 삽입을 피하기 위해 자식 크기를 조정해야하는지 여부
      //예를 들어, 스캐 폴드 위에 온 스크린 키보드가 표시되는 경우,
      //키보드가 겹치지 않도록 본체 크기를 조정할 수 있으므로 본체 내부의 위젯이 키보드에 의해 가려지지 않음.
      //기본값은 true이며 null 일 수 없음
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            SignUpForm(),
            _goToSignUpPageBtn(context),
          ],
        ),
      ),
    );
  }

  Positioned _goToSignUpPageBtn(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      height: 40,
      child: FlatButton(
        shape: Border(top: BorderSide(color: Colors.grey[300])),
        onPressed: () {
          final route = MaterialPageRoute(builder: (context) => SignInPage());
          Navigator.pushReplacement(context, route);
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                text: '계정이 있으신가요?',
                style: authTxtStyle,
              ),
              TextSpan(
                text: '  로그인',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.blue[600]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
