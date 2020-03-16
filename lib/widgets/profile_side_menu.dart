import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/screens/auth_page.dart';

class ProfileSideMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      //프로필화면과 사이드바의 경계선
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(
            color: Colors.grey[300],
          ),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(common_gap),
            child: Text(
              '설정',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //실선 추가
          Container(
            color: Colors.grey[300],
            height: 1,
          ),
          //아이콘이랑 텍스트가 둘다 들어갈 수 있음
          FlatButton.icon(
            onPressed: () {
              final route = MaterialPageRoute(builder: (context) => AuthPage());
              //이전 경로는 스택에서 사라지고 이동할 경로만 남는다
              Navigator.pushReplacement(context, route);
            },
            icon: Icon(Icons.exit_to_app),
            label: Text(
              '로그아웃',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
