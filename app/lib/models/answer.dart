import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:tinycolor2/tinycolor2.dart';
import 'package:flutter_svg/flutter_svg.dart';

const defaultGameColor =  Color.fromRGBO(213, 204, 158, 1);

class GameAnswer {
  final String answer;
  final String? title;
  final String meaning;
  final Color? backgroundColor;
  final List<Color> colors;
  final List<IconData>? icons;
  final List<String>? images;
  final bool moveHorizontal, moveVertical;
  final double maxOpacity, minOpacity, maxSize, minSize, maxSpeed, minSpeed;
  final int itemsCount;
  final int whenToShowIcons;
  final int? difficulty; // 1-5 scale where 1=easy, 5=difficult
  GameAnswer({
    required this.answer,
    this.title,
    required this.meaning,
    this.colors = const [defaultGameColor],
    this.backgroundColor = defaultGameColor,
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
    this.whenToShowIcons = 2,
    this.difficulty,
  });
/*
  String get title =>
      _title ??
      LocaleKeys.practiceGame_level.tr(
        args: [(practiceWords.indexOf(this) + 1).toString()],
      );
    */
  Future<List> get hintIcons async {
    if (images != null && images!.isNotEmpty) {
      return await Future.wait(
        images!.map((e) async {
          var pictureInfo = (await vg.loadPicture(SvgStringLoader(e), null));
          return pictureInfo.picture.toImage(
            pictureInfo.size.width.toInt(),
            pictureInfo.size.height.toInt(),
          );
        }),
      );
    }
    if (icons != null && icons!.isNotEmpty) return icons!;
    return [];
  }

  static GameAnswer fromJson(Map json, [int? day]) {
    return GameAnswer(
      answer: json['answer'] ?? 'समाधान',
      meaning: json['meaning'] ?? 'संशय दूर करना',
      difficulty: json['difficulty'],
      title: json['title'],
     /*  title:
          (UserProperties.instance.locale.contains('hi')
              ? json['title_hi1']
              : json['title_en1']) ??
          json['title1'] ??
          LocaleKeys.dailyGame_title.tr(args: WotD.getDayAndMonthForTitle(day)), */
      colors: json['colors'] != null
          ? (json['colors'] as List)
                .map((e) => TinyColor.fromString(e).color)
                .toList()
          : const [defaultGameColor],
      backgroundColor: json['backgroundColor'] != null
          ? TinyColor.fromString(json['backgroundColor']).color
          : defaultGameColor,
      icons: json['icons'] != null
          ? (json['icons'] as List)
                .map(
                  (e) => e is String
                      ? LineIcons.byName(e) ?? LineIcons.cloud
                      : IconData(
                          e,
                          fontFamily: 'Awesome Line Icons 1.3.0',
                          fontPackage: 'line_icons',
                        ),
                )
                .toList()
                .cast()
          : [],
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
      itemsCount: json['itemsCount'] ?? 6,
      whenToShowIcons: json['whenToShowIcons'] ?? 2,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'answer': answer,
      'meaning': meaning,
      'difficulty': difficulty,
      'title': title,
      'icons': (icons ?? []).map((e) => e.codePoint).toList().cast(),
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
      'whenToShowIcons': whenToShowIcons,
    };
  }

  static List<GameAnswer> fromJsonList(List json) {
    return json.map((e) => GameAnswer.fromJson(e)).toList();
  }
}

