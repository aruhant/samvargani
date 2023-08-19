import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:easy_localization/easy_localization.dart';

class GameAnswer {
  final String answer;
  final String? _title;
  final String meaning;
  final List<String?>? hints;
  final Color? backgroundColor;
  final List<Color> colors;
  final List<IconData> icons;
  final List<String>? images;
  final bool moveHorizontal, moveVertical;
  final double maxOpacity, minOpacity, maxSize, minSize, maxSpeed, minSpeed;
  final int itemsCount;
  GameAnswer({
    required this.answer,
    String? title,
    required this.meaning,
    this.hints,
    this.colors = const [Color.fromRGBO(213, 204, 158, 1)],
    this.backgroundColor = const Color.fromRGBO(213, 204, 158, 1),
    this.icons = const [Icons.cloud],
    this.images,
    this.moveHorizontal = true,
    this.moveVertical = false,
    this.maxOpacity = 0.4,
    this.minOpacity = 0.15,
    this.maxSize = 30,
    this.minSize = 150,
    this.maxSpeed = 0.4,
    this.minSpeed = 0.25,
    this.itemsCount = 6,
  }) : _title = title;

  String get title =>
      _title ??
      LocaleKeys.practiceGame_level
          .tr(args: [(gameAnswers.indexOf(this) + 1).toString()]);

  static GameAnswer fromJson(Map json) {
    return GameAnswer(
        answer: json['answer'] ?? 'समाधान',
        meaning: json['meaning'] ?? 'संशय दूर करना',
        title: json['title'] ?? 'Daily Challenge',
        colors: json['colors'] != null
            ? (json['colors'] as List)
                .map((e) => TinyColor.fromString(e).color)
                .toList()
            : const [Color.fromARGB(255, 210, 161, 183)],
        backgroundColor: json['backgroundColor'] != null
            ? TinyColor.fromString(json['backgroundColor']).color
            : const Color.fromARGB(255, 180, 207, 229),
        icons: json['icons'] != null
            ? (json['icons'] as List)
                .map((e) => e is String
                    ? LineIcons.byName(e)
                    : IconData(e,
                        fontFamily: 'Awesome Line Icons 1.3.0',
                        fontPackage: 'line_icons'))
                .toList()
                .cast()
            : [LineIcons.handshake],
        images: json['images'] != null
            ? (json['images'] as List).cast<String>()
            : [],
        moveHorizontal: json['moveHorizontal'] ?? true,
        moveVertical: json['moveVertical'] ?? true,
        maxOpacity: json['maxOpacity'] ?? 0.4,
        minOpacity: json['minOpacity'] ?? 0.15,
        maxSize: json['maxSize'] ?? 30,
        minSize: json['minSize'] ?? 150,
        maxSpeed: json['maxSpeed'] ?? 0.4,
        minSpeed: json['minSpeed'] ?? 0.25,
        itemsCount: json['itemsCount'] ?? 6);
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'meaning': meaning,
      'title': title,
      'icons': icons.map((e) => e.codePoint).toList().cast(),
      'colors': colors.map((e) => e.toHex8()).toList().cast(),
      'backgroundColor': backgroundColor?.toHex8(),
      'images': images,
      'moveHorizontal': moveHorizontal,
      'moveVertical': moveVertical,
      'maxOpacity': maxOpacity,
      'minOpacity': minOpacity,
      'maxSize': maxSize,
      'minSize': minSize,
      'maxSpeed': maxSpeed,
      'minSpeed': minSpeed,
      'itemsCount': itemsCount,
    };
  }

  static List<GameAnswer> fromJsonList(List json) {
    return json.map((e) => GameAnswer.fromJson(e)).toList();
  }
}

