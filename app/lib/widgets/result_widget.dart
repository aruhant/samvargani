import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({required this.gameResult, super.key});
  final GameResult gameResult;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border:
                Border.all(color: Color.fromARGB(255, 246, 107, 0), width: 5),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(230, 154, 39, 1),
              Color.fromRGBO(229, 130, 0, 1),
              Color.fromRGBO(162, 79, 1, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                const Icon(Icons.emoji_events_outlined,
                    size: 240, color: Color.fromARGB(255, 6, 7, 10)),
                Text(LocaleKeys.gameResult_victoryMessage.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 100,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 7, 10))),
              ],
            ),

            Column(
              children: [
                Text(
                  gameResult.answer.answer,
                  style: const TextStyle(
                    fontSize: 80,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  LocaleKeys.gameResult_meaning
                      .tr(args: [gameResult.answer.meaning]),
                  style: const TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
            Text(
              LocaleKeys.gameResult_tries
                  .tr(args: [gameResult.tries.toString()]),
              style: const TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            // TextButton(
            //     onPressed: () {
            //       Navigator.pop(context);
            //     },
            //     child: const Icon(
            //       Icons.close,
            //       size: 50,
            //       color: Color.fromARGB(255, 6, 7, 10),
            //     ))
          ],
        ),
      ),
    );
  }
}
