import 'package:flutter/foundation.dart';
import 'package:flutterinsta/data/user.dart';

class MyUserData extends ChangeNotifier {
  //프라이빗으로 해야함!
  //퍼블릭을 하면 다른 유저가 임의로 데이터를 바꿔버리면 알람이 안가니까!
  User _myUserData;

  User get data => _myUserData;
  //새로운 데이터를 함수를 통해 받아와서 _myUserData에 지정해줌
  void setUserData(User user) {
    _myUserData = user;
    //이걸 해야 해당 오브젝트를 지켜보는 모든 위젯들에게 데이터 변경 알람이 감
    notifyListeners();
  }

  //로그아웃시 유저데이터 삭제
  void clearUser() {
    _myUserData = null;
  }
}