final List<GameAnswer> practiceWords = [
  GameAnswer(
    answer: 'मेघ',
    meaning: 'बादल',
    icons: [LineIcons.cloud],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.blue, Colors.cyan],
    backgroundColor: Colors.blue[100],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'नकद',
    meaning: 'रुपया-पैसा\nके रूप में धन',
    icons: [LineIcons.moneyBill],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 119, 208, 147)],
    backgroundColor: const Color.fromARGB(255, 215, 255, 229),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'सेहत',
    meaning: 'स्वास्थ्य',
    icons: [LineIcons.fruitApple],
    moveHorizontal: false,
    moveVertical: true,
    colors: [
      const Color.fromARGB(155, 226, 63, 51),
      const Color.fromARGB(155, 137, 195, 71),
    ],
    backgroundColor: Colors.pink[50],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'दृष्टि',
    meaning: 'देखने की शक्ति',
    icons: [LineIcons.eye, LineIcons.eyeAlt],
    moveHorizontal: true,
    moveVertical: false,
    colors: [const Color.fromARGB(155, 101, 122, 102)],
    backgroundColor: Colors.green[100],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'माणिक',
    meaning: 'एक अनमोल रत्न',
    icons: [LineIcons.gem],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 232, 112, 97)],
    backgroundColor: Colors.pink[50],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'अँगूठा',
    meaning: 'हाथ की पहली उँगली',
    icons: [LineIcons.fingerprint],
    moveHorizontal: true,
    moveVertical: false,
    colors: const [Color.fromARGB(255, 229, 180, 179)],
    backgroundColor: const Color.fromARGB(255, 241, 228, 252),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'व्यसन',
    meaning: 'लत',
    icons: [LineIcons.smoking],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(192, 216, 149, 124)],
    backgroundColor: const Color.fromARGB(255, 255, 239, 208),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'प्रशासन',
    meaning: 'राज्य या\nनीति व्यवहार',
    icons: [LineIcons.crown, LineIcons.chessQueen],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 255, 255, 255)],
    backgroundColor: const Color.fromARGB(255, 240, 207, 255),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'चंचला',
    meaning: 'बिजली',
    icons: [LineIcons.lightningBolt],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[200]!],
    backgroundColor: Colors.pink[50],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'वृष्टि',
    meaning: 'बारिश',
    icons: [LineIcons.frog],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.green],
    backgroundColor: Colors.green[100],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'झोंका',
    meaning: 'वेगपूर्वक हवा',
    icons: [LineIcons.wind],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.grey, Colors.blueGrey, Colors.black12],
    backgroundColor: Colors.blue[200],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'जोखिम',
    meaning: 'संकट या विपत्ति',
    icons: [LineIcons.skullCrossbones],
    moveHorizontal: true,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 211, 121, 94)],
    backgroundColor: const Color.fromARGB(255, 178, 178, 212),
    whenToShowIcons: -1,
  ),
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
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'स्पंदन',
    meaning: 'कंपन',
    icons: [LineIcons.heartbeat],
    moveHorizontal: true,
    moveVertical: false,
    colors: const [Color.fromARGB(255, 244, 67, 54)],
    backgroundColor: const Color.fromARGB(255, 255, 205, 210),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'विस्फोट',
    meaning: 'धमाका',
    icons: [LineIcons.bomb],
    moveHorizontal: false,
    moveVertical: true,
    colors: [
      const Color.fromARGB(255, 233, 96, 96),
      const Color.fromARGB(255, 74, 53, 51),
    ],
    backgroundColor: const Color.fromARGB(255, 241, 228, 252),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    itemsCount: 8,
    answer: 'औषधि',
    meaning: 'दवा',
    icons: [LineIcons.cannabis, LineIcons.mortarPestle, LineIcons.pills],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 185, 185, 185)],
    backgroundColor: const Color.fromARGB(255, 195, 228, 189),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'विद्या',
    meaning: 'ज्ञान',
    icons: [LineIcons.book, LineIcons.school],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
    whenToShowIcons: -1,
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
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'स्नेह',
    meaning: 'प्रेम',
    icons: [LineIcons.heart],
    moveHorizontal: false,
    moveVertical: true,
    colors: [Colors.pink[100]!],
    backgroundColor: Colors.pink[50],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'घूस',
    meaning: 'रिश्वत',
    icons: [LineIcons.moneyBill, LineIcons.alternateWavyMoneyBill],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 246, 255, 223)],
    backgroundColor: const Color.fromARGB(255, 183, 160, 160),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'पालतू',
    meaning: 'जो पाला गया हो',
    icons: [LineIcons.dog],
    moveHorizontal: true,
    moveVertical: false,
    colors: const [Color.fromARGB(255, 229, 139, 13)],
    backgroundColor: const Color.fromARGB(255, 241, 228, 252),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'इंसाफ',
    meaning: 'न्याय',
    icons: [LineIcons.gavel, LineIcons.balanceScale],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 255, 255, 255)],
    backgroundColor: const Color.fromARGB(255, 218, 190, 190),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    answer: 'मुस्कान',
    meaning: 'हँसी',
    icons: [Icons.sentiment_satisfied_alt],
    moveHorizontal: false,
    moveVertical: true,
    colors: const [Color.fromARGB(255, 255, 220, 184)],
    backgroundColor: const Color.fromARGB(255, 255, 253, 228),
    whenToShowIcons: -1,
  ),
  GameAnswer(answer: 'उत्सुकता', meaning: 'अधीरता'),
  GameAnswer(answer: 'साहसिक', meaning: 'बहादुर'),
  GameAnswer(answer: 'विचित्र', meaning: 'अनोखा'),
  GameAnswer(answer: 'उमंग', meaning: 'उत्साह'),
  GameAnswer(answer: 'बेसुध', meaning: 'अचेत'),
  GameAnswer(answer: 'विश्वास', meaning: 'भरोसा'),
  GameAnswer(answer: 'कंकाल', meaning: 'अस्थि-पंजर'),
  GameAnswer(answer: 'आकर्षण', meaning: 'आकर्षित करने\nकी शक्ति'),
  GameAnswer(answer: 'उपहास', meaning: 'हंसी'),
  GameAnswer(answer: 'कठिनाई', meaning: 'मुश्किल'),
  GameAnswer(answer: 'क्षमता', meaning: 'समर्थता'),
  GameAnswer(answer: 'जिज्ञासा', meaning: 'जानने की इच्छा'),
  GameAnswer(answer: 'प्रतिष्ठा', meaning: 'मान'),
  GameAnswer(answer: 'लाभ', meaning: 'फायदा'),
  GameAnswer(answer: 'साहित्य', meaning: 'समस्त शास्त्रों'),
  GameAnswer(answer: 'व्यापार', meaning: 'व्यवसाय'),
  GameAnswer(answer: 'शिक्षा', meaning: 'विद्या'),
  GameAnswer(answer: 'समझदार', meaning: 'बुद्धिमान'),
  GameAnswer(answer: 'सामर्थ्य', meaning: 'क्षमता'),
  GameAnswer(answer: 'हाथी', meaning: 'एक जानवर'),
  GameAnswer(answer: 'विक्रेता', meaning: 'बेचने वाला'),
  GameAnswer(answer: 'उपाय', meaning: 'तरीका'),
  GameAnswer(answer: 'स्थिर', meaning: 'अचल'),
  GameAnswer(answer: 'आवश्यक', meaning: 'अनिवार्य'),
  GameAnswer(answer: 'अस्पष्ट', meaning: 'ठीक से न दिखने वाला'),
  GameAnswer(answer: 'अर्थशास्त्र', meaning: 'धन के व्यवहार\nकी विद्या'),
  GameAnswer(answer: 'उदर', meaning: 'पेट'),
  GameAnswer(answer: 'कविता', meaning: 'लयात्मक रचना'),
  GameAnswer(answer: 'गोपनीयता', meaning: 'छिपी हुई बातें'),
  GameAnswer(answer: 'चित्रकला', meaning: 'चित्र बनाने की कला'),
  GameAnswer(answer: 'ज्ञानवान', meaning: 'जानकार'),
  GameAnswer(answer: 'शक्ति', meaning: 'ताक़त'),
  GameAnswer(answer: 'रोचक', meaning: 'दिलचस्प'),
  GameAnswer(answer: 'लघुकथा', meaning: 'छोटी कहानी'),
  GameAnswer(answer: 'वार्तालाप', meaning: 'बातचीत'),
  GameAnswer(answer: 'अभिवादन', meaning: 'शुभकामना का\nआदान-प्रदान'),
  GameAnswer(answer: 'अपवाद', meaning: 'सामान्य नियम\nसे भिन्न कोई नियम'),
  GameAnswer(answer: 'चिंतन', meaning: 'विचार'),
  GameAnswer(answer: 'विस्तार', meaning: 'फैलाव'),
  GameAnswer(answer: 'परिप्रेक्ष्य', meaning: 'सम्बन्धित'),
  GameAnswer(answer: 'प्रतिज्ञा', meaning: 'दृढ़ संकल्प\n,वचन'),
  GameAnswer(answer: 'मान्यता', meaning: 'स्वीकृति'),
  GameAnswer(answer: 'रंगमंच', meaning: 'नाट्यशाला'),
  GameAnswer(answer: 'व्यवस्था', meaning: 'आयोजन'),
  GameAnswer(answer: 'सर्वोपरि', meaning: 'सर्वाधिक'),
  GameAnswer(answer: 'संयम', meaning: 'आत्म-नियंत्रण'),
  GameAnswer(answer: 'अद्वितीय', meaning: 'अनूठा'),
  GameAnswer(answer: 'समर्पण', meaning: 'निष्ठा'),
  GameAnswer(answer: 'सहयोग', meaning: 'साथ मिलकर करना'),
  GameAnswer(answer: 'विशेषज्ञ', meaning: 'विशेष ज्ञान\nरखने वाला'),
  GameAnswer(answer: 'साहित्यिक', meaning: 'साहित्य से संबंधित'),
  GameAnswer(answer: 'समृद्धि', meaning: 'आर्थिक वृद्धि'),
  GameAnswer(answer: 'मनोबल', meaning: 'साहस'),
  GameAnswer(answer: 'स्वागत', meaning: 'आतिथ्य'),
  GameAnswer(answer: 'सफलता', meaning: 'विजय'),
  GameAnswer(answer: 'संवाद', meaning: 'बातचीत'),
  GameAnswer(answer: 'संगीत', meaning: 'गाने की कला'),
  GameAnswer(answer: 'आनंद', meaning: 'खुशी'),
  GameAnswer(answer: 'मनोरंजन', meaning: 'मन बहलाने\nका कार्य'),
  GameAnswer(answer: 'साधारण', meaning: 'सामान्य'),
  GameAnswer(answer: 'विकास', meaning: 'प्रगति'),
  GameAnswer(answer: 'सजीव', meaning: 'जीवित'),
  GameAnswer(answer: 'सहज', meaning: 'आसान'),
  GameAnswer(answer: 'मानव', meaning: 'मनुष्य'),
  GameAnswer(answer: 'साहस', meaning: 'वीरता'),
  GameAnswer(answer: 'उत्तराधिकारी', meaning: 'वारिस'),
  GameAnswer(answer: 'विशेषाधिकार', meaning: 'विशिष्ट अधिकार'),
  GameAnswer(answer: 'विस्मय', meaning: 'आश्चर्य'),
  GameAnswer(answer: 'निष्ठुर', meaning: 'क्रूर'),
  GameAnswer(answer: 'अनुग्रह', meaning: 'कृपा'),
  GameAnswer(answer: 'प्रणव', meaning: 'प्रेम'),
  GameAnswer(answer: 'आदिम', meaning: 'प्राचीन'),
  GameAnswer(answer: 'लज्जाजनक', meaning: 'शर्मनाक'),
  GameAnswer(answer: 'आचार्य', meaning: 'गुरु'),
  GameAnswer(answer: 'कौतुक', meaning: 'जिज्ञासा'),
  GameAnswer(answer: 'अतिक्रमण', meaning: 'अवैध'),
  GameAnswer(answer: 'मोहक', meaning: 'आकर्षक'),
  GameAnswer(answer: 'कुटिल', meaning: 'धूर्त'),
  GameAnswer(answer: 'प्रतिरूप', meaning: 'नक़ल, प्रारूप'),
  GameAnswer(answer: 'प्रशस्ति', meaning: 'प्रशंसा'),
  GameAnswer(answer: 'संपन्नता', meaning: 'समृद्धि'),
  GameAnswer(answer: 'सारगर्भित', meaning: 'गंभीर'),
  GameAnswer(answer: 'खण्डन', meaning: 'नकार'),
  GameAnswer(answer: 'स्वाभाविक', meaning: 'प्राकृतिक'),
  GameAnswer(answer: 'तिरस्कार', meaning: 'अपमान'),
  GameAnswer(answer: 'संप्रदाय', meaning: 'पंथ'),
  GameAnswer(answer: 'प्रतिद्वंद्वी', meaning: 'प्रतियोगी'),
  GameAnswer(answer: 'मूर्त', meaning: 'साकार'),
  GameAnswer(answer: 'आरोपण', meaning: 'आरोप'),
  GameAnswer(answer: 'निर्ममता', meaning: 'निर्दयता'),
  GameAnswer(answer: 'बोधगम्य', meaning: 'समझने योग्य'),
  GameAnswer(answer: 'तृष्णा', meaning: 'प्यास'),
  GameAnswer(answer: 'रक्तिम', meaning: 'लाल रंग का'),
  GameAnswer(answer: 'पारदर्शी', meaning: 'पारदर्शक'),
  GameAnswer(answer: 'शिथिल', meaning: 'ढीला'),
  GameAnswer(answer: 'दर्शनशास्त्र', meaning: 'दार्शनिकता'),
  GameAnswer(answer: 'प्रवृत्ति', meaning: 'स्वभाव'),
  GameAnswer(answer: 'उत्कृष्ट', meaning: 'श्रेष्ठ'),
  GameAnswer(answer: 'लाभप्रद', meaning: 'फायदेमंद'),
  GameAnswer(answer: 'यथार्थ', meaning: 'वास्तविकता'),
  GameAnswer(answer: 'संजीवनी', meaning: 'जीवनदायी, अमृत'),
  GameAnswer(answer: 'कुंठा', meaning: 'असंतोष'),
  GameAnswer(answer: 'रुग्ण', meaning: 'बीमार'),
  GameAnswer(
    answer: 'निष्पक्ष',
    meaning: 'परस्पर विरोधी\nपक्षों से अलग\nरहने वाला',
  ),
  GameAnswer(answer: 'सविनय', meaning: 'विनम्र'),
  GameAnswer(answer: 'सौम्य', meaning: 'नम्र'),
  GameAnswer(answer: 'प्रलय', meaning: 'विनाश'),
  GameAnswer(answer: 'उल्का', meaning: 'अग्निपिंड'),
  GameAnswer(answer: 'शंकित', meaning: 'संदेहपूर्ण'),
  GameAnswer(answer: 'साक्षात्कार', meaning: 'भेंट'),
  GameAnswer(answer: 'ऊष्मा', meaning: 'गर्मी'),
  GameAnswer(answer: 'अचेत', meaning: 'बेसुध'),
  GameAnswer(answer: 'सुप्त', meaning: 'सोया हुआ'),
  GameAnswer(answer: 'गृहस्थ', meaning: 'घर-बार या\nबाल-बच्चे वाला व्यक्ति'),
  GameAnswer(answer: 'आधुनिक', meaning: 'नवीन'),
  GameAnswer(answer: 'ज्योतिष', meaning: 'खगोल'),
  GameAnswer(
    answer: 'अनुप्रास',
    meaning: 'वह शब्दालंकार\nजिसमें किसी पद\nमें एक ही अक्षर\nबार-बार आता है',
  ),
  GameAnswer(answer: 'गुह्य', meaning: 'रहस्यमय'),
  GameAnswer(answer: 'तथाकथित', meaning: 'कथित'),
  GameAnswer(answer: 'दुर्व्यवहार', meaning: 'बदतमीजी'),
  GameAnswer(answer: 'विकलांग', meaning: 'अपंग'),
  GameAnswer(answer: 'भ्राता', meaning: 'भाई'),
  GameAnswer(answer: 'अवसाद', meaning: 'दु:ख'),
  GameAnswer(answer: 'दुर्लभ', meaning: 'अत्यंत विरल'),
  GameAnswer(answer: 'उद्गम', meaning: 'स्रोत'),
  GameAnswer(answer: 'छलावा', meaning: 'छल'),
  GameAnswer(answer: 'क्रियान्वयन', meaning: 'कार्यान्वयन'),
  GameAnswer(answer: 'व्यूह', meaning: 'रणनीति'),
  GameAnswer(answer: 'निपुण', meaning: 'कुशल'),
  GameAnswer(answer: 'रूपक', meaning: 'वह काव्य जिसका\nअभिनय किया जाए'),
  GameAnswer(answer: 'निराकरण', meaning: 'समाधान'),
  GameAnswer(answer: 'भृतक', meaning: 'श्रमिक'),
  GameAnswer(answer: 'प्रवंचना', meaning: 'ठगने का काम'),
  GameAnswer(answer: 'किंकर्तव्यविमूढ़', meaning: 'हक्का-बक्का'),
];

