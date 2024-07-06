import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:uuid/uuid.dart';

class UserProperties {
  final bool _darkMode;
  int _initState;
  int _runCount;
  int _practiceGameIndex;
  int _tutorialIndex;
  int _timeDelta;
  int _tooltipsPressed;
  String _locale = 'en';
  String _uid = '';
  String _name = '';
  final SharedPreferences _sharedPrefs;
  UserProperties({
    required bool darkMode,
    required int initState,
    required int practiceGameIndex,
    required int runCount,
    required SharedPreferences sharedPrefs,
    required int tooltipsPressed,
    required int timeDelta,
    required int tutorialIndex,
    required String name,
    required String uid,
  })  : _initState = initState,
        _darkMode = darkMode,
        _practiceGameIndex = practiceGameIndex,
        _sharedPrefs = sharedPrefs,
        _runCount = runCount,
        _timeDelta = timeDelta,
        _tooltipsPressed = tooltipsPressed,
        _tutorialIndex = tutorialIndex,
        _uid = uid,
        _name = name;

  static UserProperties? _instance;
  static UserProperties get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get shouldShowHelp => _initState < 2;
  bool get shouldShowLocaleSettings => _initState < 1;
  int get practiceGameIndex => _practiceGameIndex;
  int get tooltipsPressed => _tooltipsPressed;
  int get tutorialIndex => _tutorialIndex;
  int get runCount => _runCount;
  int get timeDelta => _timeDelta;
  String get locale => _locale;
  String get uid => _uid;
  String get name => _name;

  static Future<UserProperties> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserProperties(
          practiceGameIndex: sharedPrefs.getInt('progress') ?? 0,
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          initState: sharedPrefs.getInt('initState') ?? 0,
          runCount: sharedPrefs.getInt('runCount') ?? 0,
          tooltipsPressed: sharedPrefs.getInt('tooltipsPressed') ?? 0,
          tutorialIndex: sharedPrefs.getInt('tutorialIndex') ?? 0,
          timeDelta: sharedPrefs.getInt('timeDelta') ?? 0,
          uid: sharedPrefs.getString('uid') ?? const Uuid().v4(),
          sharedPrefs: sharedPrefs,
          name: sharedPrefs.getString('name') ?? '');
      sharedPrefs.setString('uid', _instance!._uid);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._initState = 2;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  increaseRunCount() {
    _instance!._runCount++;
    _sharedPrefs.setInt('runCount', _instance!._runCount);
  }

  localeSet() {
    _instance!._initState = 1;
    _sharedPrefs.setInt('initState', _instance!._initState);
  }

  bool makeProgress(int max) {
    if (_instance!._practiceGameIndex == max - 1) {
      return false;
    }
    if (practiceGameIndex != 0) {
      FirebaseAnalytics.instance
          .logLevelEnd(levelName: '${_instance!._practiceGameIndex + 1}');
    }
    _instance!._practiceGameIndex++;
    FirebaseAnalytics.instance.setUserProperty(
        name: 'level', value: '${_instance!._practiceGameIndex + 1}');
    if (practiceGameIndex != 1) {
      FirebaseAnalytics.instance
          .logLevelStart(levelName: '${_instance!._practiceGameIndex + 1}');
    }
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
    return true;
  }

  bool makeTutorialProgress(int max) {
    if (_instance!._tutorialIndex == max - 1) {
      _instance!._tutorialIndex++;
      _sharedPrefs.setInt('tutorialIndex', _instance!._tutorialIndex);
      return false;
    }
    _instance!._tutorialIndex++;

    _sharedPrefs.setInt('tutorialIndex', _instance!._tutorialIndex);
    return true;
  }

  saveGame(Game game) {
    String s = jsonEncode(game.toJson());
    _sharedPrefs.setString('game_${game.name}', s);
  }

  onTooltipPressed() {
    //print('ttp ${_instance!._tooltipsPressed}');
    _instance!._tooltipsPressed++;
    _sharedPrefs.setInt('tooltipsPressed', _instance!._tooltipsPressed);
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
  }

  Game? loadGame(String name) {
    var game = _sharedPrefs.getString('game_$name');
    if (game != null) return Game.fromJson(jsonDecode(game));
    return null;
  }

  clear() => _sharedPrefs.clear();

  void setContext(BuildContext context) {
    _instance!._locale = context.locale.toString();
  }

  void timeTravel(int delta) {
    _instance!._timeDelta = delta;
    _sharedPrefs.setInt('timeDelta', _instance!._timeDelta);
  }

  void setName(String name) {
    _instance!._name = name;
    _sharedPrefs.setString('name', _instance!._name);
  }
}
