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

  String get matra {
    // write the above in one line
    return contains(vyanjan + '्')
        ? vyanjan + replaceAll(vyanjan, '')
        : replaceAll(vyanjan, '');
  }

  String get vyanjan {
    String vyanjan = replaceAll(RegExp(r'[ा-ौ,ँ,ः,ं,़]'), '');
    if (["त्र", "ज्ञ", "श्र", "क्ष"].contains(vyanjan)) {
      return vyanjan;
    }
    return vyanjan[vyanjan.length - 1];
  }
}
