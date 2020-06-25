import 'package:screen/screen.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/ui/widget/cardsetting.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'file:///G:/Flutter/Qurani2 -Babs/lib/library/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  double tempBrightnessLevel = globals.brightnessLevel;

  SharedPreferences prefs;
  setBrightnessLevel(double level) async {
    globals.brightnessLevel = level;
    prefs = await SharedPreferences.getInstance();
    prefs.setDouble(globals.BRIGHTNESS_LEVEL, globals.brightnessLevel);
  }

  @override
  Widget build(BuildContext context) {
    var ui = Provider.of<UiState>(context);
    var dark = Provider.of<ThemeNotifier>(context);
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.keyboard_backspace),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text('تنظیمات'),
          elevation: 0.0,
        ),
        body: Column(
          children: <Widget>[
            CardSetting(
              title: 'تم تاریک',
              leading: Switch(
                value: dark.darkmode,
                onChanged: (newValue) => dark.switchTheme(newValue),
              ),
            ),
            CardSetting(
              title: 'ترجمه',
              leading: Switch(
                value: ui.terjemahan,
                onChanged: (newValue) => ui.terjemahan = newValue,
              ),
            ),
            CardSetting(
              title: 'توضیحات',
              leading: Switch(
                value: ui.tafsir,
                onChanged: (newValue) => ui.tafsir = newValue,
              ),
            ),
            CardSlider(
              title: 'سایز متن ',
              slider: Slider(
                min: 0.5,
                value: ui.sliderFontSize,
                onChanged: (newValue) => ui.fontSize = newValue,
              ),
              trailing: ui.fontSize.toInt().toString(),
            ),
            CardSlider(
              title: 'نور صفحه',
              slider: Slider(
                min: 0.1,
                max: 1,
                divisions: 10,
                value: tempBrightnessLevel,
                onChanged: (newValue) {
                  setState(() {
                    tempBrightnessLevel = newValue;
                  });
                  Screen.setBrightness(tempBrightnessLevel);
//                  ui.lightlevel = newValue;
                  setBrightnessLevel(newValue);
                },
              ),
              trailing: (tempBrightnessLevel * 10).toInt().toString(),
            ),
          ],
        ));
  }
}

class CardSlider extends StatelessWidget {
  const CardSlider({
    Key key,
    @required this.title,
    @required this.slider,
    @required this.trailing,
  }) : super(key: key);

  final String title;
  final Widget slider;
  final String trailing;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      child: Card(
        elevation: 0,
        child: ListTile(
          contentPadding: EdgeInsets.only(top: 10, right: 30, left: 15),
          title: Text(title),
          subtitle: slider,
          trailing: Text(trailing,
              style: TextStyle(fontFamily: 'far_nazanin', fontSize: 22)),
        ),
      ),
    );
  }
}