final List<GameAnswer> gameAnswers = [
  GameAnswer(
      title: '',
      answer: 'बादल',
      meaning: 'वायुमंडल में संचित घनीभूत वाष्पकण',
      moveHorizontal: true,
      moveVertical: false,
      backgroundColor: Colors.blue[100],
      colors: [const Color.fromARGB(255, 47, 46, 59)]),
  GameAnswer(
      answer: 'मेघ',
      meaning: 'बादल',
      icons: [LineIcons.cloud],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.blue, Colors.cyan],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'सियासत',
      meaning:
          'राज्य की वह नीति जिसके अनुसार प्रजा का शासन और पालन तथा दूसरे राज्यों से व्यवहार',
      icons: [LineIcons.crown, LineIcons.chessQueen],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 255, 255, 255)],
      backgroundColor: const Color.fromARGB(255, 240, 207, 255)),
  GameAnswer(
      answer: 'दरिया',
      meaning: 'समुद्र या नदी',
      icons: [LineIcons.fish],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.redAccent],
      backgroundColor: Colors.blue[100]),
  GameAnswer(
      answer: 'स्पन्दन',
      meaning: 'कंपन',
      icons: [LineIcons.heartbeat],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [Colors.red],
      backgroundColor: Colors.red[100]),
  GameAnswer(
    answer: 'व्यसन',
    meaning: 'लत',
    icons: [LineIcons.smoking],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(192, 216, 149, 124)],
    backgroundColor: const Color.fromARGB(255, 255, 239, 208),
  ),
  GameAnswer(
      answer: 'वृष्टि',
      meaning: 'बारिश',
      icons: [LineIcons.frog],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.green],
      backgroundColor: Colors.green[100]),
  GameAnswer(
      answer: 'दृष्टि',
      meaning: 'निगाह, देखने की शक्ति',
      icons: [LineIcons.eye, LineIcons.eyeAlt],
      moveHorizontal: true,
      moveVertical: false,
      colors: [const Color.fromARGB(155, 101, 122, 102)],
      backgroundColor: Colors.green[100]),
  GameAnswer(
      answer: 'सेहत',
      meaning: 'स्वास्थ्य',
      icons: [LineIcons.fruitApple],
      moveHorizontal: false,
      moveVertical: true,
      colors: [
        const Color.fromARGB(155, 226, 63, 51),
        const Color.fromARGB(155, 137, 195, 71)
      ],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'चंचला',
      meaning: 'बिजली',
      icons: [LineIcons.lightningBolt],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[200]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'झोंका',
      meaning: 'वेगपूर्वक चलने वाली हवा',
      icons: [LineIcons.wind],
      moveHorizontal: true,
      moveVertical: false,
      colors: [Colors.grey, Colors.blueGrey, Colors.black12],
      backgroundColor: Colors.blue[200]),
  GameAnswer(
      answer: 'जोखिम',
      meaning: 'संकट या विपत्ति की संभावना वाली स्थिति',
      icons: [LineIcons.skullCrossbones],
      moveHorizontal: true,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 211, 121, 94)],
      backgroundColor: const Color.fromARGB(255, 178, 178, 212)),
  GameAnswer(
    answer: 'तीव्र',
    meaning: 'तेज़, अत्यंत',
    icons: [LineIcons.horse],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
    maxSpeed: 5,
    minSpeed: 0.4,
  ),
  GameAnswer(
      answer: 'माणिक',
      meaning: 'एक अनमोल रत्न।',
      icons: [LineIcons.gem],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 232, 112, 97)],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'अँगूठा',
      meaning: 'हाथ अथवा पैर की पहली और सबसे मोटी उँगली।',
      icons: [LineIcons.fingerprint],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [Color.fromARGB(255, 229, 180, 179)],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
      answer: 'नकद',
      meaning: 'वह धन जो रुपया-पैसा, सिक्का आदि के रूप में हो',
      icons: [LineIcons.moneyBill],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 119, 208, 147)],
      backgroundColor: const Color.fromARGB(255, 215, 255, 229)),
  GameAnswer(
      answer: 'विस्फोट',
      meaning: 'धमाका',
      icons: [LineIcons.bomb],
      moveHorizontal: false,
      moveVertical: true,
      colors: [
        const Color.fromARGB(255, 233, 96, 96),
        const Color.fromARGB(255, 74, 53, 51)
      ],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
    itemsCount: 8,
    answer: 'औषधि',
    meaning: 'दवा',
    icons: [LineIcons.cannabis, LineIcons.mortarPestle, LineIcons.pills],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 185, 185, 185)],
    backgroundColor: const Color.fromARGB(255, 195, 228, 189),
  ),
  GameAnswer(
    answer: 'विद्या',
    meaning: 'ज्ञान',
    icons: [LineIcons.book, LineIcons.school],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
  ),
  GameAnswer(
    itemsCount: 8,
    answer: 'बलवान',
    meaning: 'शक्तिशाली',
    icons: [LineIcons.dumbbell, LineIcons.raisedFist],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 229, 180, 179)],
    backgroundColor: const Color.fromARGB(255, 241, 228, 252),
  ),
  GameAnswer(
      answer: 'स्नेह',
      meaning: 'प्रेम',
      icons: [LineIcons.heart],
      moveHorizontal: false,
      moveVertical: true,
      colors: [Colors.pink[100]!],
      backgroundColor: Colors.pink[50]),
  GameAnswer(
      answer: 'घूस',
      meaning: 'रिश्वत',
      icons: [LineIcons.moneyBill, LineIcons.alternateWavyMoneyBill],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 246, 255, 223)],
      backgroundColor: const Color.fromARGB(255, 183, 160, 160)),
  GameAnswer(
      answer: 'पालतू',
      meaning: 'जो पाला गया हो',
      icons: [LineIcons.dog],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [Color.fromARGB(255, 229, 139, 13)],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252)),
  GameAnswer(
      answer: 'इंसाफ',
      meaning: 'न्याय',
      icons: [LineIcons.gavel, LineIcons.balanceScale],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 255, 255, 255)],
      backgroundColor: const Color.fromARGB(255, 218, 190, 190)),
  GameAnswer(
      answer: 'मुस्कान',
      meaning: 'हँसी',
      icons: [Icons.sentiment_satisfied_alt],
      moveHorizontal: false,
      moveVertical: true,
      colors: const [Color.fromARGB(255, 255, 220, 184)],
      backgroundColor: const Color.fromARGB(255, 255, 253, 228)),
  GameAnswer(answer: 'श्रृंगार', meaning: 'सजाने की क्रिया या भाव'),
  GameAnswer(answer: 'उत्सुकता', meaning: 'अधीरता'),
  GameAnswer(answer: 'साहसिक', meaning: 'बहादुर'),
  GameAnswer(answer: 'विचित्र', meaning: 'अनोखा'),
  GameAnswer(answer: 'उमंग', meaning: 'उत्साह'),
  GameAnswer(answer: 'प्रचंड', meaning: 'बहुत अधिक'),
  GameAnswer(answer: 'बेख़बर', meaning: 'अनजान'),
  GameAnswer(answer: 'धैर्य', meaning: 'साहस'),
  GameAnswer(answer: 'विश्वास', meaning: 'भरोसा'),
  GameAnswer(answer: 'कंकाल', meaning: 'अस्थि-पंजर'),
  GameAnswer(answer: 'आकर्षण', meaning: 'आकर्षित करने की शक्ति'),
  GameAnswer(answer: 'उपहास', meaning: 'हंसी'),
  GameAnswer(answer: 'कठिनाई', meaning: 'मुश्किल'),
  GameAnswer(answer: 'क्षमता', meaning: 'समर्थता'),
  GameAnswer(answer: 'जिज्ञासा', meaning: 'जानने की इच्छा'),
  GameAnswer(answer: 'प्रतिष्ठा', meaning: 'मान'),
  GameAnswer(answer: 'लाभ', meaning: 'फायदा'),
  GameAnswer(answer: 'साहित्य', meaning: 'समस्त शास्त्रों, ग्रंथों का समूह'),
  GameAnswer(answer: 'व्यापार', meaning: 'व्यवसाय'),
  GameAnswer(answer: 'शिक्षा', meaning: 'विद्या'),
  GameAnswer(answer: 'समझदार', meaning: 'बुद्धिमान'),
  GameAnswer(answer: 'सामर्थ्य', meaning: 'क्षमता'),
  GameAnswer(answer: 'हाथी', meaning: 'एक प्रकार का जानवर'),
  GameAnswer(answer: 'विक्रेता', meaning: 'बेचने वाला'),
  GameAnswer(answer: 'उपाय', meaning: 'तरीका'),
  GameAnswer(answer: 'स्थिर', meaning: 'अचल'),
  GameAnswer(answer: 'आवश्यक', meaning: 'अनिवार्य'),
  GameAnswer(answer: 'अस्पष्ट', meaning: 'अच्छी तरह से न दिखने वाला'),
  GameAnswer(answer: 'अर्थशास्त्र', meaning: 'धन के व्यवहार की विद्या'),
  GameAnswer(answer: 'उदर', meaning: 'पेट'),
  GameAnswer(answer: 'कविता', meaning: 'लयात्मक रचना'),
  GameAnswer(answer: 'गोपनीयता', meaning: 'छिपी हुई बातें'),
  GameAnswer(answer: 'चित्रकला', meaning: 'चित्र बनाने की कला'),
  GameAnswer(answer: 'ज्ञानवान', meaning: 'जानकार'),
  GameAnswer(answer: 'शक्ति', meaning: 'ताक़त'),
  GameAnswer(answer: 'रोचक', meaning: 'दिलचस्प'),
  GameAnswer(answer: 'लघुकथा', meaning: 'छोटी कहानी'),
  GameAnswer(answer: 'वार्तालाप', meaning: 'बातचीत'),
  GameAnswer(answer: 'अभिवादन', meaning: 'शुभकामना का आदान-प्रदान'),
  GameAnswer(
      answer: 'अपवाद',
      meaning: 'सामान्य नियम से भिन्न या विरुद्ध कोई नियम या बात'),
  GameAnswer(answer: 'चिंतन', meaning: 'विचार'),
  GameAnswer(answer: 'विस्तार', meaning: 'फैलाव'),
  GameAnswer(answer: 'परिप्रेक्ष्य', meaning: 'सम्बन्धित'),
  GameAnswer(answer: 'प्रतिज्ञा', meaning: 'दृढ़ संकल्प, वचन'),
  GameAnswer(answer: 'मान्यता', meaning: 'स्वीकृति'),
  GameAnswer(answer: 'रंगमंच', meaning: 'नाट्यशाला'),
  GameAnswer(answer: 'व्यवस्था', meaning: 'आयोजन'),
  GameAnswer(answer: 'सर्वोपरि', meaning: 'सर्वाधिक'),
  GameAnswer(answer: 'संयम', meaning: 'आत्म-नियंत्रण'),
  GameAnswer(answer: 'अद्वितीय', meaning: 'अनूठा'),
  GameAnswer(answer: 'समर्पण', meaning: 'निष्ठा'),
  GameAnswer(answer: 'सहयोग', meaning: 'साथ मिलकर काम करना'),
  GameAnswer(answer: 'विशेषज्ञ', meaning: 'विशेष ज्ञान रखने वाला'),
  GameAnswer(answer: 'साहित्यिक', meaning: 'साहित्य से संबंधित'),
  GameAnswer(answer: 'समृद्धि', meaning: 'आर्थिक वृद्धि'),
  GameAnswer(answer: 'मनोबल', meaning: 'साहस या आत्मविश्वास'),
  GameAnswer(answer: 'स्वागत', meaning: 'आतिथ्य'),
  GameAnswer(answer: 'सफलता', meaning: 'विजय'),
  GameAnswer(answer: 'संवाद', meaning: 'बातचीत'),
  GameAnswer(answer: 'संगीत', meaning: 'गाने की कला'),
  GameAnswer(answer: 'आनंद', meaning: 'खुशी'),
  GameAnswer(answer: 'मनोरंजन', meaning: 'मन बहलाने का कार्य'),
  GameAnswer(answer: 'साधारण', meaning: 'सामान्य'),
  GameAnswer(answer: 'विकास', meaning: 'प्रगति'),
  GameAnswer(answer: 'सजीव', meaning: 'जीवित'),
  GameAnswer(answer: 'सहज', meaning: 'आसान'),
  GameAnswer(answer: 'मानव', meaning: 'मनुष्य'),
  GameAnswer(answer: 'साहस', meaning: 'वीरता'),
  GameAnswer(answer: 'उत्तराधिकारी', meaning: 'वारिस'),
  GameAnswer(answer: 'विशेषाधिकार', meaning: 'विशिष्ट अधिकार'),
];
