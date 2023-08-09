import 'package:firebase_database/firebase_database.dart';
import 'package:paheli/models/answer.dart';

class WotD {
  String _location;
  GameAnswer _answer;
  GameAnswer get answer => _answer;
  static Future<WotD> load({location = 'wotd'}) async {
    print('loaging wotd' + location);
    try {
      Map val = (await FirebaseDatabase.instance.ref(location).once())
          .snapshot
          .value as Map;
      print(val);
      GameAnswer answer = GameAnswer.fromJson(val);
      return WotD._internal(location, answer);
    } on Exception catch (e) {
      print(e);
      return WotD._internal(
          location, GameAnswer(answer: 'error', meaning: 'error'));
    }
  }

  WotD._internal(String location, GameAnswer answer)
      : _location = location,
        _answer = answer;
}
