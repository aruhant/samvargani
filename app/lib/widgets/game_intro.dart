import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/widgets/line_widget.dart';

class GameHelpWidget extends StatefulWidget {
  const GameHelpWidget({Key? key, required this.onIntroEnd}) : super(key: key);
  final VoidCallback onIntroEnd;

  @override
  GameHelpWidgetState createState() => GameHelpWidgetState();
}

class GameHelpWidgetState extends State<GameHelpWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    widget.onIntroEnd();
    Game t = Game.load(answer: gameAnswers[0]);
    t.addGuess('दावत');
    t.addGuess('बालक');
    UserPrefs.instance.saveGame(t);
  }

/*   Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  } */

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
      bodyAlignment: Alignment.center,
      safeArea: 0,
      imagePadding: EdgeInsets.only(left: 24, right: 24, top: 60),
    );
    final autoSizeGroup = AutoSizeGroup();

    return IntroductionScreen(
      key: introKey,

      globalBackgroundColor: const Color.fromRGBO(213, 204, 158, 1),
      allowImplicitScrolling: true,
      autoScrollDuration: null,
      pages: [
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              _buildImage('icon.png'),
              const SizedBox(height: 20),
              AutoSizeText(
                LocaleKeys.intro_page1_title.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 4,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              AutoSizeText(
                LocaleKeys.intro_page1_body.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 6,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              AutoSizeText(
                LocaleKeys.intro_page2_title.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 4,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              LineWidget(
                  disableTooltip: true,
                  line: Line(cells: [Cell('ा'), Cell(''), Cell('')]),
                  group: autoSizeGroup),
              const SizedBox(height: 20),
              AutoSizeText(
                LocaleKeys.intro_page2_body.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 6,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              AutoSizeText(
                LocaleKeys.intro_page3_title.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 4,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              LineWidget(
                  disableTooltip: true,
                  line: Line(cells: [
                    Cell('बा', state: CellState.correct),
                    Cell('ल', state: CellState.misplaced),
                    Cell('क', state: CellState.incorrect)
                  ]),
                  group: autoSizeGroup),
              const SizedBox(height: 20),
              AutoSizeText(
                LocaleKeys.intro_page3_body.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 6,
                maxFontSize: 30,
                minFontSize: 18,
                textAlign: TextAlign.left,
              ),
            ],
          ),
          // "जैसा कि हम देख सकते हैं कि जिस शब्द का हमें अनुमान है उसमें 2 अक्षर हैं; दूसरे स्थान पर एक मंत्र के साथ एक अक्षर भी है; तीसरे स्थान पर कुछ पूर्ण अक्षर के साथ आधा अक्षर - 's' है।",
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              AutoSizeText(
                LocaleKeys.intro_page4_title.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 4,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
              //_buildImage('intro3.png'),
              // add three lineWidgets दावत,बालक, ा
              LineWidget(
                  line: Line(cells: [
                    Cell('दा', state: CellState.misplacedVyanjan),
                    Cell('व', state: CellState.incorrect),
                    Cell('त', state: CellState.incorrect)
                  ]),
                  group: autoSizeGroup),
              LineWidget(
                  line: Line(cells: [
                    Cell('बा', state: CellState.correct),
                    Cell('ल', state: CellState.misplaced),
                    Cell('क', state: CellState.incorrect)
                  ]),
                  group: autoSizeGroup),
              LineWidget(
                  line: Line(cells: [Cell('ा'), Cell(''), Cell('')]),
                  group: autoSizeGroup),
              const SizedBox(height: 20),
              AutoSizeText(
                LocaleKeys.intro_page4_body.tr(),
                style: const TextStyle(fontSize: 60, color: Colors.black),
                maxLines: 4,
                maxFontSize: 30,
                minFontSize: 14,
                textAlign: TextAlign.center,
              ),
            ],
          ),
          // "अब हमें 4 अक्षरों वाले एक वैध शब्द का अनुमान लगाना है। ध्यान दें कि हमारे उत्तर में मात्रा और आधा अक्षर होना आवश्यक है, लेकिन ध्यान रखें कि अंतिम शब्द में मात्रा और आधा अक्षर होगा। अभी, यह समझना आसान है कि अंतिम शब्द में एक अक्षर होगा, लेकिन अब हमें अन्य तीन अक्षरों का अनुमान लगाना होगा।",
          decoration: pageDecoration,
        ),
        /*
        PageViewModel(
          title: "हमारा पहला उत्तर :-",
          body:
              "अब हमें 4 अक्षरों वाले एक वैध शब्द का अनुमान लगाना है। ध्यान दें कि हमारे उत्तर में मात्रा और आधा अक्षर होना आवश्यक है, लेकिन ध्यान रखें कि अंतिम शब्द में मात्रा और आधा अक्षर होगा। अभी, यह समझने के लिए कि अंतिम शब्द में कौन से अक्षर मौजूद हैं, आइए एक चार अक्षर वाले शब्द का प्रयास करें - - 'सतियाना'",
          image: _buildImage('img4.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "red coloured 's'",
          body:
              "जैसा कि हम देख सकते हैं 's' को लाल रंग से चिह्नित किया गया है - इसका मतलब है कि शब्द में 's' का कोई भी व्युत्पन्न शामिल नहीं है। इसका मतलब यह है कि शब्द के कोई भी स्थान पे 'सा', 'सी, 'सू', 'सो,' 'त्सा' आदि उपस्थित नहीं है।",
          image: _buildImage('img5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "yellow coloured 't'",
          body:
              "'टी' को पीले रंग से चिह्नित किया गया है। इसका अर्थ है 't' या इसका कोई व्युत्पन्न शब्द में मौजूद है, लेकिन उस तीसरे स्थान पर नहीं।",
          image: _buildImage('img5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "हल्का हरा रंग 'H'",
          body:
              "'H' को हल्के हरे रंग से चिह्नित किया गया है। इसका मतलब यह है कि 'एच' मौके पर मौजूद है, सिर्फ फॉर्म में नहीं। इसका मतलब यह है कि उस स्थान पर 'HI', 'HO', 'HOO' इत्यादि हो सकते हैं। इसे ठीक करने के लिए वहां दिए गए मात्रा और आधा अक्षर का उपयोग करें।",
          image: _buildImage('img5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "गहरा हरा 'एन'",
          body:
              "'एन' अक्षर को गहरे हरे रंग से चिह्नित किया गया है। इसका मतलब यह है कि यह सही जगह पर है और सही स्थान पर है और इसे बदलने की आवश्यकता नहीं है।",
          image: _buildImage('img5.jpg'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "विजय",
          body:
              "अब, आपमें से कुछ लोगों को यह बात पहले ही मिल गई होगी। हाँ वास्तव में यह है - 'एबीसीडी'",
          image: _buildImage('img5.jpg'),
          decoration: pageDecoration,
        ),*/ /*
        PageViewModel(
          title: "Full Screen Page",
          body:
              "Pages can be full screen as well.\n\nLorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc id euismod lectus, non tempor felis. Nam rutrum rhoncus est ac venenatis.",
          image: _buildFullscreenImage(),
          decoration: pageDecoration.copyWith(
            contentMargin: const EdgeInsets.symmetric(horizontal: 16),
            fullScreen: true,
            bodyFlex: 2,
            imageFlex: 3,
            safeArea: 100,
          ),
        ), 
        PageViewModel(
          title: "Another title page",
          body: "Another beautiful body text for this example onboarding",
          image: _buildImage('img2.jpg'),
          footer: ElevatedButton(
            onPressed: () {
              introKey.currentState?.animateScroll(0);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            child: const Text(
              'FooButton',
              style: TextStyle(color: Colors.white),
            ),
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 6,
            imageFlex: 6,
            safeArea: 80,
          ),
        ), 
        PageViewModel(
          title: "Title of last page - reversed",
          bodyWidget: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Click on "),
              Icon(Icons.edit),
              Text(" to edit a post"),
            ],
          ),
          decoration: pageDecoration.copyWith(
            bodyFlex: 2,
            imageFlex: 4,
            bodyAlignment: Alignment.bottomCenter,
            imageAlignment: Alignment.topCenter,
          ),
          image: _buildImage('img1.jpg'),
          reverse: true,
        ), */
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      next: const Icon(Icons.arrow_forward),
      done: Text(LocaleKeys.intro_done.tr(),
          style: const TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
    );
  }
} /* 

class Tutorial extends StatefulWidget {
  const Tutorial({Key? key}) : super(key: key);
  @override
  TutorialState createState() => TutorialState();
}

class TutorialState extends State<Tutorial> {
  late Game game;
  @override
  void initState() {
    super.initState();
    game = Game.load(
        answer: gameAnswers[UserPrefs.instance.practiceGameIndex],
        onSuceess: displayResult);
  }

  displayResult(GameResult result) async {
    await showDialog(
        context: context,
        builder: (context) => ResultWidget(gameResult: result));
    setState(() {
      game = Game.load(
        answer: gameAnswers[0],
        onSuceess: displayResult,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return GameWidget(
      game: game,
    );
  }
}
 */
