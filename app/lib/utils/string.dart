import 'package:flutter/material.dart';

extension StringExtension on String {
  List<String> hindiCharacterList() {
    print(this);
    List<String> stringList = characters.toList();
    for (int i = 0; i < stringList.length; i++) {
      if (stringList[i].contains('्')) {
        stringList[i] += stringList[i + 1];
        stringList.removeAt(i + 1);
      }
    }
    print(stringList);
    return stringList;
  }

  String get matra {
    return this.replaceAll(RegExp(r'[क-ह]'), '');
  }
}
