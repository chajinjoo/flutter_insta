import 'dart:convert';

//가져온 username 을 아스키엔코더를 이용하여 각 문자를 숫자 코드로 변환후,
//100으로 나눈 나머지 값을 imgNum에 할당하여 랜덤 이미지를 가져온다.
String getProfileImgPath(String username) {
  final encoder = AsciiEncoder();
  List<int> codes = encoder.convert(username);
  int sum = 0;
  codes.forEach((code) => sum += code);

  final imgNum = sum % 100;

  return 'https://picsum.photos/id/$imgNum/30/30';
}
