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
  var infosurah = 'surah/surah-info.json';
//  var infdailyDoa = 'surah/dailyDoa-info.json';
  var infdailyDoa = 'python/DailyDoa/dailyDoa-info.json';
  var infoFasl = 'python/Babs/infoBabs.json';
  static var infoFasl1 = 'python/Babs/infobab1.json';
  static var infoFasl2 = 'python/Babs/infobab2.json';
  static var infoFasl3 = 'python/Babs/infobab3.json';
  static var infoFasl4 = 'python/Babs/infobab4.json';
  static var infoFasl6 = 'python/Babs/infobab6.json';
  static var infoFasl7 = 'python/Babs/infobab7.json';

  var dict = {
    1: infoFasl1,
    2: infoFasl2,
    3: infoFasl3,
    4: infoFasl4,
    6: infoFasl6,
    7: infoFasl7
  };
  var listdoa = 'surah/doa-harian.json';
  var listasmaulhusna = 'surah/asmaul-husna.json';
  var ayatkursi = 'python/DailyDoa/dailyDoa-info.json';
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
        'python/Babs/ListofJsonForSearch2.json'); //infobabMixedTextInfoAll
    Iterable data = json.decode(response);
    return data.map((model) => MixedTextInfoAll.fromJson(model)).toList();
  }

  Future<List<JsonMappingForSearch>> loadForSearch() async {
    var response =
        await rootBundle.loadString('python/Babs/ListofJsonForSearch.json');
    Iterable data = json.decode(response);
    return data.map((model) => JsonMappingForSearch.fromJson(model)).toList();
  }

  Future<DailyDoa> loadDailyDoa(int number) async {
    final response =
        await rootBundle.loadString('python/DailyDoa/$number.json');
    var res = json.decode(response);
    var data = res['$number'];
    return DailyDoa.fromJson(data);
  }

  Future<DailyDoa> loadSec(int indexFasl, int number) async {
    final response =
        await rootBundle.loadString('python/Babs/$indexFasl/$number.json');
    var res = json.decode(response);
    var data = res['$number'];
    return DailyDoa.fromJson(data);
  }

  Future<DailyDoa4> loadSec4(int indexFasl, int number) async {
    final response =
        await rootBundle.loadString('python/Babs/$indexFasl/$number.json');
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
