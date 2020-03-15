import 'package:flutter/material.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  //화면이 첫 실행됬을때 두번째 화면인 사진화면으로 기본세팅
  int _selectedIndex = 1;
  //페이지뷰 위젯을 컨트롤하는 컨트롤러. 첫 화면은 1번째로 지정
  var _pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '사진',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              //뒤로가기
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: PageView(
        controller: _pageController,
        //페이지가 바뀌었을 때
        onPageChanged: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        children: <Widget>[
          _gellaryPage(),
          _takePhotoPage(),
          _takeVideoPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        //아이콘 숨기기
        iconSize: 0,
        //선택시 레이블 스타일
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold),
        unselectedItemColor: Colors.grey[400],
        selectedItemColor: Colors.black,
        //고정효과
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey[50],
        //BottomNavigationBarItem 위젯을 아이템으로 하는 리스트를 줌
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            //어처피 안보일 아이콘이라 대충 지정 (BottomNavigationBarItem 은 icon이 필수값)
            icon: ImageIcon(AssetImage('assets/grid.png')),
            title: Text('라이브러리'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/grid.png')),
            title: Text('사진'),
          ),
          BottomNavigationBarItem(
            icon: ImageIcon(AssetImage('assets/grid.png')),
            title: Text('동영상'),
          ),
        ],
        //선택된 인덱스. 이걸줘야 지금 선택된게 표시됨
        currentIndex: _selectedIndex,
        //선택이 됬을때 컨트롤러에 얘기를해서 페이지뷰에 애니메이션을 줘서 이동해라
        onTap: (index) => _onItemTapped(context, index),
      ),
    );
  }

  //선택된것이 애니메이션과 함께 화면 전환
  void _onItemTapped(BuildContext context, int index) {
    _pageController.animateToPage(
      index,
      curve: Curves.easeInOut,
      duration: Duration(milliseconds: 200),
    );
  }

  Widget _gellaryPage() {
    return Container(color: Colors.green);
  }

  Widget _takePhotoPage() {
    return Container(color: Colors.purple);
  }

  Widget _takeVideoPage() {
    return Container(color: Colors.deepOrange);
  }
}
