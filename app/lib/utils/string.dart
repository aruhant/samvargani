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
    var match = RegExp(r'(त्र|ज्ञ|श्र|क्ष)([^्]|$)').firstMatch(v);

    if (match != null) {
      return match.group(0)!;
    }
    if (v.isEmpty) return '';
    return v[v.length - 1];
  }
}
