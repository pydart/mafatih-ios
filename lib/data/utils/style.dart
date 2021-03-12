import 'package:flutter/material.dart';

import 'package:flutter/material.dart';
//import 'package:hexcolor/hexcolor.dart';
import 'package:provider/provider.dart';
import 'package:mafatih/data/themes.dart';

var themeNotifier = ThemeNotifier();

class AppStyle {
  static double ayahsize = 26.0;
  static final LinearGradient mainGradient = LinearGradient(colors: [
    Color(0xff338b93),
    Color(0xffb6f492),
  ]);

  // static bool darkMsh = themeNotifier.darkmode;

  static final title = TextStyle(
    fontSize: 16.0,
    fontFamily: 'IRANSans',
  );

  static final titleFasl = TextStyle(
    fontSize: 16.0,
    fontWeight: FontWeight.w700,
    fontFamily: 'IRANSans',
  );
  static final titleup = TextStyle(
    fontSize: 20.0,
    fontFamily: 'IRANSans',
  );

  static final titleupdetailsec = TextStyle(
    fontSize: 20.0,
    fontFamily: 'IRANSans',
  );

  static final titleBab = TextStyle(
    fontSize: 20.0,
    fontWeight: FontWeight.w500,
    fontFamily: 'IRANSans',
  );
//      color: darkMsh ? Colors.white : Colors.black
//      color: Hexcolor('#212121'));
  static final subtitle = TextStyle(
      fontSize: 20.0, fontFamily: 'IRANSans'); //color: Hexcolor('#212121'),

  static final ref = TextStyle(
      fontSize: 20.0,
      fontFamily: 'IRANSans',
      height: 1.2); //color: Hexcolor('#212121'),

  static final about = TextStyle(
      fontSize: 20.0,
      fontFamily: 'far_nazanin',
      height: 1.2); //color: Hexcolor('#212121'),

  static final end2subtitle = TextStyle(
      fontSize: 18.0,
      color: const Color(0xffAFB42B), //Hexcolor('#AFB42B'),
//      color: Colors.green,
      fontWeight: FontWeight.w700,
      fontFamily: 'IRANSans');

  static final number = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    fontFamily: 'IRANSans',
  );
//      color: Hexcolor('#212121')

  static final setting = TextStyle(fontSize: 16.0, fontFamily: 'IRANSans');
//      color: Hexcolor('#212121')
  static final settingRelated =
      TextStyle(fontSize: 18.0, fontFamily: 'IRANSans', color: Colors.green);

  static final detailsurahTitle = TextStyle(
      fontSize: 20.0,
      fontWeight: FontWeight.w600,
      fontFamily: 'IRANSans',
      color: Colors.white);

  static final spaceH5 = SizedBox(height: 5);
  static final spaceH10 = SizedBox(height: 10);
  static final ayah = TextStyle(fontSize: ayahsize, height: 1.5);
}
