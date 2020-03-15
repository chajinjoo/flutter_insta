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
//          IconButton(
//            color: Colors.black,
//            onPressed: () {},
//            icon: ImageIcon(
//              AssetImage('assets/actionbar_camera.png'),
//            ),
//          ),
          IconButton(
            color: Colors.black,
            onPressed: () {},
            icon: ImageIcon(
              AssetImage('assets/direct_message.png'),
            ),
          ),
        ],
      ),
      //스크롤 가능한 바디부분
      body: ListView.builder(
          //보일 아이템 갯수
          itemCount: 15,
          //필수요소
          //IndexedWidgetBuilder 각 행 작성을 담당 하는 유형의 함수.
          //현재 컨텍스트와 항목 색인을 수신하고 표시하려면 Widget를 리턴해야한다.
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
        '댓글 15개 모두 보기',
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
        caption: '오늘도 플러터로 빡코열코!!! 스벅가고싶다.... \n생크림카시테라랑 아아벤티뜨리샷...🥺',
        //showProfile = true 면 caption 부분 프사랑 공백이 보임
//        showProfile: true,
        //현재시간
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
        //아이콘버튼을 내가 지정한 이미지아이콘으로 꾸밈
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
    //Image.network('url') 을 사용해도 되지만 다른 페이지에 있다가 다시 돌아올때 처음부터 다시 이미지를 다운받으니,
    //데이터 소비를 너무 많이해서 안좋다. CachedNetworkImage 캐싱을 사용하자!
    //라이브러리를 이용하여 캐싱 함 (이미 다운로드된 이미지를 제외하고 새로운 이미지만 로드해줌)
    return CachedNetworkImage(
      //이미지 위치
      imageUrl: 'https://picsum.photos/id/$index/200/200',
      //로딩표시
      placeholder: (context, url) {
        return Container(
          //가로세로 사이즈 동일하게
          width: size.width,
          height: size.width,
          child: Center(
            child: SizedBox(
              width: 30.0,
              height: 30.0,
              child: Image.asset('assets/loading_img.gif'),
            ),
          ),
        );
      },
      //기본 imageBuilder가 맘에 들지 않으면 직접 정의 가능
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
