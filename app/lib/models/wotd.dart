import 'package:firebase_database/firebase_database.dart';
import 'package:paheli/models/answer.dart';

class WotD {
  static int hour = 6;
  static int minute = 00;
  Map<int, GameAnswer> _answers = {};
  GameAnswer get answer => _answers[day] ?? gameAnswers[20];
  static int get day {
    print(DateTime.now().day);
    return DateTime.now().subtract(Duration(hours: hour, minutes: minute)).day;
    // print(DateTime.now().millisecondsSince Epoch ~/ 86400000);
    // return DateTime.now().millisecondsSinceEpoch ~/ 86400000;
  }

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
