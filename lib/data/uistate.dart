import 'package:flutter/material.dart';

class UiState with ChangeNotifier {
  static double ayahsize = 1;
  static double textsize = 1;
  static double fontSizeT = 1;

  static bool translate = false;
  static bool makna = false;
//  static double light = 0.5;

  set fontSize(newValue) {
    ayahsize = newValue;
    notifyListeners();
  }

  double get fontSize => ayahsize * 33;
  double get sliderFontSize => ayahsize;

  set fontSizetext(newValue) {
    textsize = newValue;
    notifyListeners();
  }

  double get fontSizetext => textsize * 28;
  double get sliderFontSizetext => textsize;

  set fontSizeTozih(newValue) {
    fontSizeT = newValue;
    notifyListeners();
  }

  double get fontSizeTozih => fontSizeT * 30;
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
