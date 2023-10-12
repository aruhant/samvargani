import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/line.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/widgets/line_widget.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class GameHelpWidget extends StatefulWidget {
  const GameHelpWidget({Key? key, required this.onIntroEnd}) : super(key: key);
  final VoidCallback onIntroEnd;

  @override
  GameHelpWidgetState createState() => GameHelpWidgetState();
}

class GameHelpWidgetState extends State<GameHelpWidget> {
  GameHelpWidgetState() {
    FirebaseAnalytics.instance.logEvent(name: 'intro_begin');
  }
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    widget.onIntroEnd();
    Game t = Game.load(answer: tutorialWords[0]);
    t.addGuess('समझ');
    t.addGuess('तनय');
    UserPrefs.instance.saveGame(t);
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    AutoSizeGroup groupPage3 = AutoSizeGroup();
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.black),
      bodyTextStyle: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w400, color: Colors.black),
      bodyAlignment: Alignment.center,
      safeArea: 0,
      imagePadding: EdgeInsets.only(left: 24, right: 24, top: 60),
    );
    final autoSizeGroupCells = AutoSizeGroup();
    //final autoSizeGroupBody = AutoSizeGroup();

    return IntroductionScreen(
      key: introKey,
      globalBackgroundColor: const Color.fromRGBO(213, 204, 158, 1),
      allowImplicitScrolling: true,
      autoScrollDuration: null,
      bodyPadding: EdgeInsets.only(left: 24.w, right: 24.w),
      pages: [
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              _buildImage('icon.png', 200.w),
              SizedBox(height: 20.w),
              makeTitle(LocaleKeys.intro_page1_title.tr()),
              SizedBox(height: 10.w),
              makeBody(LocaleKeys.intro_page1_body.tr()),
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
              makeTitle(LocaleKeys.intro_page2_title.tr()),
              const SizedBox(height: 20),
              LineWidget(
                  disableTooltip: true,
                  line: Line(cells: [Cell(''), Cell('े'), Cell('ी')]),
                  group: autoSizeGroupCells),
              const SizedBox(height: 20),
              makeBody(LocaleKeys.intro_page2_body.tr()),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: '',
          bodyWidget: Column(
            children: [
              makeTitle(LocaleKeys.intro_page3_title.tr()),
              const SizedBox(height: 20),
              LineWidget(
                  disableTooltip: true,
                  line: Line(cells: [
                    Cell('प', state: CellState.correct),
                    Cell('हे', state: CellState.misplaced),
                    Cell('ली', state: CellState.incorrect)
                  ]),
                  group: autoSizeGroupCells),
              const SizedBox(height: 20),
              makeBody(LocaleKeys.intro_page3_body_line1.tr(),
                  maxlines: 2,
                  group: groupPage3,
                  rectangleColor: const Color.fromRGBO(129, 178, 154, 1),
                  textAlign: TextAlign.left),
              makeBody(LocaleKeys.intro_page3_body_line2.tr(),
                  maxlines: 2,
                  group: groupPage3,
                  rectangleColor: const Color.fromRGBO(242, 204, 143, 1),
                  textAlign: TextAlign.left),
              makeBody(LocaleKeys.intro_page3_body_line3.tr(),
                  maxlines: 2,
                  group: groupPage3,
                  rectangleColor: const Color.fromRGBO(224, 122, 95, 1),
                  textAlign: TextAlign.left),
            ],
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "",
          bodyWidget: Column(
            children: [
              makeTitle(LocaleKeys.intro_page4_title.tr()),
              const SizedBox(height: 20),

              LineWidget(
                  line: Line(cells: [
                    Cell('स', state: CellState.correct),
                    Cell('म', state: CellState.correct),
                    Cell('झ', state: CellState.incorrect)
                  ]),
                  group: autoSizeGroupCells),
              //तनय
              LineWidget(
                  line: Line(cells: [
                    Cell('त', state: CellState.incorrect),
                    Cell('न', state: CellState.incorrect),
                    Cell('य', state: CellState.correct)
                  ]),
                  group: autoSizeGroupCells),

              LineWidget(
                  line: Line(cells: [Cell(''), Cell(''), Cell('')]),
                  group: autoSizeGroupCells),
              const SizedBox(height: 20),
              makeBody(
                LocaleKeys.intro_page4_body.tr(),
              ),
            ],
          ),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      showSkipButton: false,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
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
}

makeTitle(String text) => AutoSizeText(
      text,
      style: TextStyle(
          fontSize: 30.sp, fontWeight: FontWeight.bold, color: Colors.black),
      maxLines: 3,
      maxFontSize: (30.sp.truncateToDouble()),
      minFontSize: 8.sp.truncateToDouble(),
      textAlign: TextAlign.center,
    );

makeBody(String text,
        {textAlign = TextAlign.center,
        AutoSizeGroup? group,
        Color? rectangleColor,
        int maxlines = 6}) =>
    AutoSizeText.rich(
        TextSpan(
          children: [
            if (rectangleColor != null)
              TextSpan(
                  text: '  ',
                  style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Courier',
                      backgroundColor: rectangleColor)),
            if (rectangleColor != null)
              TextSpan(
                  text: ' ',
                  style: TextStyle(fontSize: 24.sp, fontFamily: 'Courier')),
            TextSpan(
                text: text,
                style: TextStyle(
                    fontSize: 24.sp, color: Colors.black, height: 1.5)),
          ],
        ),
        style: TextStyle(fontSize: 24.sp, color: Colors.black),
        maxLines: maxlines,
        maxFontSize: (24.sp.truncateToDouble()),
        minFontSize: 8.sp.truncateToDouble(),
        textAlign: textAlign,
        group: group);
