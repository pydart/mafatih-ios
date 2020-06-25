import 'dart:convert';

List<MixedTextInfoAll> MixedTextInfoFromJson(String str) =>
    List<MixedTextInfoAll>.from(
        json.decode(str).map((x) => MixedTextInfoAll.fromJson(x)));

String MixedTextInfoToJson(List<MixedTextInfoAll> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class MixedTextInfoAll {
  String title;
  String arabic;
  int index;
  int indexbab;
  int bab;

  MixedTextInfoAll({
    this.title,
    this.arabic,
    this.index,
    this.bab,
    this.indexbab,
  });

  factory MixedTextInfoAll.fromJson(Map<String, dynamic> json) =>
      MixedTextInfoAll(
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
        arabic: json["arabic"][0] == null ? null : json["arabic"][0],
        bab: json["bab"] == null ? null : json["bab"],
        indexbab: json["indexbab"] == null ? null : json["indexbab"],
      );


  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "index": index == null ? null : index,
        "bab": bab == null ? null : bab,
        "arabic": arabic == null ? null : arabic,
        "indexbab": indexbab == null ? null : indexbab,
      };
}
