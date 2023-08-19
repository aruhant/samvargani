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

  List<String> get getAllVaraitions {
    const List<List<String>> reference = [
      ['क़', 'क'],
      ['ख़', 'ख'],
      ['ग़', 'ग'],
      ['ज़', 'ज'],
      ['ड़', 'ड'],
      ['ढ़', 'ढ'],
      ['फ़', 'फ'],
      ['य़', 'य']
    ];
    List<List<String>> variations = [allCharacters];
    Map<int, List<String>> criticalPoints = {};

    for (int i = 0; i < allCharacters.length; i++) {
      for (final letterList in reference) {
        if (letterList.contains(allCharacters[i].vyanjan)) {
          List<String> newLetterList = letterList.toList();
          newLetterList.remove(allCharacters[i].contains('़')
              ? '${allCharacters[i].vyanjan}़'
              : allCharacters[i].vyanjan);
          criticalPoints[i] = newLetterList;
          break;
        }
      }
    }

    for (final criticalPoint in criticalPoints.keys) {
      for (int i = 0; i < variations.length; i += 3) {
        for (final letter in criticalPoints[criticalPoint]!) {
          List<String> wordToAdd = variations[i].toList();
          wordToAdd[criticalPoint] = wordToAdd[criticalPoint].replaceAll(
              wordToAdd[criticalPoint].contains('़')
                  ? '${wordToAdd[criticalPoint].vyanjan}़'
                  : wordToAdd[criticalPoint].vyanjan,
              letter);

          variations.insert(i + 1, wordToAdd);
        }
      }
    }

    return variations.map((e) => e.join()).toList();
  }
}





/*




  

    for (final letterList in reference) {
      for (int j = 0; j < word.allCharacters.length; j++) {
        if (letterList.contains(word.allCharacters[j].vyanjan)) {
          for (final letter in letterList) {
            if (letter != word.allCharacters[j].vyanjan) {
              word.allCharacters.replaceRange(j, j + 1, [letter]);
              variations.add(word.allCharacters.join());
            }
          }
        }
      }
    }

    for (int i = 0; i < variations.length; i++) {
      final currentWord = variations[i];
            for (int j = 0; j < currentWord.allCharacters.length; j++) {
              final referenceIndex;
              for (var element in reference) {
                if( element.contains(currentWord.allCharacters[j].vyanjan)){
                  referenceIndex = element.indexOf(currentWord.allCharacters[j].vyanjan);
                  break;
                }
              
              
              
              });





    }

/* 
    for (int k = 0; k < variations.length; k++) {
      for (int i = 0; i < word.allCharacters.length; i++) {
        variations.addAll(reference[j].map((e) => word.allCharacters[i]
            .replaceRange(
                i, i + 1, word.replaceAll(word.allCharacters[i].vyanjan, e))));
        break;
      }
    }
  }
}
 */
    return variations;
  }
}
*/