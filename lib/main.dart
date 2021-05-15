import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mafatih/data/themes.dart';
import 'package:mafatih/data/uistate.dart';
import 'package:mafatih/splashScreen.dart';
import 'package:mafatih/theming/theme/AppConstants.dart';
import 'package:mafatih/theming/theme/custom_theme_mode.dart';
import 'package:mafatih/theming/theme/dark_theme.dart';
import 'package:mafatih/theming/theme/light_theme.dart';
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
import 'package:easy_localization/easy_localization.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
NotificationAppLaunchDetails notificationAppLaunchDetails;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
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
      // localizationsDelegates: context.localizationDelegates,
      // supportedLocales: context.supportedLocales,
      // locale: context.locale,

      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales
      ],
      locale: Locale("fa", "IR"), // OR Locale('ar', 'AE') OR Other RTL locales,

      // builder: (context, child) {
      //   return Directionality(
      //     textDirection: TextDirection.rtl,
      //     child: child,
      //   );
      // },

      theme: themeLightData,
      darkTheme: themeDarkData,
      themeMode: Provider.of<CustomThemeMode>(context).getThemeMode,
      debugShowCheckedModeBanner: false,
      title: 'مفاتیح الجنان',
      // theme: Provider.of<ThemeNotifier>(context).curretThemeData,
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
