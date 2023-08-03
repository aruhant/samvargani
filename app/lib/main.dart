import 'package:flutter/material.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/widgets/game_help.dart';
import 'package:paheli/widgets/practice_game.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:easy_localization/easy_localization.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await UserPrefs.init();
  runApp(EasyLocalization(
      supportedLocales: const [Locale('en', 'US'), Locale('hi', 'IN')],
      path: 'assets/translations',
      fallbackLocale: const Locale('hi', 'IN'),
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      color: const Color.fromRGBO(244, 241, 222, 1),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      debugShowCheckedModeBanner: false,
      theme: FlexThemeData.light(scheme: FlexScheme.money),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.mandyRed),
      themeMode: ThemeMode.system,
      home: true || (UserPrefs.instance.firstRun)
          ? const GameHelpWidget()
          : const PracticeGame(),
    );
  }
}
