import 'package:flutter/material.dart';
import 'package:mafatih/library/Globals.dart' as globals;


class UiState with ChangeNotifier {
  static double ayahsize = globals.fontArabicLevel;
  static double textsize = globals.fontTarjLevel;
  static double fontSizeT = globals.fontTozihLevel;

  static bool translate = globals.tarjActive;
  static bool makna = globals.tozihActive;
//  static double light = 0.5;

  set fontSize(newValue) {
    ayahsize = newValue;
    notifyListeners();
  }

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
}
