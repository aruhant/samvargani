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
/*
  List<String> getAllVaraitions(String word) {
    const List<List<String>> reference = [
      ['क़', 'क', 'क़'],
      ['ख़', 'ख', 'ख़'],
      ['ग़', 'ग', 'ग़'],
      ['ज़', 'ज', 'ज़'],
      ['ड़', 'ड', 'ड़'],
      ['ढ़', 'ढ', 'ढ़'],
      ['फ़', 'फ', 'फ़'],
      ['य़', 'य', 'य़']
    ];
    
    List<List<int>> criticalPoints = []; // first element is index which needs to be changed and second is the referenceIndex of its all change values
    for (int i = 0; i < reference.length; i++) {
      for (int j = 0; j < word.allCharacters.length; j++)
          {if (reference[i].contains(word.allCharacters[j].vyanjan)) {
            criticalPoints.add([j,i]);
          }}}
    List<String> variations = [word];
    for (int i = 0; i<criticalPoints.length; i ++)
    {
      for (int j = 0; )



    }






    for (int k = 0; k < variations.length;k++) {
      for (int i = 0; i < word.allCharacters.length; i++) {
        
            variations.addAll(reference[j].map((e) => word.allCharacters[i]
                .replaceRange(i, i + 1,
                    word.replaceAll(word.allCharacters[i].vyanjan, e))));
            break;
          }
        }
      }
    
*/
}
