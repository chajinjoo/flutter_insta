import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/utils/profile_img_path.dart';
import 'package:flutterinsta/widgets/comment.dart';

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
            return _postItem(index, context);
          }),
    );
  }

  //포스트 전체 아이템
  Column _postItem(int index, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        _postHeader('username $index'),
        _postImage(index),
        _postActions(),
        _postLikes(),
        _postCaption(context, index),
        _allComments(),
      ],
    );
  }

  //댓글
  FlatButton _allComments() {
    return FlatButton(
      onPressed: () {},
      child: Text(
        'show all 18 comments',
        style: TextStyle(
          color: Colors.grey[600],
        ),
      ),
    );
  }

  //포스트 설명
  Padding _postCaption(BuildContext context, int index) {
    return Padding(
      padding: const EdgeInsets.symmetric(
          horizontal: common_gap, vertical: common_xs_gap),
      child: Comment(
        username: 'username $index',
        caption: '오늘도 플러터로 빡코열코!!! 🔥 얼른 취뽀하즈아!!! \n버닝버닝!! 으아아ㅏ아아아아아ㅏㅏㅏ아!!!!',
//        showProfile: true,
//        dateTime: DateTime.now(),
      ),
    );
  }

  //포스트 좋아요
  Padding _postLikes() {
    return Padding(
      padding: const EdgeInsets.only(left: common_gap),
      child: Text(
        '77 likes',
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    );
  }

  //포스트 아이콘들
  Row _postActions() {
    return Row(
      children: <Widget>[
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/heart_selected.png'),
            color: Colors.redAccent,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/comment.png'),
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/direct_message.png'),
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
        //row, column 같은 flex 컨테이너 위젯간의 간격을 조정해줌
        Spacer(),
        IconButton(
          icon: ImageIcon(
            AssetImage('assets/bookmark.png'),
            color: Colors.black87,
          ),
          onPressed: () {},
        ),
      ],
    );
  }

  //포스트 헤더
  Row _postHeader(String username) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(common_gap),
          child: CircleAvatar(
            radius: profile_radius,
            backgroundImage:
                //캐싱으로 미리 정의한 getProfileImgPath를 통해 유저프로필 이미지를 불러옴
                CachedNetworkImageProvider(getProfileImgPath(username)),
          ),
        ),
        //남은 자리를 차지하게끔 expanded
        Expanded(child: Text(username)),
        IconButton(
          icon: Icon(Icons.more_horiz),
          color: Colors.black87,
          onPressed: () {},
        ),
      ],
    );
  }

  //포스트 이미지
  CachedNetworkImage _postImage(int index) {
    //라이브러리를 이용하여 캐싱 함 (이미 다운로드된 이미지를 제외하고 새로운 이미지만 로드해줌)
    return CachedNetworkImage(
      //이미지 위치
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      imageBuilder: (BuildContext context, ImageProvider imageProvider) =>
          //자녀 위젯의 비율
          AspectRatio(
        aspectRatio: 1,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
        ),
      ),
    );
  }
}
