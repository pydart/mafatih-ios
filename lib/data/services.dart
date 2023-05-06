import 'dart:convert';
import 'package:mafatih/data/models/DailyDoa.dart';
import 'package:mafatih/data/models/ayatkursi.dart';
import 'package:mafatih/data/models/surahinfo.dart';
import 'package:mafatih/data/models/dailyDoaInfo.dart';
import 'package:mafatih/data/models/JsonMappingForSearch.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'models/DailyDoa4.dart';
import 'models/FaslInfo.dart';
import 'models/FaslSecInfo.dart';
import 'models/MixedTextInfoAll.dart';

class ServiceData {
  var infosurah = 'surah/surah-info';
//  var infdailyDoa = 'surah/dailyDoa-info';
  var infdailyDoa = 'python/DailyDoa/dailyDoa-info';
  var infoFasl = 'python/Babs/infobabs/infoBabs';
  static var infoFasl1 = 'python/Babs/infobabs/infobab1';
  static var infoFasl2 = 'python/Babs/infobabs/infobab2';
  static var infoFasl3 = 'python/Babs/infobabs/infobab3';
  static var infoFasl4 = 'python/Babs/infobabs/infobab4';
  static var infoFasl6 = 'python/Babs/infobabs/infobab6';
  static var infoFasl7 = 'python/Babs/infobabs/infobab7';
  static var infoFasl70 = 'python/Babs/infobabs/infobab70';
  static var infoFasl71 = 'python/Babs/infobabs/infobab71';
  static var infoFasl72 = 'python/Babs/infobabs/infobab72';
  static var infoFasl73 = 'python/Babs/infobabs/infobab73';
  static var infoFasl74 = 'python/Babs/infobabs/infobab74';
  static var infoFasl75 = 'python/Babs/infobabs/infobab75';
  static var infoFasl76 = 'python/Babs/infobabs/infobab76';
  static var infoFasl77 = 'python/Babs/infobabs/infobab77';

  var dict = {
    1: infoFasl1,
    2: infoFasl2,
    3: infoFasl3,
    4: infoFasl4,
    6: infoFasl6,
    7: infoFasl7,
    70: infoFasl70,
    71: infoFasl71,
    72: infoFasl72,
    73: infoFasl73,
    74: infoFasl74,
    75: infoFasl75,
    76: infoFasl76,
    77: infoFasl77,
  };
  var listdoa = 'surah/doa-harian';
  var listasmaulhusna = 'surah/asmaul-husna';
  var ayatkursi = 'python/DailyDoa/dailyDoa-info';
  var jadwalsholat = 'http://muslimsalat.com/';

  Future<List<SurahInfo>> loadInfo() async {
    var response = await rootBundle.loadString(infosurah);
    Iterable data = json.decode(response);
    return data.map((model) => SurahInfo.fromJson(model)).toList();
  }

  Future<List<dailyDoaInfo>> loaddailyDoaInfo() async {
    var response = await rootBundle.loadString(infdailyDoa);
    Iterable data = json.decode(response);
    return data.map((model) => dailyDoaInfo.fromJson(model)).toList();
  }

  Future<List<FaslInfo>> loadFaslInfo() async {
    var response = await rootBundle.loadString(infoFasl);
    Iterable data = json.decode(response);
    return data.map((model) => FaslInfo.fromJson(model)).toList();
  }

  Future<List<FaslSecInfo>> loadFaslSecInfo(int index) async {
    var response = await rootBundle.loadString(dict[index]); //dict[index]
    Iterable data = json.decode(response);
    return data.map((model) => FaslSecInfo.fromJson(model)).toList();
  }

  Future<List<MixedTextInfoAll>> loadMixedTextInfoAll() async {
    var response = await rootBundle.loadString(
        'python/Babs/infobabs/ListofJsonForSearch2'); //infobabMixedTextInfoAll
    Iterable data = json.decode(response);
    return data.map((model) => MixedTextInfoAll.fromJson(model)).toList();
  }

  // Future<List<JsonMappingForSearch>> loadForSearch() async {
  //   var response =
  //   await rootBundle.loadString('python/Babs/infobabs/ListofJsonForSearch');
  //   Iterable data = json.decode(response);
  //   return data.map((model) => JsonMappingForSearch.fromJson(model)).toList();
  // }

  Future<DailyDoa> loadDailyDoa(int number) async {
    final response =
    await rootBundle.loadString('python/DailyDoa/$number');
    var res = json.decode(response);
    var data = res['$number'];
    return DailyDoa.fromJson(data);
  }

  Future<DailyDoa> loadSec(int indexFasl, String number) async {
    final response =
    await rootBundle.loadString('python/Babs/$indexFasl/$number');
    var res = json.decode(response);
    var data = res['$number'];
    return DailyDoa.fromJson(data);
  }

  Future<DailyDoa4> loadSec4(int indexFasl, String number) async {
    final response =
    await rootBundle.loadString('python/Babs/$indexFasl/$number');
    var res = json.decode(response);
    var data = res['$number'];
    return DailyDoa4.fromJson(data);
  }

  Future<AyathKursi> loadAyatKursi() async {
    var response = await rootBundle.loadString(ayatkursi);
    var res = json.decode(response);
    var data = res['data'];
    return AyathKursi.fromJson(data);
  }
}