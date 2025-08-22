
# Samvargani: Indian Language Word Game

Samvargani is a powerful framework for designing beautiful and easy-to-play word games for vernacular languages, specifically Indian ones. Samvargani's unique utility files are made to be customizable for many Indian languages, providing support for 'matras', 'half-letters' etc.
 
<a href="https://play.google.com/store/apps/details?id=com.aruhant.paheli">
<img height="40px" alt="Get it on Google Play" src="https://aruhant.github.io/s/and.png" /></a>
<a href="https://apps.apple.com/us/app/samvargini/id6455461367">
<img height="40px" alt="Get it on App Store" src="https://aruhant.github.io/s/ios.png" /></a>


## Flexibility between languages

Designing games in your language is easy with Samvargani whether you incorporate entire widgets or use its many robust helper functions.

### Easy-to-use and customizable keyboard

Use popular existing keyboards for your script or easily design an entirely new one in whichever orientation suits the game.

<img src="https://github.com/aruhant/samvargani/assets/125254014/7de51020-e11c-4db6-91e1-3d5cb2659177" height="450" >

### Algorithms

utls/string.dart contains many useful algorithms for designing the core gameplay of word games. These algorithms are mostly valid for all Indic languages. It takes into account the unique characteristics of Indic languages and can be basis of word games in these languages.

```dart
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
```

## Daily word challenge

Although not limited to, Samvargani is best suited for daily word challenge games (like 'wordle' from which we are heavily inspired).

<img src="https://github.com/aruhant/samvargani/assets/125254014/10bfb56a-80f7-4f5c-8682-334a026e62dd" height="450" >

### Database


<img src="https://github.com/aruhant/samvargani/assets/125254014/4ad70db7-48bd-4330-88bd-f17ed5ffc202" height="50" >

Samvargani makes planning and designing daily challenges easy-peasy. The maintainers of the game simply work on Firebase's Realtime Database.

### Notifications, Sharing and Other Utilities

Use a convenient notification system, signalling when a new challenge has arrived and so forth. Make use of the Sharing system to attract users.
``` dart
shareScreenShot(
  ScreenshotController screenshotController,
  String message,
  BuildContext context,
) {
  final box = context.findRenderObject() as RenderBox?;

  screenshotController
      .capture(delay: const Duration(milliseconds: 200))
      .then((image) async {
    if (image != null) {
      final directory = await getApplicationDocumentsDirectory();
      final imagePath = await File('${directory.path}/image.png').create();
      await imagePath.writeAsBytes(image);

      await Share.shareXFiles(
        [XFile(imagePath.path)],
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size,
        text: Platform.isAndroid ? message : null,
      );
    }
  });
}
```



### General Game Mechanics

Included features (victory screens, hint icons, clues, previous word history etc.) your game will be more complete and lively. We have worked hard to design a good code structure with our third-party-library use and main classes (such as 'Game', 'Game_Widget', 'Answer' etc).


<img src="https://github.com/aruhant/samvargani/assets/125254014/1e7a12f0-d095-4301-b3d5-2a6fa387fa82" height="450" >


### Date and Time

Simple and customizable date and time system, calibrated with database.


## Example: Hindi Word Game
<img src="https://github.com/aruhant/samvargani/assets/125254014/974b934d-dca9-4415-ab36-f71a7782ac16" height="50" >


We have developed and published a popular Hindi word game (https://aruhant.github.io/s/) using this framework. It is a word-guessing game (inspired by 'wordle') with daily challenges and practice to refine one's Hindi vocabulary, both learning new words and refamiliarizing oneself with less-commonly used words. 


## Our goals with this project

 - Part of our series on language and culture preservation
 - Foster love for the many regional languages of India (and the world) and promote linguistic diversity
 - - Safeguards the many languages in threat of extinction, an unfortunate consequence of globalization
 - - Act as digital repositories, if possible
 - Improve users' knowledge in regional languages
 - - Greater acquaintance with its script
 -  - Improve vocabulary
 - - Communicate the language often
 - Captivate users through beautiful UI
