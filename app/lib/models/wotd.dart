import 'package:firebase_database/firebase_database.dart';
import 'package:paheli/models/answer.dart';

class WotD {
  String _location;
  GameAnswer _answer;
  GameAnswer get answer => _answer;
  static Future<WotD> load({location = 'wotd'}) async {
    FirebaseDatabase.instance.ref(location).once();
    Map val = (await FirebaseDatabase.instance.ref(location).once())
        .snapshot
        .value as Map;
    GameAnswer answer = GameAnswer.fromJson(val);

    return WotD._internal(location, answer);
  }

  WotD._internal(String location, GameAnswer answer)
      : _location = location,
        _answer = answer;
}
