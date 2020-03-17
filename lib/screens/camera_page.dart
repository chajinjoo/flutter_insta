import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/screens/share_post_page.dart';
import 'package:flutterinsta/widgets/my_progress_indicator.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutterinsta/data/user.dart';

class CameraPage extends StatefulWidget {
  final CameraDescription camera;
  final User user;

  const CameraPage({Key key, @required this.camera, @required this.user})
      : super(key: key);

  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  //화면이 첫 실행됬을때 두번째 화면인 사진화면으로 기본세팅
  int _selectedIndex = 1;

  //페이지뷰 위젯을 컨트롤하는 컨트롤러. 첫 화면은 1번째로 지정
  var _pageController = PageController(initialPage: 1);
  CameraController _controller;

  //카메라를 실행후 준비가 되면 이걸로 신호를 받음
  Future<void> _initializeControllerFuture;

  //상태가 트리에 추가되는 시점
  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      //카메라 화질
      ResolutionPreset.ultraHigh,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

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
    return FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done)
            return Column(
              children: <Widget>[
                Container(
                  //화면을 1:1 비율로 자름
                  width: size.width,
                  height: size.width,
                  child: ClipRect(
                    child: OverflowBox(
                      alignment: Alignment.topCenter,
                      child: FittedBox(
                        fit: BoxFit.fitWidth,
                        child: Container(
                          width: size.width,
                          height: size.width / _controller.value.aspectRatio,
                          child: CameraPreview(_controller),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      _attemptTakePhoto(context);
                    },
                    child: Padding(
                      padding: EdgeInsets.all(80.0),
                      child: Center(
                        child: Container(
                          decoration: ShapeDecoration(
                              shape: CircleBorder(
                                  side: BorderSide(
                                      color: Colors.grey[300], width: 20))),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          return MyProgressIndicator();
        });
  }

  Widget _takeVideoPage() {
    return Container(color: Colors.deepOrange);
  }

  void _attemptTakePhoto(BuildContext context) async {
    try {
      await _initializeControllerFuture;
      final path = join(
        (await getTemporaryDirectory()).path,
        '${DateTime.now()}_${widget.user.username}.png',
      );
      await _controller.takePicture(path);

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SharePostPage(imgFile: File(path)),
        ),
      );
    } catch (e) {
      print(e);
    }
  }
}
