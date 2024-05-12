// To parse this JSON data, do
//
//     final allSurah = allSurahFromJson(jsonString);

import 'dart:convert';

List<Map<String, JsonMappingForSearch>> JsonMappingForSearchFromJson(
        String str) =>
    List<Map<String, JsonMappingForSearch>>.from(json.decode(str).map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, JsonMappingForSearch>(
            k, JsonMappingForSearch.fromJson(v)))));

String JsonMappingForSearchToJson(
        List<Map<String, JsonMappingForSearch>> data) =>
    json.encode(List<dynamic>.from(data.map((x) =>
        Map.from(x).map((k, v) => MapEntry<String, dynamic>(k, v.toJson())))));

class JsonMappingForSearch {
  int? number;
  String? title; //name
  int? bab; //name
  int? indexbab; //name

  Map<String, String>? arabic;
  Map<String, String>? arabicSelected;

  Map<String, String>? farsi;
  Map<String, String>? tozih;
  Map<String, String>? Sharh;

  JsonMappingForSearch({
    this.number,
    this.title,
    this.arabic,
    this.arabicSelected,
    this.bab,
    this.indexbab,
    this.Sharh,
    this.farsi,
    this.tozih,
  });

  factory JsonMappingForSearch.fromJson(Map<String, dynamic> json) =>
      JsonMappingForSearch(
        number: json["number"] == null ? null : json["number"],
        bab: json["bab"] == null ? null : json["bab"],
        indexbab: json["indexbab"] == null ? null : json["indexbab"],
        title: json["title"] == null ? null : json["title"],
        arabic: json["arabic"] == null
            ? null
            : Map.from(json["arabic"])
                .map((k, v) => MapEntry<String, String>(k, v)),

        arabicSelected: json["arabicSelected"] == null
            ? null
            : Map.from(json["arabicSelected"])
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
        "indexbab": indexbab == null ? null : indexbab,

        "title": title == null ? null : title,
        "arabic": arabic == null
            ? null
            : Map.from(arabic!).map((k, v) => MapEntry<String, dynamic>(k, v)),

        "arabicSelected": arabicSelected == null
            ? null
            : Map.from(arabicSelected!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),

        "farsi": farsi == null
            ? null
            : Map.from(farsi!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "tozih": tozih == null
            ? null
            : Map.from(tozih!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "Sharh": Sharh == null
            ? null
            : Map.from(Sharh!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//        "translations": farsi == null ? null : farsi.toJson(),
      };
}
