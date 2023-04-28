import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class UiState with ChangeNotifier {
  static double ayahsize = globals.fontArabicLevel;
  static String fontType = globals.fontArabic;

  static double textsize = globals.fontTarjLevel;
  static double fontSizeT = globals.fontTozihLevel;

  static bool translate = globals.tarjActive;
  static bool makna = globals.tozihActive;
//  static double light = 0.5;

  set fontSize(newValue) {
    ayahsize = newValue;
    notifyListeners();
  }

  set fontFormat(newValue) {
    fontType = newValue;
    notifyListeners();
  }

  String get fontFormat => fontType;
  double get fontSize => ayahsize;
  double get sliderFontSize => ayahsize;

  set fontSizetext(newValue) {
    textsize = newValue;
    notifyListeners();
  }

  double get fontSizetext => textsize;
  double get sliderFontSizetext => textsize;

  set fontSizeTozih(newValue) {
    fontSizeT = newValue;
    notifyListeners();
  }

  double get fontSizeTozih => fontSizeT;
  double get sliderfontSizeTozih => fontSizeT;

//  set lightlevel(newValue) {
//    light = newValue;
//    notifyListeners();
//  }
//
//  double get lightlevel => light * 10;
//  double get sliderLightlevel => light;

  set terjemahan(newValue) {
    translate = newValue;
    notifyListeners();
  }

  bool get terjemahan => translate;

  set tafsir(newValue) {
    makna = newValue;
    notifyListeners();
  }

  bool get tafsir => makna;


  static bool edameFarazGet = globals.edameFaraz;
  set edameFarazSet(newValue) {
    edameFarazGet = newValue;
    notifyListeners();
  }
  bool get edameFarazSet => edameFarazGet;

  static bool tarjKhatiGet = globals.tarjKhati;
  set tarjKhatiSet(newValue) {
    tarjKhatiGet = newValue;
    notifyListeners();
  }
  bool get tarjKhatiSet => tarjKhatiGet;

  // static String soundType = globals.sound;
  // set soundFormat(newValue) {
  //   soundType = newValue;
  //   String filePath = "assets/sounds/ashoura/$soundType.mp3";
  //   // final assetsAudioPlayer = AssetsAudioPlayer();
  //   // assetsAudioPlayer.open(Audio(filePath),
  //   //     autoStart: false, respectSilentMode: false, showNotification: false);
  //   notifyListeners();
  // }


}
