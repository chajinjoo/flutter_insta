import 'package:flutter/material.dart';
import 'package:flutterinsta/screens/feed_page.dart';

class MainPage extends StatefulWidget {
  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State {
  //기본 세팅 인덱스값
  int _selectedIndex = 0;

  static List<Widget> _widgetOptions = [
    FeedPage(),
    Container(
      //primaries : 머터리얼 컬러 리스트를 불러옴
      color: Colors.primaries[1],
    ),
    Container(
      color: Colors.primaries[2],
    ),
    Container(
      color: Colors.primaries[3],
    ),
    Container(
      color: Colors.primaries[4],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //위젯간의 이동을 편리하게 해줌 (예: 채널 변환을 하는 TV)
      //클릭될때마다 children에 묶인 위젯들로 화면 전환을 해줌
      body: IndexedStack(
        //이동을 원하는 위젯들을 묶어주고
        children: _widgetOptions,
        //추후 setState에서도 쓸 수 있게끔 변환이 가능한 매개변수로 인덱스 지정
        index: _selectedIndex,
      ),
      bottomNavigationBar: BottomNavigationBar(
        //선택시 라벨 내용 보여줄건가~ 말건가~
        showSelectedLabels: false,
        showUnselectedLabels: false,
        //선택시 컬러
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.grey[900],
        //아이콘 선택시 별도 효과 없이 제자리 고정
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        //items가 2개 이상 있어야 바텀네비바 활성화
        //각각의 바텀부분 아이콘을 보여준다
        items: [
          _buildBottomNavigationBarItem(
              //선택됬을때와 아닐때 아이콘을 각각 지정
              activeIconPath: "assets/home_selected.png",
              iconPath: "assets/home.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/search_selected.png",
              iconPath: "assets/search.png"),
          _buildBottomNavigationBarItem(iconPath: "assets/add.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/heart_selected.png",
              iconPath: "assets/heart.png"),
          _buildBottomNavigationBarItem(
              activeIconPath: "assets/profile_selected.png",
              iconPath: "assets/profile.png"),
        ],
        //현재 선택된 BottomNavigationBarItem의 항목에 대한 인덱스
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  //선택시와 미선택시 아이콘 생성
  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath}) {
    return BottomNavigationBarItem(
      //삼항연산자 사용
      //activeIconPath == null 이 참이면 null 을 던지고,
      //거짓이면 ImageIcon(AssetImage(activeIconPath) 을 던져줘라.
      activeIcon:
          activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      //title 속성은 필수라 공백으로 줘버림
      title: Text(''),
    );
  }

  void _onItemTapped(int index) {
    //지금 State(변수) 즉, 상태가 변경됬으니 변수들에 맞춰 레이아웃을 다시 디스플레이해라!
    setState(() {
      _selectedIndex = index;
    });
  }
}
