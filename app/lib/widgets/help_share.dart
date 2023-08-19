import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'line_widget.dart';

class HelpShareWidget extends StatefulWidget {
  const HelpShareWidget(this.game, {super.key});
  final Game game;

  @override
  State<HelpShareWidget> createState() => _HelpShareWidgetState();
}

class _HelpShareWidgetState extends State<HelpShareWidget> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
                color: const Color.fromARGB(255, 231, 255, 229), width: 5),
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(255, 239, 224, 1),
              Color.fromRGBO(245, 221, 187, 1),
              Color.fromRGBO(252, 242, 229, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Stack(
          children: [
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Text(LocaleKeys.shareHelp_title.tr(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                              fontSize: 50,
                              fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 6, 7, 10))),
                    ],
                  ),
                  ...widget.game.lines.map((line) => LineWidget(
                        disableTooltip: true,
                        line: line,
                        group: AutoSizeGroup(),
                      )),
                ]),
          ],
        ),
      ),
    );
  }
}
