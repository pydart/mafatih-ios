import 'dart:convert';

List<dailyDoaInfo> surahInfoFromJson(String str) => List<dailyDoaInfo>.from(
    json.decode(str).map((x) => dailyDoaInfo.fromJson(x)));

String surahInfoToJson(List<dailyDoaInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class dailyDoaInfo {
  String? title;
  int? index;

  dailyDoaInfo({
    this.title,
    this.index,
  });

  factory dailyDoaInfo.fromJson(Map<String, dynamic> json) => dailyDoaInfo(
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "index": index == null ? null : index,
      };
}
