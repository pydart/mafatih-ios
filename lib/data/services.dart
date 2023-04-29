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
import 'package:flutter/services.dart';
import '../AES Encryption/AES.dart';

class ServiceData {
  // var infosurah = 'surah/surah-info.json';
//  var infdailyDoa = 'surah/dailyDoa-info.json';
//   var infdailyDoa = 'python/DailyDoa/dailyDoa-info.json';
  var infoFasl = 'python/Babs/infobabs/infoBabs.txt';
  static var infoFasl1 = 'python/Babs/infobabs/infobab1.txt';
  static var infoFasl2 = 'python/Babs/infobabs/infobab2.txt';
  static var infoFasl3 = 'python/Babs/infobabs/infobab3.txt';
  static var infoFasl4 = 'python/Babs/infobabs/infobab4.txt';
  static var infoFasl6 = 'python/Babs/infobabs/infobab6.txt';
  static var infoFasl7 = 'python/Babs/infobabs/infobab7.txt';
  AESEncryption encryption = new AESEncryption();

  var dict = {
    1: infoFasl1,
    2: infoFasl2,
    3: infoFasl3,
    4: infoFasl4,
    6: infoFasl6,
    7: infoFasl7
  };
  // var listdoa = 'surah/doa-harian.json';
  // var listasmaulhusna = 'surah/asmaul-husna.json';
  var ayatkursi = 'python/DailyDoa/dailyDoa-info.txt';
  // var jadwalsholat = 'http://muslimsalat.com/';

  // Future<List<SurahInfo>> loadInfo() async {
  //   var response = await rootBundle.loadString(infosurah);
  //   Iterable data = json.decode(response);
  //   return data.map((model) => SurahInfo.fromJson(model)).toList();
  // }

  // Future<List<dailyDoaInfo>> loaddailyDoaInfo() async {
  //   var response = await rootBundle.loadString(infdailyDoa);
  //   Iterable data = json.decode(response);
  //   return data.map((model) => dailyDoaInfo.fromJson(model)).toList();
  // }

  Future<List<FaslInfo>> loadFaslInfo() async {
    // var response = await rootBundle.loadString(infoFasl);
    // Iterable data = json.decode(response);
    // return data.map((model) => FaslInfo.fromJson(model)).toList();

    final jsonEncrypted =
    await rootBundle.loadString(infoFasl);
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    Iterable decryptedDecoded = await json.decode(decrypted);
    // var data = decryptedDecoded['data'];
    return decryptedDecoded.map((model) => FaslInfo.fromJson(model)).toList();

  }

  Future<List<FaslSecInfo>> loadFaslSecInfo(int index) async {
    // var response = await rootBundle.loadString(dict[index]); //dict[index]
    // Iterable data = json.decode(response);
    // return data.map((model) => FaslSecInfo.fromJson(model)).toList();

    final jsonEncrypted =
    await rootBundle.loadString(dict[index]);
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    Iterable decryptedDecoded = await json.decode(decrypted);
    // var data = decryptedDecoded['data'];
    return decryptedDecoded.map((model) => FaslSecInfo.fromJson(model)).toList();
  }

  Future<List<MixedTextInfoAll>> loadMixedTextInfoAll() async {
    // var response = await rootBundle.loadString(
    //     'python/Babs/ListofJsonForSearch2.json'); //infobabMixedTextInfoAll
    // Iterable data = json.decode(response);
    // return data.map((model) => MixedTextInfoAll.fromJson(model)).toList();

    final jsonEncrypted =
    await rootBundle.loadString('python/Babs/infobabs/ListofJsonForSearch2.txt');
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    Iterable decryptedDecoded = await json.decode(decrypted);
    // var data = decryptedDecoded['data'];
    return decryptedDecoded.map((model) => MixedTextInfoAll.fromJson(model)).toList();

  }

  Future<List<JsonMappingForSearch>> loadForSearch() async {
    // var response =
    //     await rootBundle.loadString('python/Babs/ListofJsonForSearch.json');
    // Iterable data = json.decode(response);
    // return data.map((model) => JsonMappingForSearch.fromJson(model)).toList();


    final jsonEncrypted =
    await rootBundle.loadString('python/Babs/infobabs/ListofJsonForSearch.txt');
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    Iterable decryptedDecoded = await json.decode(decrypted);
    // var data = decryptedDecoded['data'];
    return decryptedDecoded.map((model) => JsonMappingForSearch.fromJson(model)).toList();
  }

  // Future<DailyDoa> loadDailyDoa(int number) async {
  //   final response =
  //       await rootBundle.loadString('python/DailyDoa/$number.json');
  //   var res = json.decode(response);
  //   var data = res['$number'];
  //   return DailyDoa.fromJson(data);
  // }

  Future<DailyDoa> loadSec(int indexFasl, String number) async {
    final jsonEncrypted =
    await rootBundle.loadString('python/Babs/$indexFasl/$number.txt');
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    final decryptedDecoded = await json.decode(decrypted);
    var data = decryptedDecoded["$number"];
    return DailyDoa.fromJson(data);

  }

  Future<DailyDoa4> loadSec4(int indexFasl, int number) async {
    final jsonEncrypted =
    await rootBundle.loadString('python/Babs/$indexFasl/$number.txt');
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    final decryptedDecoded = await json.decode(decrypted);
    var data = decryptedDecoded["$number"];
    return DailyDoa4.fromJson(data);

  }

  Future<AyathKursi> loadAyatKursi() async {
    // var response = await rootBundle.loadString(ayatkursi);
    // var res = json.decode(response);
    // var data = res['data'];
    // return AyathKursi.fromJson(data);

    final jsonEncrypted =
    await rootBundle.loadString(ayatkursi);
    var decrypted = encryption.decryptMsg(encryption.getCode(jsonEncrypted));
    final decryptedDecoded = await json.decode(decrypted);
    var data = decryptedDecoded['data'];
    return AyathKursi.fromJson(data);
  }
}
