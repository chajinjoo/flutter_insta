import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';

//Provider를 사용하니까 stl 위젯을 써도 되지만,
//ProfilePage 에서는 애니메이션을 사용하기 때문에 stful 위젯을 사용해준다!
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _menuOpened = false;
  Size _size;
  double menuWidth;
  int duration = 200;

  @override
  Widget build(BuildContext context) {
    //현재 앱 화면의 사이즈 값을 받아옴
    _size = MediaQuery.of(context).size;
    //menuWidth = 현재 앱 화면의 사이즈를 1.5(3/2)로 나눈 값
    menuWidth = _size.width / 1.5;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _sideMenu(),
          _profile(),
        ],
      ),
    );
  }

  Widget _sideMenu() {
    //일정 기간동안 점차적으로 값을 변경함
    return AnimatedContainer(
      //커브 효과
      curve: Curves.easeInOut,
      color: Colors.grey[200],
      duration: Duration(milliseconds: duration),
      //세로 y축과 앞뒤 z축은 변경 안해주니 0으로 세팅
      transform: Matrix4.translationValues(
          //메뉴가 열려있으면 기존 앱 사이즈에서 menuWidth 뺀 걸 보여주고,
          //아니면 기존 앱 사이즈 화면만 보여라
          _menuOpened ? _size.width - menuWidth : _size.width,
          0,
          0),
      child: SafeArea(
        //메뉴를 클릭했을때 해당 column 사이즈가 활성화된 화면 전체를 차지하게끔
        child: SizedBox(
          width: menuWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FlatButton(
                onPressed: () {},
                child: Text('chacha__dev'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    return AnimatedContainer(
      curve: Curves.easeInOut,
      color: Colors.transparent,
      duration: Duration(milliseconds: duration),
      //세로 y축과 앞뒤 z축은 변경 안해주니 0으로 세팅
      transform: Matrix4.translationValues(
          //메뉴가 열려있으면 menuWidth 을 뺀 값만큼 왼쪽 - 로 옮기고, 아니면 0
          _menuOpened ? -menuWidth : 0,
          0,
          0),
      //화면 바깥에 탈모부분 안건드리게 safearea로 감싸줌
      child: SafeArea(
        child: Column(
          children: <Widget>[
            _usernameIconButton(),
          ],
        ),
      ),
    );
  }

  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Padding(
          padding: const EdgeInsets.only(left: common_gap),
          child: Text(
            'chacha__dev',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.0,
            ),
          ),
        )),
        IconButton(
          icon: Icon(Icons.menu),
          onPressed: () {
            setState(() {
              //플로팅액션버튼 클릭하면 _menuOpened를 true 면 false 로~ false 면 true 로 바꿈
              _menuOpened = !_menuOpened;
            });
          },
        ),
      ],
    );
  }
}
