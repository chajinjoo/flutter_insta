import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/utils/profile_img_path.dart';

class SearchPage extends StatelessWidget {
  //10줬으니까 0~9까지 수를 생성해 두번째 인수의 함수에 i 매개변수로 전달함
  final List<String> users = List.generate(10, (i) => 'user $i');

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      //separated : 항목들 사이에 구분자를 넣을 수 있는 기능을 제공
      child: ListView.separated(
        itemCount: 10,
        itemBuilder: (context, index) {
          return _item(users[index]);
        },
        //구분선 추가
        separatorBuilder: (context, index) {
          return Divider(
            thickness: 1,
            color: Colors.grey[300],
          );
        },
      ),
    );
  }

  ListTile _item(String user) {
    //i 값을 전달받아 ListTile 위젯 형태로 반환하여 그것들의 리스트가 반환됨
    return ListTile(
      leading: CircleAvatar(
        radius: profile_radius,
        //user 에 따른 이미지를 가져옴
        backgroundImage: NetworkImage(getProfileImgPath(user)),
      ),
      title: Text(user),
      subtitle: Text('개발자 $user 입니다.'),
      trailing: Container(
        height: 30,
        width: 80,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red[50],
          //테두리선
          border: Border.all(
            color: Colors.black54,
            width: 0.5,
          ),
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text(
          '팔로잉',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.red[700],
          ),
        ),
      ),
    );
  }
}
