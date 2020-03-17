import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutterinsta/utils/simple_snack_bar.dart';

void signInFacebook(BuildContext context) async {
  //페북 SDK를 사용해서 이메일을 통해 로그인한다
  final facebookLogin = FacebookLogin();
  //[] 리스트 안에 email, phonenumber 등 페북 SDK에서 제공해주는 키워드로 로긴
  //갖고올 수 있는 것과 없는 것이 있으니 잘 확인하자!
  final result = await facebookLogin.logIn(['email']);

  //3가지 상태 체크
  switch (result.status) {
    //로그인 성공 상태 > 성공하면 token 가져옴
    case FacebookLoginStatus.loggedIn:
      _handleFacebookToken(context, result.accessToken.token);
      break;
    //유저가 로그인 취소한 상태 (스낵바로 에러메세지 던짐)
    //스낵바에서 에러가 난다면 context 가 Scaffold 에서 온게 맞는지 확인할 것!
    case FacebookLoginStatus.cancelledByUser:
      simpleSnackbar(context, 'User cancel facebook sign in!');
      break;
    //로그인 하다 에러난 상태 (스낵바로 에러메세지 던짐)
    case FacebookLoginStatus.error:
      simpleSnackbar(context, 'Error while facebook sign in!');
      break;
  }
}

//페북 SDK를 통해 로그인후 result에서 페북에서 준 token을 갖고와서 파베 auth에 전달함
void _handleFacebookToken(BuildContext context, String token) async {
  //FacebookAuthProvider : firebase_auth 라이브러리에서 제공해주는 API
  //token을 던져줘서 credential을 갖고옴
  final AuthCredential credential = FacebookAuthProvider.getCredential(
    accessToken: token,
  );
  //갖고온 credential을 던져 로그인한 결과에서 user를 갖고온다
  final FirebaseUser user =
      (await FirebaseAuth.instance.signInWithCredential(credential)).user;
  //user 가 없으면 스낵바 에러메세지 투척
  if (user == null) {
    simpleSnackbar(context, 'Failed to sign in with Facebook.');
  }
}
