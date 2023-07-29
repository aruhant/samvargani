import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:paheli/widgets/practice_game.dart';

class GameHelpWidget extends StatefulWidget {
  const GameHelpWidget({Key? key}) : super(key: key);

  @override
  GameHelpWidgetState createState() => GameHelpWidgetState();
}

class GameHelpWidgetState extends State<GameHelpWidget> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    UserPrefs.instance.firstRunDone();
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const PracticeGame()),
    );
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 350]) {
    return Image.asset('assets/$assetName', width: width);
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      // bodyPadding: EdgeInsets.all(20),
      // contentMargin: EdgeInsets.all(20),
      bodyAlignment: Alignment.centerLeft,
      pageColor: Colors.white,
      imagePadding: EdgeInsets.all(16),
    );

    return IntroductionScreen(
      key: introKey,

      globalBackgroundColor: Colors.white,
      allowImplicitScrolling: true,
      autoScrollDuration: null,
      // globalHeader: Align(
      //   alignment: Alignment.topRight,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(top: 16, right: 16),
      //       child: _buildImage('flutter.png', 100),
      //     ),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title:
              "संवर्गनी में आपका स्वागत है, आइए जानें इस दिलचस्प खेल के बारे में।",
          body:
              "इस खेल में, आपको कम से कम प्रयास में एक 2-से-5 अक्षर का शब्द बुझाना है।",
          image: _buildImage('icon.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "इस खेल में, आपको कम से कम प्रयास में 2-5 अक्षर का शब्द बुझाना है।",
          body:
              "प्रत्येक उत्तर के बाद आपको पता चलेगा कि आपके अनुमान में कौन से अक्षर सही हैं",
          image: _buildImage('intro1.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title:
              "खेल के दौरान इस संकेतिका को देखने के लिए आप अक्षरों को छू सकते हैं",
          bodyWidget: AutoSizeText(
            "🟥 से चिह्नित अक्षर सही उत्तर में कहीं भी मौजूद नहीं हैं\n🟩 से चिह्नित अक्षर अपने सही स्थान पर हैं\n🟧 से चिह्नित अक्षर अपने सही स्थान पर नहीं हैं",
            style: TextStyle(fontSize: 60),
            maxLines: 3,
            maxFontSize: 60,
            minFontSize: 5,
            textAlign: TextAlign.left,
          ),
          // "जैसा कि हम देख सकते हैं कि जिस शब्द का हमें अनुमान है उसमें 2 अक्षर हैं; दूसरे स्थान पर एक मंत्र के साथ एक अक्षर भी है; तीसरे स्थान पर कुछ पूर्ण अक्षर के साथ आधा अक्षर - 's' है।",
          image: _buildImage('intro2.png'),
          decoration: pageDecoration,
        ), /*
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
              Text("Click on ", style: bodyStyle),
              Icon(Icons.edit),
              Text(" to edit a post", style: bodyStyle),
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
        ),*/
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      //rtl: true, // Display as right-to-left
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
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
