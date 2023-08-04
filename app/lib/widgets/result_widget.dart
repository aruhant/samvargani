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
            border: Border.all(
                color: gameResult.win
                    ? const Color.fromRGBO(255, 181, 70, 1)
                    : const Color.fromARGB(255, 231, 255, 229),
                width: 5),
            gradient: LinearGradient(
                colors: gameResult.win
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
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Icon(
                    (gameResult.win
                        ? Icons.emoji_events_outlined
                        : Icons.sentiment_dissatisfied_outlined),
                    size: 140,
                    color: const Color.fromARGB(255, 6, 7, 10)),
                Text(
                    gameResult.win
                        ? LocaleKeys.gameResult_victoryMessage.tr()
                        : LocaleKeys.gameResult_defeatMessage.tr(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 6, 7, 10))),
              ],
            ),
            Column(
              children: [
                Text(
                  gameResult.answer.answer,
                  style: const TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  LocaleKeys.gameResult_meaning
                      .tr(args: [gameResult.answer.meaning]),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 30,
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
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.close,
                  size: 30,
                  color: Color.fromARGB(255, 6, 7, 10),
                ))
          ],
        ),
      ),
    );
  }
}
