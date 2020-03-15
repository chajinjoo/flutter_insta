import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/utils/profile_img_path.dart';

//해당 클래스는 피드화면 캡션 부분이랑 댓글 부분에 동일하게 쓰이니까 별도로 빼서 쓴다.
class Comment extends StatelessWidget {
  final String username;
  final bool showProfile;
  final DateTime dateTime;
  final String caption;

  const Comment({
    @required this.username,
    //showProfile = true 면 caption 부분 프사랑 공백이 보임
    this.showProfile = false,
    this.dateTime,
    @required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      //유저 프사를 세로 상단 시작점에 위치시킴
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        //가시성 클래스, 자식을 보여줄건지~ 숨길건지~
        Visibility(
          visible: showProfile,
          child: CircleAvatar(
            backgroundImage:
                //지정해둔 getProfileImgPath를 이용해서 임의의 랜덤 이미지를 갖고옴
                NetworkImage(getProfileImgPath('username randome')),
            radius: profile_radius,
          ),
        ),
        Visibility(
            visible: showProfile,
            child: SizedBox(
              width: common_xs_gap,
            )),
        //나머지 자리 차지하게끔 expanded 안주면 컨텐츠들이 오버플로우 되서 공사장 에러뜸
        Expanded(
          child: Column(
            //caption 텍스트를 가로 왼쪽 시작점에 위치시킴
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //한줄에 텍스트를 쭉 나열하되 지정 텍스트 부분마다 다른 스타일을 줄 수 있는 위젯
              RichText(
                text: TextSpan(
                  //특별한 스타일이 없을 경우 현재 앱의 기본 스타일 상태를 갖고옴
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    //username 과 caption 사이 한칸 띄워줌
                    TextSpan(
                      text: ' ',
                    ),
                    TextSpan(
                      text: caption,
                    ),
                  ],
                ),
              ),
              SizedBox(height: common_xxxs_gap),
              Visibility(
                //데이트타임은 null 값과 같지 않다
                visible: dateTime != null,
                //데이트타임이 null 값과 같다면(데이트타임 데이터가 없다면) 빈박스를 던지고
                //그게 아니면(데이트타임 데이터가 있다면) 받아온 현재시간을 문자열로 변환하여 던져줌
                child: dateTime == null
                    ? SizedBox()
                    : Text(
                        dateTime.toIso8601String(),
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 10.0,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
