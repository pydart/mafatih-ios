import 'dart:convert';

List<FaslSecInfo> faslInfoFromJson(String str) => List<FaslSecInfo>.from(
    json.decode(str).map((x) => FaslSecInfo.fromJson(x)));

String faslInfoToJson(List<FaslSecInfo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FaslSecInfo {
  String title;
  int index;
  var indent;
  String titleNext;
  int indexNext;
  var indentNext;
  String titlePrev;
  int indexPrev;
  var indentPrev;

  FaslSecInfo({
    this.title,
    this.index,
    this.indent,
    this.titleNext,
    this.indexNext,
    this.indentNext,
    this.titlePrev,
    this.indexPrev,
    this.indentPrev,
  });

  factory FaslSecInfo.fromJson(Map<String, dynamic> json) => FaslSecInfo(
        title: json["title"] == null ? null : json["title"],
        index: json["index"] == null ? null : json["index"],
        indent: json["indent"] == null ? null : json["indent"],
        titleNext: json["titleNext"] == null ? null : json["titleNext"],
        indexNext: json["indexNext"] == null ? null : json["indexNext"],
        indentNext: json["indentNext"] == null ? null : json["indentNext"],
        titlePrev: json["titlePrev"] == null ? null : json["titlePrev"],
        indexPrev: json["indexPrev"] == null ? null : json["indexPrev"],
        indentPrev: json["indentPrev"] == null ? null : json["indentPrev"],
      );

  Map<String, dynamic> toJson() => {
        "title": title == null ? null : title,
        "index": index == null ? null : index,
        "indent": indent == null ? null : indent,
        "titleNext": titleNext == null ? null : titleNext,
        "indexNext": indexNext == null ? null : indexNext,
        "indentNext": indentNext == null ? null : indentNext,
        "titlePrev": titlePrev == null ? null : titlePrev,
        "indexPrev": indexPrev == null ? null : indexPrev,
        "indentPrev": indentPrev == null ? null : indentPrev,
      };
}
