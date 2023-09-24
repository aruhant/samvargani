import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:paheli/firebase_options.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/utils/notifications.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_intro.dart';
import 'package:paheli/widgets/language_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:paheli/widgets/tutorial.dart';
import 'package:upgrader/upgrader.dart';
import 'package:paheli/models/wotd.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  initializeNotifications();

  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FirebaseDatabase.instance.setPersistenceEnabled(true);
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(true);
    FirebaseAnalytics.instance
        .setUserProperty(name: 'os', value: Platform.operatingSystem);
  } catch (e) {
    print(e);
  }
  await EasyLocalization.ensureInitialized();
  await UserPrefs.init();
  UserPrefs.instance.increaseRunCount();
  WotD.load();

  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('hi', 'IN'),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    UserPrefs.instance.setContext(context);
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: false,
      builder: (context, child) {
        return MaterialApp(
            color: const Color.fromRGBO(244, 241, 222, 1),
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            debugShowCheckedModeBanner: false,
            theme: FlexThemeData.light(scheme: FlexScheme.gold),
            darkTheme: FlexThemeData.light(scheme: FlexScheme.gold),
            themeMode: ThemeMode.light,
            home: UpgradeAlert(
              upgrader: Upgrader(
                  showIgnore: false,
                  showLater: false,
                  dialogStyle: Platform.isIOS
                      ? UpgradeDialogStyle.cupertino
                      : UpgradeDialogStyle.material),
              child: (UserPrefs.instance.shouldShowLocaleSettings)
                  ? LanguagePicker(
                      onLocaleSelected: () =>
                          setState(() => UserPrefs.instance.localeSet()),
                    )
                  : (UserPrefs.instance.shouldShowHelp)
                      ? GameHelpWidget(
                          onIntroEnd: () =>
                              setState(() => UserPrefs.instance.firstRunDone()),
                        )
                      : UserPrefs.instance.tutorialIndex > tutorialWords.length
                          ? const DailyGame()
                          : const Tutorial(),
            ));
      },
    );
  }
}
