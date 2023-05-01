import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mafatih/library//Globals.dart' as globals;
import 'package:url_launcher/url_launcher.dart';

import '../constants.dart';

class SharedFunc {
  SharedPreferences prefs;


  launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  setLaterDialog() async {
    prefs = await SharedPreferences.getInstance();
    bool level = false;
    globals.laterDialog = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setBool(globals.LaterDialog, level);
  }

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  no_update(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("بستن",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 12,
          )),
      onPressed: () {
        setLaterDialog();
        Navigator.pop(context, false);
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("به روزرسانی",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 16,
          )),
      content: Text("نسخه جدیدی از برنامه برای به روزرسانی موجود نمی باشد.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 16,
          )),
      actions: [
        cancelButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  updater(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("بعدا",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 12,
          )),
      onPressed: () {
        setLaterDialog();
        Navigator.pop(context, false);
      },
    );
    Widget continueButton = TextButton(
      child: Text("بروز رسانی",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 16,
          )),
      onPressed: () => _launchURL(Constants.PLAY_STORE_URL),
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("به روزرسانی",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 16,
          )),
      content: Text("نسخه جدیدی از برنامه برای به روزرسانی موجود می باشد.",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontFamily: 'IRANSans',
            fontSize: 16,
          )),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future upgrader(context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title:
                  Text("نسخه جدیدی از برنامه برای به روزرسانی موجود می باشد.",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        fontSize: 16,
                      )),
              actions: <Widget>[
                ElevatedButton(
                  child: Text("به روزرسانی",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IRANSans',
                        fontSize: 16,
                      )),
                  onPressed: () => _launchURL(Constants.storeUrlAshoura),
//                  onPressed: () => Navigator.pop(context, true),
                ),
                ElevatedButton(
                  child: Text(
                    "بعدا",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IRANSans',
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.right,
                  ),
                  onPressed: () {
                    setLaterDialog();

                    Navigator.pop(context, false);
                  },
                ),
              ],
            ));
  }
}
