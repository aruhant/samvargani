import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/utils/share.dart';
import 'line_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:screenshot/screenshot.dart';

class ResultWidget extends StatefulWidget {
  const ResultWidget({required this.gameResult, super.key});
  final GameResult gameResult;

  @override
  State<ResultWidget> createState() => _ResultWidgetState();
}

class _ResultWidgetState extends State<ResultWidget> {
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
                    color: widget.gameResult.win
                        ? const Color.fromRGBO(255, 181, 70, 1)
                        : const Color.fromARGB(255, 231, 255, 229),
                    width: 5),
                gradient: LinearGradient(
                    colors: widget.gameResult.win
                        ? const [
                            Color.fromRGBO(162, 79, 1, 1),
                            Color.fromRGBO(230, 154, 39, 1),
                            Color.fromRGBO(229, 130, 0, 1),
                          ]
                        : const [
                            Color.fromRGBO(130, 154, 39, 1),
                            Color.fromRGBO(198, 198, 107, 1),
                            Color.fromRGBO(62, 179, 1, 1),
                          ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight)),
            padding: const EdgeInsets.all(18).w,
            margin: const EdgeInsets.all(18).w,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(12.0).w,
                  child: Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                      icon: Icon(Icons.close, size: 24.sp),
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
                          Icon(
                              (widget.gameResult.win
                                  ? Icons.emoji_events_outlined
                                  : Icons.sentiment_dissatisfied_outlined),
                              size: 140.sp,
                              color: const Color.fromARGB(255, 6, 7, 10)),
                          Text(
                              widget.gameResult.win
                                  ? LocaleKeys.gameResult_victoryMessage.tr()
                                  : LocaleKeys.gameResult_defeatMessage.tr(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 50.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 6, 7, 10))),
                          Text(
                              LocaleKeys.gameResult_completed
                                  .tr(args: [widget.gameResult.answer.title]),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: const Color.fromARGB(255, 6, 7, 10))),
                        ],
                      ),
                      pressedShare
                          ? LineWidget(
                              disableTooltip: true,
                              line: widget.gameResult.lines.last,
                              group: AutoSizeGroup(),
                            )
                          : (Column(
                              children: [
                                Text(
                                  widget.gameResult.answer.answer,
                                  style: TextStyle(
                                    fontSize: 40.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                                Text(
                                  LocaleKeys.gameResult_meaning.tr(
                                      args: [widget.gameResult.answer.meaning]),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 30.sp,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            )),
                      Text(
                        LocaleKeys.gameResult_tries
                            .tr(args: [widget.gameResult.tries.toString()]),
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      widget.gameResult.win
                          ? Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                (Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      LocaleKeys.gameResult_share.tr(),
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 20.sp,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(5.0).w,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          setState(() => pressedShare = true);
                                          shareScreenShot(
                                              _screenShotController,
                                              LocaleKeys.gameResult_shareMessage
                                                  .tr(args: [
                                                widget.gameResult.answer.title,
                                                widget.gameResult.tries
                                                    .toString()
                                              ]),
                                              context);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.all(10).w,
                                          shape: const CircleBorder(),
                                          elevation: 0,
                                          backgroundColor: Colors.white,
                                        ),
                                        child: Icon(
                                          Icons.share,
                                          size: 30.sp,
                                          color: Colors.deepOrangeAccent,
                                        ),
                                      ),
                                    ),
                                  ],
                                )),
                              ],
                            )
                          : const Row(),
                    ]),
              ],
            ),
          ),
        ));
  }
}
