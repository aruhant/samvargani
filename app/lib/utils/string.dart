import 'package:flutter/material.dart';

extension StringExtension on String {
  List<String> get allCharacters {
    List<String> stringList = characters.toList();
    for (int i = 0; i < stringList.length; i++) {
      if (stringList[i].contains('्')) {
        stringList[i] += stringList[i + 1];
        stringList.removeAt(i + 1);
      }
    }
    return stringList;
  }

  String get matra => replaceAll(RegExp(r'[ऄ-ह,क़-ॡ,ॲ-ॿ]'), '');
  String get vyanjan => replaceAll(RegExp(r'[ा-ौ]'), '');
}
