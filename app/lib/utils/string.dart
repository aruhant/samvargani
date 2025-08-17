/*

In English and similar languages, words are composed of individual letters.
These letters can be easily separated and represented in individual boxes.
For example, the word "apple" can be broken down into 'a', 'p', 'p', 'l', 'e'.

However, in languages like Hindi and other Indic languages, the process is more
complex.Words are not just composed of individual letters, but also of
diacriticalmarks that modify the pronunciation of the letters. These marks can
be above, below, before, or after the letter they modify.
For example, the Hindi word "क्षत्रिय" is composed of the following unicode runes:
'क', '्', 'ष', 'त', '्', 'र', 'ि', 'य'. Here, '्' is a diacritical mark that
combines the preceding and following letters, and 'ि' modifies the pronunciation
of 'र'. 

So, in Hindi and similar languages, decomposing words into smaller units
involves not just separating the letters, but also identifying and separating
the diacritical marks.  This requires us to understand, and classify the runes
into appropriate classes, and use the rules of language to break them into
meaningful individual units.
*/

import 'package:flutter/material.dart';
/*
This file contains useful extensions and algorithms for String class.export.
They are best suited for Devanagari script but can be modified easily for other scripts as well.
*/

extension StringExtension on String {
  // function to obtain parsed unicode characters of a string
  /*
  List<String> get characters.toList() {
    List<String> stringList = characters.toList();
    //print(stringList);
    /*
    for (int i = 0; i < stringList.length - 1; i++) {
      // if the current character is a half character
      if (stringList[i].contains('्')) {
        // if the current character has another half letter in rare cases
        if (stringList[i + 1].contains('्') && i < stringList.length - 2) {
          // combine with the next two characters
          stringList[i] += stringList[i + 1] + stringList[i + 2];
          // remove the next two characters as they have been combined here
          stringList.removeAt(i + 2);
        } else {
          // combine with only next character that is a full character
          stringList[i] += stringList[i + 1];
        }
        // remove the next character as it has been combined here
        stringList.removeAt(i + 1);
      }
    }
    */
    return stringList;
  }
  */

  /// Splits a Hindi character into its components using the built-in split() method
  /// Returns a Map with keys: 'fullLetters', 'halfLetters', 'matras'
  ///
  /// Example usage:
  /// String hindi = "क्ष्त्थी";
  /// Map<String, List<String>> result = hindi.splitIntoClasses();
  /// // result = {
  /// //   'fullLetters': ['क्ष'],
  /// //   'halfLetters': ['त्', 'थ्'],
  /// //   'matras': ['ी']
  /// // }
  ///
  /// The function specifically handles composite letters: क्ष (ksha), त्र (tra), ज्ञ (gnya)
  /// Other halant combinations are treated as separate runes
  Map<String, List<String>> splitIntoClasses() {
    if (this == '्') {
      return {
        'fullLetters': [],
        'halfLetters': [],
        'matras': ['्'],
      };
    }
    // Split the string into individual runes
    List<String> runes = split('');

    List<String> matras = runes
        .where((r) => RegExp(r'[ा-ौ,ँ,ः,ं,़]').hasMatch(r))
        .toList();
    List<String> nonMatraRunes = runes
        .where((r) => !RegExp(r'[ा-ौ,ँ,ः,ं,़]').hasMatch(r))
        .toList();

    // Clean up composite letters (क्ष, त्र, ज्ञ)
    List<String> cleanedRunes = [];
    for (int i = 0; i < nonMatraRunes.length; i++) {
      if (i + 2 < nonMatraRunes.length) {
        // Check for composite letters: क्ष, त्र, ज्ञ
        if ((nonMatraRunes[i] == 'क' &&
                nonMatraRunes[i + 1] == '्' &&
                nonMatraRunes[i + 2] == 'ष') ||
            (nonMatraRunes[i] == 'त' &&
                nonMatraRunes[i + 1] == '्' &&
                nonMatraRunes[i + 2] == 'र') ||
            (nonMatraRunes[i] == 'ज' &&
                nonMatraRunes[i + 1] == '्' &&
                nonMatraRunes[i + 2] == 'ञ') ||
                (nonMatraRunes[i] == 'श' &&
                    nonMatraRunes[i + 1] == '्' &&
                    nonMatraRunes[i + 2] == 'र')) {

          cleanedRunes.add(
            nonMatraRunes[i] + nonMatraRunes[i + 1] + nonMatraRunes[i + 2],
          );
          i += 2; // Skip next two runes
        } else {
          // Not a composite letter, add current rune
          cleanedRunes.add(nonMatraRunes[i]);
        }
      } else {
        // Not enough runes left for composite, add current rune
        //  cleanedRunes.addAll(nonMatraRunes.sublist(i)); break;
        cleanedRunes.add(nonMatraRunes[i]);
      }
    }

    // Separate full letters and half letters
    List<String> fullLetters = [];
    List<String> halfLetters = [];

    for (int i = 0; i < cleanedRunes.length; i++) {
      if (cleanedRunes[i] != '्' && cleanedRunes[i] != ' ') {
        if (i + 1 < cleanedRunes.length && cleanedRunes[i + 1] == '्') {
          // Current rune + halant = half letter
          halfLetters.add(cleanedRunes[i]);
          i += 1; // Skip next iteration (halant)
        } else {
          // Full letter (no halant following)
          fullLetters.add(cleanedRunes[i]);
        }
      }
    }
 // if full letters is empty get the last half letter. also add halant to matras now
    if (fullLetters.isEmpty && halfLetters.isNotEmpty) {
      // print("Full letters is empty, taking last half letter ${this}");
      fullLetters.add(halfLetters.removeAt(halfLetters.length - 1));
      if (matras.isEmpty) {
        matras.add('्');
      }
    }
    if (fullLetters.length != 1){
      // print('Full letters length is not 1 for $this');
      //throw Exception('Full letters length is not 1');
    }
    return {
      'fullLetters': fullLetters,
      'halfLetters': halfLetters,
      'matras': matras,
    };
  }

  /// Helper function to get just the full letters from a Hindi character
  List<String> get fullLetters => splitIntoClasses()['fullLetters'] ?? [];

  /// Helper function to get just the half letters from a Hindi character
  List<String> get halfLetters => splitIntoClasses()['halfLetters'] ?? [];

  /// Helper function to get just the matras from a Hindi character
  List<String> get matras => splitIntoClasses()['matras'] ?? [];

  // function to obtain all the non-consonant component of a hindi letter block
  /*
  String get allModifiers {
    return contains('$vyanjan्')
        ? vyanjan + replaceAll(vyanjan, '')
        : replaceAll(vyanjan, '');
  }

  // function to obtain half letter of a hindi letter block
  String get halfOnly {
    return allModifiers.replaceAll(RegExp(r'[ा-ौ,ँ,ः,ं,़]'), '');
  }

  // function to obtain matra of a hindi letter block
  String get matraOnly {
    return allModifiers.replaceAll(halfOnly, '');
  }

  // function to obtain main consonant of a hindi letter block
  String get vyanjan {
    String v = replaceAll(RegExp(r'[ा-ौ,ँ,ः,ं,़]'), '');
    var match = RegExp(r'(त्र|ज्ञ|श्र|क्ष)([^्]|$)').firstMatch(v);

    if (match != null) {
      return match.group(0)!;
    }
    if (v.isEmpty) return '';
    return v[v.length - 1];
  }
  */

  String get vyanjan {
    return fullLetters.join();
  }
  String get matraOnly {
    return matras.join("");
  }
  String get halfOnly {
    // ignore: unnecessary_brace_in_string_interps
    return halfLetters.map((e) => "${e}्").join(" ");
  }
  String get allModifiers {
    if (matraOnly == "ि" && halfOnly.isNotEmpty) {
      final toreturnList = halfLetters.map((e) => "${e}्").toList();
      toreturnList.last = toreturnList.last.substring(0, toreturnList.last.length - 1);
      return "${toreturnList.join()}ि्";
    } else {
      return halfOnly + matraOnly;
    }
  }

  /*
  Certain letters in Hindi have multiple variations and are thus easily
  confused with each other. For example, the letter 'क' has two variations:
  'क' and 'क़'. Similarly, 'ख' has 'ख' and 'ख़', and so on. This function
  returns a list of all possible variations of a given word. This is used in
  the game to auto-correct the user's guess. 
  */
  List<String> get getAllVaraitions {
    // Simply adding additionaly appropriate lists can be used for other
    // ambiguous letters
    const List<List<String>> reference = [
      ['क़', 'क'],
      ['ख़', 'ख'],
      ['ग़', 'ग'],
      ['ज़', 'ज'],
      ['ड़', 'ड'],
      ['ढ़', 'ढ'],
      ['फ़', 'फ'],
      ['य़', 'य'],
    ];
    // List to store all possible variations
    List<List<String>> variations = [characters.toList()];
    // Map to store index of where changes need to be made
    Map<int, List<String>> criticalPoints = {};
    for (int i = 0; i < characters.toList().length; i++) {
      for (final letterList in reference) {
        // if a character is found in the reference list
        if (letterList.contains(characters.toList()[i].vyanjan)) {
          List<String> newLetterList = letterList.toList();
          // remove the 'nukta' from the list if it is present as well as
          // the associated character
          newLetterList.remove(
            characters.toList()[i].contains('़')
                ? '${characters.toList()[i].vyanjan}़'
                : characters.toList()[i].vyanjan,
          );
          // populate the map with the index of the character and the list of
          // possible variations
          criticalPoints[i] = newLetterList;
          break;
        }
      }
    }
    // for each critical point, add the variations to the list
    for (final criticalPoint in criticalPoints.keys) {
      for (int i = 0; i < variations.length; i += 3) {
        for (final letter in criticalPoints[criticalPoint]!) {
          List<String> wordToAdd = variations[i].toList();
          // replace the character at the critical point with the new letter
          // with and without the 'nukta'
          wordToAdd[criticalPoint] = wordToAdd[criticalPoint].replaceAll(
            wordToAdd[criticalPoint].contains('़')
                ? '${wordToAdd[criticalPoint].vyanjan}़'
                : wordToAdd[criticalPoint].vyanjan,
            letter,
          );
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
