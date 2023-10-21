import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:hindi/models/answer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:hindi/translations/locale_keys.g.dart';

class WotD {
  static final List<String> monthsInString = [
    LocaleKeys.dailyGame_months_1.tr(),
    LocaleKeys.dailyGame_months_2.tr(),
    LocaleKeys.dailyGame_months_3.tr(),
    LocaleKeys.dailyGame_months_4.tr(),
    LocaleKeys.dailyGame_months_5.tr(),
    LocaleKeys.dailyGame_months_6.tr(),
    LocaleKeys.dailyGame_months_7.tr(),
    LocaleKeys.dailyGame_months_8.tr(),
    LocaleKeys.dailyGame_months_9.tr(),
    LocaleKeys.dailyGame_months_10.tr(),
    LocaleKeys.dailyGame_months_11.tr(),
    LocaleKeys.dailyGame_months_12.tr(),
  ];
  static int hour = 6;
  static int minute = 00;
  Map<int, GameAnswer> _answers = {};
  GameAnswer get debugAnswer => GameAnswer(
      answer: 'दावत',
      meaning: 'निमंत्रण',
      icons: [LineIcons.envelope],
      title: "21 सितम्बर का दैनिक शब्द",
      colors: const [Color.fromARGB(255, 255, 255, 255)],
      backgroundColor: const Color.fromARGB(255, 240, 207, 255));

  GameAnswer get answer =>
      _answers[day] ??
      GameAnswer(
          answer: 'दावत',
          meaning: 'निमंत्रण',
          icons: [LineIcons.envelope],
          itemsCount: 3,
          title: LocaleKeys.dailyGame_noDailyWord.tr(),
          colors: const [Color.fromARGB(255, 255, 255, 255)],
          backgroundColor: const Color.fromARGB(255, 240, 207, 255));

  GameAnswer get yesterdayAnswer =>
      _answers[yesterday] ??
      GameAnswer(
          answer: 'विद्या',
          meaning: 'ज्ञान',
          icons: [LineIcons.book, LineIcons.school],
          moveHorizontal: false,
          moveVertical: true,
          colors: [Colors.pink[100]!],
          backgroundColor: Colors.pink[50],
          whenToShowIcons: -1,
          title: LocaleKeys.dailyGame_yesterdayWord.tr());
  static int get day {
    return DateTime.now().subtract(Duration(hours: hour, minutes: minute)).day;
  }

  static int get yesterday {
    return DateTime.now()
        .subtract(Duration(hours: hour, minutes: minute, days: 1))
        .day;
  }

  static String get month => monthsInString[
      (DateTime.now().subtract(Duration(hours: hour, minutes: minute)).month) -
          1];

  static String get yesterdayMonth => monthsInString[(DateTime.now()
          .subtract(Duration(hours: hour, minutes: minute, days: 1))
          .month) -
      1];
  static makeTitle(int day) =>
      LocaleKeys.dailyGame_title.tr(args: [day.toString(), month]);

  static Stream<WotD> listen() {
    return FirebaseDatabase.instance.ref('wotd').onValue.map((event) {
      Map<int, GameAnswer> answers = {};
      Map val = event.snapshot.value as Map;
      for (String key
          in val.keys.where((element) => RegExp(r'^\d+$').hasMatch(element))) {
        GameAnswer answer = GameAnswer.fromJson(val[key]);
        answers[int.parse(key)] = answer;
      }
      return WotD._internal(answers);
    });
  }

  static Future<WotD> load() {
    return FirebaseDatabase.instance.ref('wotd').once().then((event) {
      Map<int, GameAnswer> answers = {};
      Map val = event.snapshot.value as Map;
      print(val);
      for (String key
          in val.keys.where((element) => RegExp(r'^\d+$').hasMatch(element))) {
        print(key);
        GameAnswer answer = GameAnswer.fromJson(val[key]);
        answers[int.parse(key)] = answer;
        print(answer.answer);
      }
      return WotD._internal(answers);
    }).catchError((e) {
      print(e);
      return WotD._internal({});
    });
  }

  WotD._internal(Map<int, GameAnswer> answers) {
    _answers = answers;
  }
}
