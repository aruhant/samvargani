import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  final bool _darkMode;
  int _initState;
  int _practiceGameIndex;
  Map _currentPracticeGame;
  Map _currentDailyGame;
  final SharedPreferences _sharedPrefs;
  UserPrefs(
      {required bool darkMode,
      required int initState,
      required int practiceGameIndex,
      required Map currentPracticeGame,
      required Map currentDailyGame,
      required SharedPreferences sharedPrefs})
      : _initState = initState,
        _darkMode = darkMode,
        _practiceGameIndex = practiceGameIndex,
        _currentPracticeGame = currentPracticeGame,
        _currentDailyGame = currentDailyGame,
        _sharedPrefs = sharedPrefs;

  static UserPrefs? _instance;
  static UserPrefs get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get shouldShowHelp => _initState < 2;
  bool get shouldShowLocaleSettings => _initState < 1;
  int get practiceGameIndex => _practiceGameIndex;
  Map get currentPracticeGame => _currentPracticeGame;
  Map get currentDailyGame => _currentDailyGame;

  get language => null;

  static Future<UserPrefs> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserPrefs(
          practiceGameIndex: sharedPrefs.getInt('progress') ?? 0,
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          initState: sharedPrefs.getInt('initState') ?? 0,
          currentPracticeGame: {},
          currentDailyGame: {},
          sharedPrefs: sharedPrefs);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._initState = 2;
    _instance!.save();
  }

  localeSet() {
    _instance!._initState = 1;
    _instance!.save();
  }

  bool makeProgress(int max) {
    if (_instance!._practiceGameIndex == max - 1) {
      return false;
    }
    _instance!._practiceGameIndex++;
    _instance!.save();
    return true;
  }

  savePracticeGame(Map game) {
    _instance!._currentPracticeGame = game;
    _instance!.save();
  }

  saveDailyGame(Map game) {
    _instance!._currentDailyGame = game;
    _instance!.save();
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setInt('initState', _instance!._initState);
    _sharedPrefs.setInt('progress', _instance!._practiceGameIndex);
  }
}
