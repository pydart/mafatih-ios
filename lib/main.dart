import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/splashScreen.dart';
import 'package:mafatih/ui/about.dart';
import 'package:mafatih/ui/home2.dart';
import 'package:mafatih/ui/settings.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() => runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => UiState()),
      ChangeNotifierProvider(create: (_) => ThemeNotifier()),
    ], child: MyApp()));

//class MyApp extends StatelessWidget {

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
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
        locale:
            Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,

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
          '/about': (context) => About(),
        },
        home: SplashScreen());
  }
}
