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
      body: IndexedStack(
        index: _selectedIndex,
        children: _widgetOptions,
      ),
      bottomNavigationBar: BottomNavigationBar(
        showSelectedLabels: false,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey[900],
        selectedItemColor: Colors.black,
        //아이콘 선택시 별도 효과 없이 제자리 고정
        type: BottomNavigationBarType.fixed,
        backgroundColor: Color.fromRGBO(249, 249, 249, 1),
        //items가 2개 이상 있어야 활성화
        items: [
          _buildBottomNavigationBarItem(
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
        //현재 활성화 된 BottomNavigationBarItem의 항목에 대한 인덱스
        currentIndex: _selectedIndex,
        onTap: (index) => _onItemTapped(index),
      ),
    );
  }

  //선택시와 미선택시 아이콘 생성
  BottomNavigationBarItem _buildBottomNavigationBarItem(
      {String activeIconPath, String iconPath}) {
    return BottomNavigationBarItem(
      activeIcon:
          activeIconPath == null ? null : ImageIcon(AssetImage(activeIconPath)),
      icon: ImageIcon(AssetImage(iconPath)),
      title: Text(''),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
