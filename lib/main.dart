import 'package:admob_flutter/admob_flutter.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/theming/theme/AppConstants.dart';
import 'package:mafatih/theming/theme/custom_theme_mode.dart';
import 'package:mafatih/theming/theme/dark_theme.dart';
import 'package:mafatih/theming/theme/light_theme.dart';
import 'package:mafatih/ui/listpage/home2.dart';
import 'package:mafatih/ui/listpage/settings.dart';
import 'package:flutter/material.dart';
import 'package:mafatih/ui/widget/favorites.dart';
import 'package:mafatih/ui/listpage/listSec.dart';
import 'package:provider/provider.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:mafatih/library/Globals.dart' as globals;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:easy_localization/easy_localization.dart';
// import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:adivery/adivery.dart';
import 'package:adivery/adivery_ads.dart';


final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  // MobileAds.instance.initialize();
  Admob.initialize();
  final appId = "bilpdqakqjndpildsbqprjprsdjrctprgdikdkapefddbmdpjlioktsosrtqgkqgjefngn";
  AdiveryPlugin.initialize("f53c7111-1b46-4b1f-8daa-a652bc5182a1");


  runApp(EasyLocalization(
    supportedLocales: [
      AppConstants.TR_LOCALE,
      AppConstants.EN_LOCALE,
      AppConstants.AR_LOCALE,
      AppConstants.FA_LOCALE
    ],
    path: AppConstants.LANG_PATH,
    startLocale: AppConstants.FA_LOCALE,
    child: MultiProvider(providers: [
      ChangeNotifierProvider(create: (context) => CustomThemeMode()),

      ChangeNotifierProvider(create: (_) => UiState(), lazy: false),
      // ChangeNotifierProvider(create: (_) => ThemeNotifier(), lazy: false),
    ], child: MyApp()),
  ));
}

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
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,
      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: Provider.of<CustomThemeMode>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      title: 'مفاتیح الجنان',
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
