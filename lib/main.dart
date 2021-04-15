import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/splashScreen.dart';
//import 'package:mafatih/ui/about.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/home_about.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:mafatih/ui/widget/listSec.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UiState(), lazy: false),
      ChangeNotifierProvider(create: (_) => ThemeNotifier(), lazy: false),
    ], child: MyApp()));

//class MyApp extends StatelessWidget {

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  getThemeType() async {
    prefs = await SharedPreferences.getInstance();
    // setState(() {
    //   // globals.themeType = false;
    // });
    if (prefs.containsKey(globals.ThemeType)) {
      var _themeType = prefs.getBool(globals.ThemeType);
      setState(() {
        globals.themeType = _themeType;
      });
    }
    print(
        '%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   ${globals.themeType}       globals.themeType');
  }

  @override
  void initState() {
    super.initState();
    globals.themeType = globals.themeType == null ? false : globals.themeType;

    // getThemeType();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,

      builder: (context, child) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: child,
        );
      },
      debugShowCheckedModeBanner: false,
      title: 'مفاتیح الجنان',
      theme: Provider.of<ThemeNotifier>(context).curretThemeData,
      initialRoute: 'mafatih/',
      routes: {
        'home': (context) => Home(),
        '/settings': (context) => Settings(),
        '/Favorites': (context) => Favorites(),
        '/ListSec': (context) => ListSec(),
//          '/about': (context) => HomeAbout(),
      },

      home: Home(),
    );
  }
}
