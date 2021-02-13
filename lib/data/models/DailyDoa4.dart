// To parse this JSON data, do
//
//     final allSurah = allSurahFromJson(jsonString);

import 'dart:convert';

List<Map<String, DailyDoa4>> dailyDoaFromJson(String str) =>
    List<Map<String, DailyDoa4>>.from(json.decode(str).map((x) => Map.from(x)
        .map((k, v) => MapEntry<String, DailyDoa4>(k, DailyDoa4.fromJson(v)))));

String dailyDoaToJson(List<Map<String, DailyDoa4>> data) =>
    json.encode(List<dynamic>.from(data.map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class DailyDoa4 {
  int number;
  String title; //name
  int bab; //name
  int delay; //name

  Map<String, String> arabic;
  Map<String, String> farsi;
  Map<String, String> tozih;
  Map<String, String> Sharh;

  DailyDoa4({
    this.number,
    this.title,
    this.arabic,
    this.bab,
    this.Sharh,
    this.farsi,
    this.tozih,
    this.delay,
  });

  factory DailyDoa4.fromJson(Map<String, dynamic> json) => DailyDoa4(
        number: json["number"] == null ? null : json["number"],
        bab: json["bab"] == null ? null : json["bab"],
        delay: json["delay"] == null ? null : json["delay"],

        title: json["title"] == null ? null : json["title"],
        arabic: json["arabic"] == null
            ? null
            : Map.from(json["arabic"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        farsi: json["farsi"] == null
            ? null
            : Map.from(json["farsi"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        tozih: json["tozih"] == null
            ? null
            : Map.from(json["tozih"])
                .map((k, v) => MapEntry<String, String>(k, v)),
        Sharh: json["Sharh"] == null
            ? null
            : Map.from(json["Sharh"])
                .map((k, v) => MapEntry<String, String>(k, v)),

//        farsi:
//            json["farsi"] == null ? null : Translations.fromJson(json["farsi"]),
      );

  Map<String, dynamic> toJson() => {
        "number": number == null ? null : number,
        "bab": bab == null ? null : bab,
        "delay": delay == null ? null : delay,

        "title": title == null ? null : title,
        "arabic": arabic == null
            ? null
            : Map.from(arabic).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "farsi": farsi == null
            ? null
            : Map.from(farsi).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tozih": tozih == null
            ? null
            : Map.from(tozih).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Sharh": Sharh == null
            ? null
            : Map.from(Sharh).map((k, v) => MapEntry<String, dynamic>(k, v)),
//        "translations": farsi == null ? null : farsi.toJson(),
      };
}