final List<GameAnswer> tutorialWords = [
  GameAnswer(
    //title: LocaleKeys.intro_tutorial_tutorial1_title.tr(),
    answer: 'समय',
    meaning: 'वह अवधि जिसमें कोई कार्य किया जाता है',
    itemsCount: 8,
    icons: [LineIcons.clock],
    moveHorizontal: true,
    moveVertical: false,
    colors: [const Color.fromARGB(255, 99, 108, 104)],
    backgroundColor: const Color.fromARGB(255, 222, 197, 165),
    whenToShowIcons: -1,
  ),
  GameAnswer(
    //title: LocaleKeys.intro_tutorial_tutorial2_title.tr(),
    answer: 'बादल',
    meaning: 'पृथ्वी के जल से बुनी हुई वह भाप, जिससे पानी बरसता है',
    icons: [LineIcons.cloud],
    moveHorizontal: true,
    moveVertical: false,
    colors: [Colors.blue, Colors.cyan],
    backgroundColor: Colors.blue[100],
    whenToShowIcons: -1,
  ),
  GameAnswer(
    //title: LocaleKeys.intro_tutorial_tutorial3_title.tr(),
    answer: 'किताब',
    meaning: 'पुस्तक',
    images: [
      '''<svg viewBox="0 0 686.931 472.607" xmlns="http://www.w3.org/2000/svg"><path d="m685.53 220.8c-.24-.67-.58-1.33-1-1.93-.42-.61-.91-1.16-1.46-1.63-.54-.46-1.14-.84-1.76-1.09l-285.35-116.35c-.42-.174-.84-.396-1.27-.672s-.87-.607-1.32-1-.91-.846-1.39-1.367c-.47-.521-.96-1.11-1.47-1.772-.75-.985-1.52-2.131-2.29-3.42s-1.54-2.721-2.3-4.277-1.51-3.236-2.23-5.022c-.73-1.787-1.42-3.678-2.07-5.657-.66-1.982-1.28-4.05-1.86-6.186-.58-2.137-1.11-4.344-1.59-6.602-.48-2.26-.9-4.572-1.27-6.919-.36-2.35-.66-4.735-.9-7.138-.31-3.208-.49-6.292-.54-9.219-.04-2.933.03-5.71.23-8.301.19-2.595.51-5.003.92-7.193.42-2.193.94-4.168 1.55-5.892.3-.862.62-1.66.97-2.392.34-.732.7-1.398 1.08-1.996.38-.599.77-1.129 1.17-1.589s.81-.851 1.22-1.17c.08-.057.15-.112.23-.165s.15-.104.23-.151c.07-.049.14-.095.22-.139s.15-.086.22-.126c-123.45 65.965-246.9 131.92-370.35 197.88-.063.04-.126.07-.19.11s-.127.08-.19.13c-.063.04-.126.08-.189.13-.062.05-.125.1-.188.15-.344.29-.675.66-.988 1.11-.313.44-.609.96-.884 1.55-.274.59-.528 1.26-.757 2-.229.73-.433 1.54-.608 2.42-.355 1.76-.597 3.79-.716 6.06-.12 2.27-.118 4.78.012 7.5s.389 5.64.783 8.74.924 6.37 1.597 9.79c.501 2.57 1.064 5.11 1.678 7.63s1.279 5 1.988 7.44c.708 2.43 1.458 4.82 2.242 7.13.783 2.32 1.601 4.57 2.442 6.73.836 2.16 1.7 4.23 2.575 6.19s1.761 3.81 2.644 5.54c.883 1.72 1.763 3.31 2.623 4.76.861 1.44 1.703 2.73 2.511 3.86.544.75 1.063 1.43 1.562 2.03s.977 1.13 1.437 1.59c.46.47.904.86 1.333 1.2s.843.62 1.247.85l279.72 156.76c.62.35 1.22.82 1.79 1.38.57.57 1.1 1.22 1.56 1.91s.86 1.43 1.16 2.18c.31.74.52 1.49.6 2.2.05.36.06.69.04 1-.02.3-.06.57-.14.82s-.18.46-.31.64c-.13.19-.28.34-.45.46 121.86-81.86 243.73-163.72 365.6-245.58.2-.13.38-.3.54-.49.15-.19.29-.41.4-.65.1-.25.19-.52.24-.81s.08-.61.07-.94c-.01-.67-.16-1.36-.4-2.04z" fill="#ca521f" stroke="#ce6532" stroke-width="2"/><path d="m297.16 394.96c.51 4.06 1.19 8.1 2 12.1.82 4 1.77 7.94 2.85 11.81 1.08 3.85 2.28 7.63 3.59 11.28 1.3 3.65 2.72 7.18 4.23 10.56.45.99.9 1.96 1.36 2.92.45.96.92 1.91 1.4 2.84s.96 1.85 1.45 2.75c.5.91 1 1.8 1.51 2.67l-273.48-152.13c-.411-.23-.828-.51-1.26-.85s-.877-.73-1.34-1.2-.943-.99-1.444-1.6c-.501-.6-1.022-1.28-1.568-2.04-.812-1.12-1.656-2.42-2.52-3.87-.864-1.44-1.745-3.04-2.63-4.77s-1.772-3.59-2.648-5.56-1.739-4.04-2.576-6.21c-.841-2.17-1.657-4.42-2.439-6.75-.783-2.32-1.531-4.72-2.236-7.16-.706-2.44-1.368-4.94-1.979-7.46-.61-2.53-1.169-5.09-1.665-7.66-.667-3.43-1.189-6.72-1.575-9.83-.387-3.12-.637-6.05-.758-8.78-.122-2.73-.114-5.26.016-7.54.129-2.28.38-4.32.746-6.09.18-.88.389-1.69.623-2.44.234-.74.493-1.41.772-2 .28-.6.581-1.12.898-1.57.318-.44.653-.82 1.001-1.11.354-.3.714-.52 1.08-.67.366-.16.738-.24 1.117-.26.38-.02.767.02 1.161.12.395.1.798.26 1.211.47l278.84 144.79c-.68.8-1.3 1.71-1.86 2.72-.57 1-1.09 2.1-1.56 3.28-.46 1.18-.88 2.45-1.26 3.8-.37 1.35-.69 2.78-.98 4.29-.38 2.08-.67 4.31-.87 6.67s-.31 4.85-.32 7.46c-.02 2.61.07 5.34.25 8.18.19 2.84.47 5.79.86 8.84z" fill="#3f973e"/><path d="m297.16 394.96c.51 4.06 1.19 8.1 2 12.1.82 4 1.77 7.94 2.85 11.81 1.08 3.85 2.28 7.63 3.59 11.28 1.3 3.65 2.72 7.18 4.23 10.56.45.99.9 1.96 1.36 2.92.45.96.92 1.91 1.4 2.84s.96 1.85 1.45 2.75c.5.91 1 1.8 1.51 2.67l-273.48-152.13c-.411-.23-.828-.51-1.26-.85s-.877-.73-1.34-1.2-.943-.99-1.444-1.6c-.501-.6-1.022-1.28-1.568-2.04-.812-1.12-1.656-2.42-2.52-3.87-.864-1.44-1.745-3.04-2.63-4.77s-1.772-3.59-2.648-5.56-1.739-4.04-2.576-6.21c-.841-2.17-1.657-4.42-2.439-6.75-.783-2.32-1.531-4.72-2.236-7.16-.706-2.44-1.368-4.94-1.979-7.46-.61-2.53-1.169-5.09-1.665-7.66-.667-3.43-1.189-6.72-1.575-9.83-.387-3.12-.637-6.05-.758-8.78-.122-2.73-.114-5.26.016-7.54.129-2.28.38-4.32.746-6.09.18-.88.389-1.69.623-2.44.234-.74.493-1.41.772-2 .28-.6.581-1.12.898-1.57.318-.44.653-.82 1.001-1.11.354-.3.714-.52 1.08-.67.366-.16.738-.24 1.117-.26.38-.02.767.02 1.161.12.395.1.798.26 1.211.47l278.84 144.79c-.68.8-1.3 1.71-1.86 2.72-.57 1-1.09 2.1-1.56 3.28-.46 1.18-.88 2.45-1.26 3.8-.37 1.35-.69 2.78-.98 4.29-.38 2.08-.67 4.31-.87 6.67s-.31 4.85-.32 7.46c-.02 2.61.07 5.34.25 8.18.19 2.84.47 5.79.86 8.84z" fill="#fff"/><path d="m378.6 15.184c-.36-.131-.7-.229-1.05-.289s-.69-.084-1.03-.068c-.35.016-.69.071-1.04.169-.34.098-.68.237-1.03.422-118.07 63.111-236.13 126.22-354.2 189.33.301-.16.603-.27.909-.34.307-.07.618-.09.934-.07s.638.08.965.18.66.23.999.41l278.84 144.79 360.36-226.93-284.66-107.61z" fill="#3f973e"/><path d="m664.59 216.43c-.43-.8-.85-1.62-1.26-2.46s-.81-1.69-1.19-2.55c-.39-.86-.77-1.74-1.14-2.64-1.25-3.05-2.39-6.26-3.39-9.6-1.01-3.34-1.89-6.8-2.63-10.36-.74-3.57-1.34-7.23-1.78-10.95-.44-3.73-.73-7.51-.85-11.33-.09-2.86-.08-5.64.03-8.33.1-2.69.31-5.28.6-7.77.29-2.5.67-4.88 1.13-7.15.47-2.27 1.02-4.43 1.65-6.45.45-1.47.95-2.86 1.49-4.19s1.12-2.59 1.74-3.77c.63-1.18 1.29-2.28 2-3.3.71-1.01 1.47-1.95 2.27-2.79l-360.37 226.93c-.67.8-1.29 1.71-1.85 2.71-.57 1.01-1.09 2.1-1.56 3.29-.47 1.18-.88 2.45-1.26 3.8-.37 1.35-.7 2.78-.98 4.29-.38 2.08-.67 4.31-.87 6.67-.21 2.35-.31 4.85-.33 7.46-.01 2.61.08 5.34.26 8.18s.47 5.79.86 8.84c.51 4.06 1.19 8.1 2 12.1.82 4 1.77 7.94 2.85 11.81 1.08 3.85 2.28 7.63 3.59 11.28 1.3 3.65 2.72 7.18 4.23 10.56.45.99.9 1.96 1.35 2.92.46.96.93 1.91 1.41 2.84.47.93.96 1.85 1.45 2.75.5.91 1 1.8 1.51 2.67l350.36-233.08c-.45-.78-.89-1.57-1.32-2.38z" fill="#e2e3e4"/><g stroke="#ce6532" stroke-width="2"><path d="m683.05 115.13c-.25-.7-.6-1.37-1.03-1.99s-.93-1.18-1.49-1.65c-.56-.46-1.17-.83-1.81-1.07l-292.02-108.68c-.77-.289-1.51-.487-2.24-.606-.72-.118-1.42-.157-2.1-.122s-1.33.144-1.95.319c-.63.175-1.23.417-1.8.72-123.69 65.605-247.39 131.21-371.08 196.81.489-.26 1.012-.45 1.566-.57s1.142-.16 1.761-.12c.619.03 1.27.15 1.95.35.681.2 1.391.49 2.13.88l285.76 148.46c.63.33 1.25.8 1.84 1.36.58.56 1.12 1.22 1.6 1.93s.89 1.48 1.2 2.25c.31.78.53 1.57.62 2.32.05.41.07.78.04 1.13-.02.34-.08.65-.16.93-.09.27-.21.52-.36.72s-.33.37-.53.5c125.69-79.51 251.37-159.01 377.07-238.52.23-.14.44-.32.62-.53s.33-.46.46-.73c.12-.27.22-.57.28-.9s.09-.68.08-1.06c-.02-.71-.16-1.43-.41-2.13z" fill="#ca521f"/><path d="m14.937 199.4 285.76 148.46c.63.33 1.25.8 1.84 1.36.58.56 1.12 1.22 1.6 1.93s.89 1.48 1.2 2.25c.31.78.53 1.57.62 2.32.1.76.06 1.41-.09 1.95-.15.53-.41.94-.77 1.22-.35.28-.79.42-1.31.41-.51-.01-1.09-.17-1.72-.5l-285.15-149.28c-.411-.22-.812-.38-1.203-.48s-.775-.14-1.151-.12c-.375.02-.744.1-1.105.26-.362.15-.717.37-1.067.66-.344.29-.675.66-.988 1.11-.313.44-.609.96-.884 1.55-.274.59-.528 1.26-.757 2-.229.73-.433 1.54-.608 2.42-.355 1.76-.597 3.79-.716 6.06-.12 2.27-.118 4.78.012 7.5s.389 5.64.783 8.74.924 6.37 1.597 9.79c.501 2.57 1.064 5.11 1.678 7.63s1.279 5 1.988 7.44c.708 2.43 1.458 4.82 2.242 7.13.783 2.32 1.601 4.57 2.442 6.73.836 2.16 1.7 4.23 2.575 6.19s1.761 3.81 2.644 5.54c.883 1.72 1.763 3.31 2.623 4.76.861 1.44 1.703 2.73 2.511 3.86.544.75 1.063 1.43 1.562 2.03s.977 1.13 1.437 1.59c.46.47.904.86 1.333 1.2s.843.62 1.247.85l279.72 156.76c.61.35 1.21.82 1.78 1.38.57.57 1.1 1.22 1.56 1.91s.86 1.43 1.16 2.18c.31.74.52 1.49.6 2.2.09.71.05 1.32-.1 1.81s-.41.86-.75 1.1c-.35.24-.78.34-1.28.3-.51-.04-1.07-.23-1.69-.58l-279.16-157.48c-.9-.51-1.803-1.13-2.704-1.85-.9-.72-1.799-1.53-2.689-2.43-.889-.9-1.769-1.88-2.633-2.92-.863-1.04-1.71-2.15-2.533-3.3-.831-1.16-1.645-2.38-2.443-3.64s-1.581-2.57-2.348-3.93c-.768-1.35-1.52-2.75-2.257-4.19s-1.46-2.92-2.168-4.43c-1.412-3.03-2.77-6.22-4.058-9.52-1.289-3.31-2.509-6.73-3.645-10.24-1.137-3.52-2.189-7.12-3.143-10.78-.955-3.66-1.812-7.38-2.553-11.12-.554-2.81-1.023-5.53-1.41-8.15-.387-2.63-.691-5.16-.914-7.59s-.364-4.75-.426-6.96-.043-4.3.054-6.26c.103-1.95.28-3.79.538-5.48.258-1.7.597-3.25 1.021-4.65.425-1.4.935-2.64 1.537-3.71.603-1.06 1.297-1.95 2.088-2.65.523-.46 1.098-.83 1.724-1.1s1.303-.43 2.028-.48c.726-.04 1.499.03 2.318.23.819.21 1.684.53 2.593 1.01z" fill="#d5804b"/></g></svg>''',
    ],
    moveHorizontal: false,
    moveVertical: true,
    colors: [const Color.fromARGB(255, 209, 116, 255)],
    backgroundColor: const Color.fromARGB(255, 195, 177, 226),
    whenToShowIcons: -1,
  ),
  /*   GameAnswer(
      title: LocaleKeys.intro_tutorial_tutorial3_title.tr(),
      answer: 'चश्मा',
      meaning: 'आँखों की रोशनी बढ़ाने वाला यंत्र',
      icons: [LineIcons.glasses],
      moveHorizontal: true,
      moveVertical: false,
      colors: const [Color.fromARGB(221, 78, 60, 60)],
      backgroundColor: const Color.fromARGB(255, 241, 228, 252),
      whenToShowIcons: -1), */
];
