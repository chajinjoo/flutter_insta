import 'package:flutter/material.dart';
import 'package:flutterinsta/constants/size.dart';
import 'package:flutterinsta/utils/profile_img_path.dart';

class Comment extends StatelessWidget {
  final String username;
  final bool showProfile;
  final DateTime dateTime;
  final String caption;

  const Comment({
    @required this.username,
    this.showProfile = false,
    this.dateTime,
    @required this.caption,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Visibility(
          visible: showProfile,
          child: CircleAvatar(
            backgroundImage:
                NetworkImage(getProfileImgPath('username randome')),
            radius: profile_radius,
          ),
        ),
        Visibility(
            visible: showProfile,
            child: SizedBox(
              width: common_xs_gap,
            )),
        //나머지 자리 차지하게끔 expanded 안주면 오버플로우 되서 공사장 에러뜸
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              RichText(
                text: TextSpan(
                  style: DefaultTextStyle.of(context).style,
                  children: <TextSpan>[
                    TextSpan(
                      text: username,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
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
                visible: dateTime != null,
                //데이트타임이 없으면 빈박스 던지고 있으면 스트링으로 변환해 값을 던져줌
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
