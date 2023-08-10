import 'dart:math';

import 'package:flutter/material.dart';

extension StringExtension on String {
  List<String> get allCharacters {
    List<String> stringList = characters.toList();
    for (int i = 0; i < stringList.length; i++) {
      if (stringList[i].contains('्')) {
        if (stringList[i + 1].contains('्')) {
          stringList[i] += stringList[i + 1] + stringList[i + 2];
          stringList.removeAt(i + 2);
        } else {
          stringList[i] += stringList[i + 1];
        }
        stringList.removeAt(i + 1);
      }
    }
    return stringList;
  }

  String get matra {
    return contains('$vyanjan्')
        ? vyanjan + replaceAll(vyanjan, '')
        : replaceAll(vyanjan, '');
  }

  String get halfOnly {
    return matra.replaceAll(RegExp(r'[ा-ौ,ँ,ः,ं,़]'), '');
  }

  String get matraOnly {
    return matra.replaceAll(halfOnly, '');
  }

  String get vyanjan {
    String v = replaceAll(RegExp(r'[ा-ौ,ँ,ः,ं,़]'), '');
    if (v.contains("त्र") ||
        v.contains("ज्ञ") ||
        v.contains("श्र") ||
        v.contains("क्ष")) {
      return v.substring(max(max(v.indexOf("त्र"), v.indexOf("ज्ञ")),
          max(v.indexOf("श्र"), v.indexOf("क्ष"))));
    }
    if (v.isEmpty) return '';
    return v[v.length - 1];
  }
}
