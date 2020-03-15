import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';

class SignInForm extends StatefulWidget {
  @override
  _SignInFormState createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _pwController = TextEditingController();

  //TextEditingController 를 사용한 후에는 dispose를 사용해서 메모리 릭을 방지.
  //메모리 누수(memory leak) 현상은 컴퓨터 프로그램이 필요하지 않은 메모리를 계속 점유하고 있는 현상으로,
  //할당된 메모리를 사용한 다음 반환하지 않는 것이 누적되면 메모리가 낭비된다.
  @override
  void dispose() {
    _emailController.dispose();
    _pwController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //창의 아래쪽 삽입을 피하기 위해 자식 크기를 조정해야하는지 여부
      //예를 들어, 스캐 폴드 위에 온 스크린 키보드가 표시되는 경우,
      //키보드가 겹치지 않도록 본체 크기를 조정할 수 있으므로 본체 내부의 위젯이 키보드에 의해 가려지지 않음.
      //기본값은 true이며 null 일 수 없음
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: EdgeInsets.all(common_gap),
        child: Form(
          key: _formKey,
          child: Column(
            //메인 공간을 다 차지하게끔하고, 가운데로 위치
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            //가로의 모든 자리를 차지한다
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              //위젯 사이 공간을 줌
              Spacer(flex: 6),
              Image.asset('assets/insta_text_logo.png'),
              Spacer(flex: 1),
              TextFormField(
                controller: _emailController,
                decoration: getTextFieldDecor('전화번호, 사용자 이름 또는 이메일'),
                //유저가 입력한 것에 대한 유효성 검사
                validator: (String value) {
                  //value가 비어있거나 @ 를 포함 안하고 있으면 에러 메세지 던지고,
                  if (value.isEmpty || !value.contains('@')) {
                    return '잘못된 사용자 계정입니다. 이메일 주소를 다시 확인해주세요.';
                  }
                  //아니면 그냥 null 값 던져서 에러없이 통과
                  return null;
                },
              ),
              Spacer(flex: 1),
              TextFormField(
                controller: _pwController,
                decoration: getTextFieldDecor('비밀번호'),
                validator: (String value) {
                  //value가 비어있으면 에러 메세지 투척
                  if (value.isEmpty) {
                    return '비밀번호를 입력해주세요.';
                  }
                  //아니면 통과
                  return null;
                },
              ),
              Spacer(flex: 1),
              Text(
                '비밀번호를 잊으셨나요?',
                textAlign: TextAlign.end,
                style: TextStyle(
                  color: Colors.blue[700],
                  fontWeight: FontWeight.w600,
                ),
              ),
              Spacer(flex: 2),
              FlatButton(
                onPressed: () {
                  //유효성 검증이 완벽히 되면 파이어베이스에 던져줌
                  if (_formKey.currentState.validate()) {}
                },
                child: Text(
                  '로그인',
                  style: TextStyle(color: Colors.white),
                ),
                color: Colors.blue,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6)),
                disabledColor: Colors.blue[100],
              ),
              Spacer(flex: 2),
              //'또는' 구분선 부분
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  Positioned(
                    left: 0,
                    right: 0,
                    height: 1,
                    child: Container(
                      color: Colors.grey[300],
                      height: 1,
                    ),
                  ),
                  Container(
                    color: Colors.grey[50],
                    height: 3,
                    width: 50,
                  ),
                  Text(
                    '또는',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.grey),
                  ),
                ],
              ),
              Spacer(flex: 2),
              FlatButton.icon(
                textColor: Colors.blue,
                onPressed: () {
                  simpleSnackbar(context, 'facebook preddes');
                },
                icon: ImageIcon(AssetImage('assets/icon/facebook.png')),
                label: Text('Facebook으로 로그인'),
              ),
              Spacer(flex: 2),
              Spacer(flex: 6),
            ],
          ),
        ),
      ),
    );
  }

  void simpleSnackbar(BuildContext context, String txt) {
    final snackBar = SnackBar(
      content: Text(txt),
    );
    Scaffold.of(context).showSnackBar(snackBar);
  }

  InputDecoration getTextFieldDecor(String hint) {
    return InputDecoration(
      hintText: hint,
      //텍스트 필드가 사용가능할때 보더 모양
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      //포커스 됬을때 보더 모양
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey[300],
          width: 1,
        ),
        borderRadius: BorderRadius.circular(12),
      ),
      //보더 안에 있는 백그라운드 컬러
      fillColor: Colors.grey[100],
      filled: true,
    );
  }
}
