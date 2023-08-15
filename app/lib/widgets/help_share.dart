import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/utils/share.dart';
import 'line_widget.dart';
import 'package:screenshot/screenshot.dart';

class HelpShareWidget extends StatefulWidget {
  const HelpShareWidget(this.game, {super.key});
  final Game game;

  @override
  State<HelpShareWidget> createState() => _HelpShareWidgetState();
}

class _HelpShareWidgetState extends State<HelpShareWidget> {
  bool pressedShare = false;
  final _screenShotController = ScreenshotController();

  @override
  Widget build(BuildContext context) {
    return Material(
        color: Colors.black12,
        child: Screenshot(
          controller: _screenShotController,
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18),
                border: Border.all(
                    color: const Color.fromARGB(255, 231, 255, 229), width: 5),
                gradient: LinearGradient(colors: const [
                  Color.fromRGBO(255, 239, 224, 1),
                  Color.fromRGBO(245, 221, 187, 1),
                  Color.fromRGBO(252, 242, 229, 1),
                ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
            padding: const EdgeInsets.all(18),
            margin: const EdgeInsets.all(18),
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: const Icon(Icons.close),
                      color: Colors.black,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ),
                Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Text(LocaleKeys.gameResult_defeatMessage.tr(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 50,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 6, 7, 10))),
                          Text(
                              LocaleKeys.gameResult_completed
                                  .tr(args: [widget.game.answer.title]),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 6, 7, 10))),
                        ],
                      ),
                      ...widget.game.lines.map((line) => LineWidget(
                            disableTooltip: true,
                            line: line,
                            group: AutoSizeGroup(),
                          )),
                      Text(
                        LocaleKeys.gameResult_tries.tr(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      Row(
                        mainAxisSize: MainAxisSize.max,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          (Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                LocaleKeys.gameResult_share.tr(),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: ElevatedButton(
                                  onPressed: () {
                                    setState(() => pressedShare = true);
                                    shareScreenShot(
                                        _screenShotController,
                                        LocaleKeys.gameResult_shareMessage
                                            .tr(args: []));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: const EdgeInsets.all(10),
                                    shape: const CircleBorder(),
                                    elevation: 0,
                                    backgroundColor: Colors.white,
                                  ),
                                  child: const Icon(
                                    Icons.share,
                                    color: Colors.deepOrangeAccent,
                                  ),
                                ),
                              ),
                            ],
                          )),
                        ],
                      )
                    ]),
              ],
            ),
          ),
        ));
  }
}
