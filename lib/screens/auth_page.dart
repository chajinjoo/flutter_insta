import 'package:flutter/material.dart';
import 'package:flutterinsta/utils/styles.dart';
import 'package:flutterinsta/widgets/sign_in_form.dart';
import 'package:flutterinsta/widgets/sign_up_form.dart';

class AuthPage extends StatefulWidget {
  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Widget currentWidget = SignInForm();

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
            //기본적으로 새 위젯과 이전에 AnimatedSwitcher 에서 자식으로 설정 한 위젯간에 크로스 페이드를 수행하는 위젯
            AnimatedSwitcher(
              duration: Duration(milliseconds: 300),
              child: currentWidget,
            ),
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
          setState(() {
            if (currentWidget is SignInForm) {
              currentWidget = SignUpForm();
            } else {
              currentWidget = SignInForm();
            }
          });
        },
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            children: <TextSpan>[
              TextSpan(
                  text: (currentWidget is SignInForm)
                      ? '계정이 없으신가요?'
                      : '계정이 있으신가요?',
                  style: authTxtStyle),
              TextSpan(
                  text: (currentWidget is SignInForm) ? '  로그인' : '  가입하기',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue[600])),
            ],
          ),
        ),
      ),
    );
  }
}
