import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPrefs {
  final bool _darkMode;
  bool _firstRun;
  int _practiceGameIndex;
  final SharedPreferences _sharedPrefs;
  UserPrefs(
      {required bool darkMode,
      required bool firstRun,
      required int practiceGameIndex,
      required SharedPreferences sharedPrefs})
      : _firstRun = firstRun,
        _darkMode = darkMode,
        _practiceGameIndex = practiceGameIndex,
        _sharedPrefs = sharedPrefs;

  static UserPrefs? _instance;
  static UserPrefs get instance => _instance!;
  bool get darkMode => _darkMode;
  bool get firstRun => _firstRun;
  int get practiceGameIndex => _practiceGameIndex;

  static Future<UserPrefs> init() async {
    if (_instance == null) {
      WidgetsFlutterBinding.ensureInitialized();
      var sharedPrefs = await SharedPreferences.getInstance();
      _instance = UserPrefs(
          practiceGameIndex: sharedPrefs.getInt('progress') ?? 0,
          darkMode: sharedPrefs.getBool('darkMode') ?? false,
          firstRun: sharedPrefs.getBool('firstRun') ?? true,
          sharedPrefs: sharedPrefs);
    }
    return _instance!;
  }

  firstRunDone() {
    _instance!._firstRun = false;
    _instance!.save();
  }

  makeProgress() {
    _instance!._practiceGameIndex++;
    _instance!.save();
  }

  save() {
    _sharedPrefs.setBool('darkMode', _instance!._darkMode);
    _sharedPrefs.setBool('firstRun', _instance!._firstRun);
  }
}
