import 'dart:convert';

List<FaslInfo> faslInfoFromJson(String str) =>
    List<FaslInfo>.from(json.decode(str).map((x) => FaslInfo.fromJson(x)));

String faslInfoToJson(List<FaslInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaslInfo {
  String title;
  int index;

  FaslInfo({
    this.title,
    this.index,
  });

  factory FaslInfo.fromJson(Map<String, dynamic> json) => FaslInfo(
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "index": index == null ? null : index,
      };
}
