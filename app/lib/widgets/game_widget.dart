import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/keyboard.dart';
import 'package:paheli/widgets/lines_widget.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';
import 'package:vitality/vitality.dart';

class GameWidget extends StatefulWidget {
  const GameWidget({required this.game, this.footer, super.key, this.header});
  final Game game;
  final Widget? Function(Game)? footer;
  final Widget? Function(Game)? header;

  @override
  State<GameWidget> createState() => _GameWidgetState();
}

class _GameWidgetState extends State<GameWidget> {
  TextEditingController controller = TextEditingController();
  String message = '';
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Vitality.randomly(
            key: ValueKey(widget.game),
            height: size.height,
            width: size.width,
            background: widget.game.answer.backgroundColor,
            maxOpacity: widget.game.answer.maxOpacity, // 0,4
            minOpacity: widget.game.answer.minOpacity, // 0,15
            itemsCount: widget.game.answer.itemsCount, // 6
            enableXMovements: widget.game.answer.moveHorizontal,
            enableYMovements: widget.game.answer.moveVertical,
            whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
            maxSpeed: widget.game.answer.maxSpeed, // 0,4
            maxSize: widget.game.answer.maxSize, // 30
            minSpeed: widget.game.answer.minSpeed, // 0,25
            minSize: widget.game.answer.minSize, // 150
            randomItemsColors: widget.game.answer.colors,
            randomItemsBehaviours: widget.game.answer.icons
                .map((e) => ItemBehaviour(shape: ShapeType.Icon, icon: e))
                .toList(),
          ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  // a bit of space from the top
                  const SizedBox(height: 10),
                  Row(children: [
                    const SizedBox(width: 10),
                    if (widget.header != null)
                      widget.header!(widget.game) ?? Container()
                  ]),
                  const SizedBox(height: 25),
                  Text(LocaleKeys.app_title.tr(),
                      style: const TextStyle(
                          fontSize: 40,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Text(widget.game.answer.title,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  LinesWidget(
                      lines: widget.game.lines, wordLength: widget.game.length),
                  if (!widget.game.complete)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        style: const TextStyle(
                            fontSize: 20, color: Colors.black87),
                        controller: controller,
                        decoration: InputDecoration(
                            fillColor: Colors.black12,
                            labelStyle: const TextStyle(color: Colors.black87),
                            filled: true,
                            enabledBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black38)),
                            border: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black38)),
                            focusedBorder: const OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(color: Colors.black38)),
                            labelText: LocaleKeys.game_answerLabel.tr()),
                        onSubmitted: (value) {
                          setState(() {
                            controller.clear();
                            message = widget.game.addGuess(value.trim());
                          });
                        },
                      ),
                    ),
                  Text(message),
                  if (!widget.game.complete)
                    HindiKeyboard(
                      onTap: (t) => controller.text += t,
                      onReturn: () => setState(() {
                        message = widget.game.addGuess(controller.text.trim());
                        controller.clear();
                      }),
                      onBackspace: () => setState(() => controller.text =
                          controller.text.substring(
                              0, max(0, controller.text.length - 1))),
                      highlights: widget.game.lines
                          .map((line) => line.cells
                              .where((element) => [
                                    CellState.correct,
                                    CellState.correctVyanjan,
                                    CellState.misplaced,
                                    CellState.misplacedVyanjan
                                  ].contains(element.state))
                              .map((e) => e.value.vyanjan))
                          .expand((element) => element)
                          .toList()
                        ..addAll(widget.game.answer.answer.allCharacters
                            .map((e) => e.matra.runes
                                .map((e) => String.fromCharCode(e).matra))
                            .expand((element) => element))
                        ..add(widget.game.answer.answer.allCharacters
                                .map((e) => e.matra)
                                .join()
                                .contains('्')
                            ? '्'
                            : ''),
                      lowlights: widget.game.lines
                          .map((line) => line.cells
                              .where((element) =>
                                  CellState.incorrect == element.state)
                              .map((e) => e.value.vyanjan))
                          .expand((element) => element)
                          .toList(),
                    ),
                  if (widget.footer != null)
                    widget.footer!(widget.game) ?? Container(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
