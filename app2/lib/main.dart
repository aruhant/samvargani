import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hindi/firebase_options.dart';
import 'package:hindi/game2_widget.dart';
import 'package:hindi/models/answer.dart';
import 'package:hindi/models/matrix.dart';
import 'package:hindi/models/user_prefs.dart';
import 'package:hindi/utils/notifications.dart';
import 'package:hindi/widgets/game_intro.dart';
import 'package:hindi/widgets/language_picker.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:upgrader/upgrader.dart';
import 'package:hindi/models/wotd.dart';

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
        return makeMaterialApp(context);
      },
    );
  }

  MaterialApp makeMaterialApp(BuildContext context) {
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
                dialogStyle: UpgradeDialogStyle.cupertino),
            child: (UserPrefs.instance.shouldShowLocaleSettings)
                ? LanguagePicker(
                    onLocaleSelected: () =>
                        setState(() => UserPrefs.instance.localeSet()),
                  )
                : (false && UserPrefs.instance.shouldShowHelp)
                    ? GameHelpWidget(
                        onIntroEnd: () =>
                            setState(() => UserPrefs.instance.firstRunDone()),
                      )
                    : UserPrefs.instance.tutorialIndex >=
                                tutorialWords.length ||
                            UserPrefs.instance.practiceGameIndex > 0
                        ? Game2Widget(matrices: getTestMatrices())
                        : Game2Widget(matrices: getTestMatrices())));
  }
}

WordMatrices getTestMatrices() {
  return WordMatrices(matrices: [
    WordMatrix.fromValues(offset: const Offset(1, 1), values: [
      (0, 0, 'a'),
      (0, 1, 'p'),
      (0, 2, 'p'),
      (0, 3, 'l'),
      (0, 4, 'e')
    ]),
    WordMatrix.fromValues(values: [
      (0, 0, 'o'),
      (1, 0, 'r'),
      (2, 0, 'a'),
      (3, 0, 'n'),
      (4, 0, 'g'),
      (5, 0, 'e'),
      (6, 0, 's'),
    ], offset: const Offset(5, 5)),
    WordMatrix.fromValues(values: [
      (0, 0, 'b'),
      (0, 1, 'a'),
      (0, 2, 'n'),
      (0, 3, 'a'),
      (0, 4, 'n'),
      (0, 5, 'a'),
    ], offset: const Offset(10, 10)),
  ]);
}
