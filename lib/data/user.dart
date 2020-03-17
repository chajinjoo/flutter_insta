import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutterinsta/constants/firebase_keys.dart';

//유저 모델 생성
class User {
  final String userKey;
  final String profileImg;
  final String username;
  final String email;
  final int followers;
  final List<dynamic> followings;
  final List<dynamic> likedPosts;
  final List<dynamic> myPosts;
  final DocumentReference reference;

  //가져온 데이터를 fromMap 의 map 키워드를 통해 firestore에 던져줌
  User.fromMap(Map<String, dynamic> map, this.userKey, {this.reference})
      : profileImg = map[KEY_PROFILEIMG],
        username = map[KEY_USERNAME],
        email = map[KEY_EMAIL],
        likedPosts = map[KEY_LIKEDPOSTS],
        followers = map[KEY_FOLLOWERS],
        followings = map[KEY_FOLLOWINGS],
        myPosts = map[KEY_MYPOSTS];

  User.fromSnapshot(DocumentSnapshot snapshot)
      : this.fromMap(
          snapshot.data,
          snapshot.documentID,
          reference: snapshot.reference,
        );

  static Map<String, dynamic> getMapForCreateUser(String email) {
    Map<String, dynamic> map = Map();
    map[KEY_PROFILEIMG] = "";
    map[KEY_USERNAME] = email.split("@")[0];
    map[KEY_EMAIL] = email;
    map[KEY_LIKEDPOSTS] = [];
    map[KEY_FOLLOWERS] = 0;
    map[KEY_FOLLOWINGS] = [];
    map[KEY_MYPOSTS] = [];
    return map;
  }
}