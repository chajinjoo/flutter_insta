import 'package:flutter/material.dart';

class FeedPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        //앱바 왼쪽 아이콘
        leading: IconButton(
          color: Colors.black,
          onPressed: () {},
          icon: ImageIcon(
            AssetImage('assets/actionbar_camera.png'),
          ),
        ),
        title: Image.asset(
          'assets/insta_text_logo.png',
          height: 26,
        ),
        //앱바 오른쪽 아이콘
        actions: <Widget>[
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: ImageIcon(
              AssetImage('assets/actionbar_camera.png'),
            ),
          ),
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: ImageIcon(
              AssetImage('assets/direct_message.png'),
            ),
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: 15,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              height: 300,
              //primaries를 이용해 머터리얼 색상 리스트를 가져와서,
              //받아온 인덱스를 해당 primaries 리스트 길이로 나눈 나머지를 갖고 색상을 정해줌
              color: Colors.primaries[index % Colors.primaries.length],
            );
          }),
    );
  }
}
