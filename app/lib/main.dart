import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:jiffy/jiffy.dart';
import 'package:paheli/firebase_options.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/user_properties.dart';
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
  await UserProperties.init();
  UserProperties.instance.increaseRunCount();
  WotD.load();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('hi', 'IN'),
      startLocale: Locale(UserProperties.instance.locale.split('_').first, UserProperties.instance.locale.split('_').last),
      child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    UserProperties.instance.setContext(context);
    Jiffy.setLocale(UserProperties.instance.locale.split('_').first);
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
    //print(UserPrefs.instance.tutorialIndex);
    //print(tutorialWords.length);
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
            showIgnore: false,
            showLater: false,
            dialogStyle: UpgradeDialogStyle.cupertino,
            child: (UserProperties.instance.shouldShowLocaleSettings)
                ? LanguagePicker(
                    onLocaleSelected: () =>
                        setState(() => UserProperties.instance.localeSet()),
                  )
                : (UserProperties.instance.shouldShowHelp)
                    ? GameHelpWidget(
                        onIntroEnd: () => setState(
                            () => UserProperties.instance.firstRunDone()),
                      )
                    : UserProperties.instance.tutorialIndex >=
                                tutorialWords.length ||
                            UserProperties.instance.practiceGameIndex > 0
                        ? const DailyGame()
                        : const Tutorial()));
  }
}
