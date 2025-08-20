import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/translations/locale_keys.g.dart';

class WotD {
  static final List<String> nameOfMonths = [
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
    // title: "21 सितम्बर का दैनिक शब्द",
    difficulty: 2, // easy
    colors: const [Color.fromARGB(255, 255, 255, 255)],
    backgroundColor: const Color.fromARGB(255, 240, 207, 255),
  );

  GameAnswer? get answer => _answers[day];

  GameAnswer get yesterdayAnswer =>
      _answers[yesterday] 
      ??
      GameAnswer(
        answer: 'विद्या',
        meaning: 'ज्ञान',
        icons: [LineIcons.book, LineIcons.school],
        moveHorizontal: false,
        moveVertical: true,
        colors: [Colors.pink[100]!],
        backgroundColor: Colors.pink[50],
        whenToShowIcons: -1,
        title: LocaleKeys.dailyGame_yesterdayWord.tr(),
      )
      ;
  static int get day {
    print("day: ${DateTime.now()
            .subtract(
              Duration(
                hours: hour,
                minutes: minute,
                days: -UserProperties.instance.timeDelta,
              ),
            )
            .millisecondsSinceEpoch ~/ (24 * 60 * 60 * 1000)}");
    return DateTime.now()
            .subtract(
              Duration(
                hours: hour,
                minutes: minute,
                days: -UserProperties.instance.timeDelta,
              ),
            )
            .millisecondsSinceEpoch ~/ (24 * 60 * 60 * 1000);
    
  }

  static int get yesterday {
    return DateTime.now()
        .subtract(Duration(hours: hour, minutes: minute, days: 1))
        .day;
  }

  static List<String>? getDayAndMonthForTitle(int? day) {
    if (day == null) return null;
    // day is days since epoch convert it to year, month, day. ignore the year part
    DateTime date = DateTime.fromMillisecondsSinceEpoch(
      day * 24 * 60 * 60 * 1000,
    );
    day = date.day;

    if ((DateTime.now().day - day) > 15) {
      DateTime now = DateTime.now();
      String nextmonth = DateFormat.MMMM(
        UserProperties.instance.locale,
      ).format(now.copyWith(month: now.month + 1));
      return [day.toString(), nextmonth];
    } else if ((DateTime.now().day - day) < -15) {
      DateTime now = DateTime.now();
      String previousmonth = DateFormat.MMMM(
        UserProperties.instance.locale,
      ).format(now.copyWith(month: now.month - 1));
      return [day.toString(), previousmonth];
    } else {
      String month = DateFormat.MMMM(
        UserProperties.instance.locale,
      ).format(DateTime.now());
      return [day.toString(), month];
      // return LocaleKeys.dailyGame_title.tr(args: [day.toString(), month]);
    }
  }

  static Stream<WotD> listen() {
    return FirebaseDatabase.instance.ref('wotd').onValue.map((event) {
      Map<int, GameAnswer> answers = {};
      Map val = event.snapshot.value as Map;
      for (String key in val.keys.where(
        (element) => RegExp(r'^\d+$').hasMatch(element),
      )) {
        GameAnswer answer = GameAnswer.fromJson(val[key], int.parse(key));
        answers[int.parse(key)] = answer;
      }
      return WotD._internal(answers);
    });
  }

  static Future<WotD> load() {
    return FirebaseDatabase.instance
        .ref('wotd')
        .once()
        .then((event) {
          Map<int, GameAnswer> answers = {};
          Map val = event.snapshot.value as Map;
          for (String key in val.keys.where(
            (element) => RegExp(r'^\d+$').hasMatch(element),
          )) {
            GameAnswer answer = GameAnswer.fromJson(val[key], int.parse(key));
            answers[int.parse(key)] = answer;
          }
          return WotD._internal(answers);
        })
        .catchError((e) {
          //print(e);
          return WotD._internal({});
        });
  }

  WotD._internal(Map<int, GameAnswer> answers) {
    _answers = answers;
  }
}

