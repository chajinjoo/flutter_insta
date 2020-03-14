import 'dart:convert';

String getProfileImgPath(String username) {
  final encoder = AsciiEncoder();
  List<int> codes = encoder.convert(username);
  int sum = 0;
  codes.forEach((code) => sum += code);

  final imgNum = sum % 100;

  return 'https://picsum.photos/id/$imgNum/30/30';
}
