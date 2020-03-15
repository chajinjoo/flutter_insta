import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/utils/profile_img_path.dart';

//Provider를 사용하니까 stl 위젯을 써도 되지만,
//ProfilePage 에서는 애니메이션을 사용하기 때문에 stful 위젯을 사용해준다!
class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool _menuOpened = false;
  double menuWidth;
  int duration = 200;
  AlignmentGeometry tabAlign = Alignment.centerLeft;
  bool _tabIconGridSelected = true;

  @override
  Widget build(BuildContext context) {
    //menuWidth = 현재 앱 화면의 사이즈를 1.5(3/2)로 나눈 값
    menuWidth = size.width / 1.5;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _sideMenu(),
          _profile(),
        ],
      ),
    );
  }

  //사이드 메뉴 페이지
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
          _menuOpened ? size.width - menuWidth : size.width,
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

  //프로필 부분 페이지
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
            Expanded(
              //그리드뷰나 다른 레이아웃들을 겸해서 스크롤 가능한 뷰들을 한 페이지에 섞어야 하기 떄문에,
              //ListView akfrh CustomScrollView 를 쓴다.
              child: CustomScrollView(
                //필수 요소
                slivers: <Widget>[
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        _getProfileHeader,
                        _username(),
                        _userBio(),
                        _editProfileBtn(),
                        _getTabIconButtons,
                        _getAnimatedSelectedBar,
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  //프로필 수정 버튼
  Padding _editProfileBtn() {
    return Padding(
      padding: const EdgeInsets.all(common_gap),
      //얇은 회색 둥근 사각형 버튼. FlatButton 과 유사함
      //아웃라인버튼 높이 조절을 위해 SizedBox로 감싸고 높이 줌
      child: SizedBox(
        height: 32,
        child: OutlineButton(
          onPressed: () {},
          //보더 색상
          borderSide: BorderSide(color: Colors.black45),
          //보더 모서리 둥근정도
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
          child: Text(
            '프로필 수정',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }

  //프로필 설명
  Padding _userBio() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '과거는 갔고 미래는 몰라\n#개발자 #프론트엔드 #플러터',
        style: TextStyle(fontWeight: FontWeight.w400),
      ),
    );
  }

  //프로필 이름
  Padding _username() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '차차 😎',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //프로필 헤더
  Row get _getProfileHeader => Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: CircleAvatar(
              radius: 40.0,
              backgroundImage: NetworkImage(getProfileImgPath('chacha')),
            ),
          ),
          //Table 위젯은 크기가 없기때문에 크기 지정말고 그냥 나머지를 공간을 차지하게 해줌
          Expanded(
            child: Table(
              children: [
                TableRow(
                  children: [
                    _getStatusValueWidget('123'),
                    _getStatusValueWidget('456'),
                    _getStatusValueWidget('789'),
                  ],
                ),
                TableRow(
                  children: [
                    _getStatusLabelWidget('게시물'),
                    _getStatusLabelWidget('팔로워'),
                    _getStatusLabelWidget('팔로잉'),
                  ],
                ),
              ],
            ),
          ),
        ],
      );

  //카운터
  Widget _getStatusValueWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          //자식 위젯을 자기 스케일만큼에 딱 위치시킴(벗어나지못하게)
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ),
      );

  //카운터 제목
  Widget _getStatusLabelWidget(String value) => Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: common_s_gap),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.w300),
            ),
          ),
        ),
      );

  //사이드바 안에 최상단 버튼
  Row _usernameIconButton() {
    return Row(
      children: <Widget>[
        Expanded(
            child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: common_gap),
              child: Text(
                'chacha__dev',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.0,
                ),
              ),
            ),
            GestureDetector(
                child: Icon(Icons.keyboard_arrow_down), onTap: () {}),
          ],
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

  //탭 아이콘 2개짜리
  Widget get _getTabIconButtons => Row(
        children: <Widget>[
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/grid.png'),
                //_tabIconGridSelected 가 true 면 black, 아니면 black26 을 줘라
                color: _tabIconGridSelected ? Colors.black : Colors.black26,
              ),
              onPressed: () {
                _setTab(true);
              },
            ),
          ),
          Expanded(
            child: IconButton(
              icon: ImageIcon(
                AssetImage('assets/saved.png'),
                size: 32,
                color: _tabIconGridSelected ? Colors.black26 : Colors.black,
              ),
              onPressed: () {
                _setTab(false);
              },
            ),
          ),
        ],
      );

  //아이콘 클릭시 하단 바 애니메이션
  //AnimatedContainer : 안에 Duration은 필수
  //안에있는 속성들이 변경될때마다 알아서 애니메이션을 만들어낸다.
  Widget get _getAnimatedSelectedBar => AnimatedContainer(
        alignment: tabAlign,
        duration: Duration(milliseconds: 200),
        //애니메이션 효과
        curve: Curves.easeInOut,
        color: Colors.transparent,
        height: 1,
        width: size.width,
        //하단 바
        child: Container(
          height: 1,
          width: size.width / 2,
          color: Colors.black87,
        ),
      );

  //하단 바 조건문
  _setTab(bool tabLeft) {
    setState(() {
      if (tabLeft) {
        //왼쪽 선택시,
        //tabLeft 가 true 면 왼쪽으로
        this.tabAlign = Alignment.centerLeft;
        //_tabIconGridSelected 를 true 로 지정
        this._tabIconGridSelected = true;
        //아니면 오른쪽으로 _tabIconGridSelected = flase 로 지정
      } else {
        this.tabAlign = Alignment.centerRight;
        this._tabIconGridSelected = false;
      }
    });
  }
}
