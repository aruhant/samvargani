import 'package:firebase_database/firebase_database.dart';
import 'package:paheli/models/answer.dart';

class WotD {
  final WotD _instance = WotD();
  WotD get instance => _instance;
  late GameAnswer _answer;
  GameAnswer get answer => _answer;
  WotD() {
    _answer = GameAnswer(answer: 'शब्द', meaning: 'अर्थ');
    FirebaseDatabase.instance.ref('wotd').onValue.listen((event) {
      _answer = GameAnswer.fromJson(event.snapshot.value as Map);
    });
  }
}
