import 'dart:math';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/game.dart';
import 'package:paheli/models/user_properties.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:paheli/utils/notifications.dart';
import 'package:paheli/utils/string.dart';
import 'package:paheli/widgets/keyboard.dart';
import 'package:paheli/widgets/lines_widget.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';
import 'package:vitality/vitality.dart';
import 'dart:ui' as ui;

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
  List hintIcons = [];
  @override
  void initState() {
    super.initState();
    message = '';
    widget.game.answer.hintIcons
        .then((value) => setState(() => hintIcons = value));
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(GameWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.game != widget.game) {
      controller.clear();
      message = '';
      widget.game.answer.hintIcons
          .then((value) => setState(() => hintIcons = value));

      if (!widget.game.complete) {
        if (widget.game.answer.answer.contains('त्र') ||
            widget.game.answer.answer.contains('ज्ञ') ||
            widget.game.answer.answer.contains('श्र') ||
            widget.game.answer.answer.contains('क्ष')) {
          if (UserProperties.instance.runCount < 25) {
            message =
                LocaleKeys.game_gameMessages_startingMessages_containsTra.tr();
          }
        } else {
          if (widget.game.answer.answer.contains('्')) {
            if (UserProperties.instance.runCount < 20) {
              message = LocaleKeys
                  .game_gameMessages_startingMessages_containsAdha
                  .tr();
            }
          }
        }
        if (UserProperties.instance.runCount < 8 &&
            UserProperties.instance.tutorialIndex > 2) {
          message =
              LocaleKeys.game_gameMessages_startingMessages_basicMessage.tr();
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //print('valueKey: $valueKey, shouldShowHint: $shouldShowHint, hintIcons.isEmpty: ${hintIcons.isEmpty}');
    return Scaffold(
      backgroundColor: defaultGameColor,
      body: Stack(
        children: [
          if (shouldShowHint && hintIcons.isNotEmpty)
            Vitality.randomly(
              key: valueKey,
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
              randomItemsBehaviours: hintIcons
                  .map((e) => e is IconData
                      ? ItemBehaviour(shape: ShapeType.Icon, icon: e)
                      : (e is ui.Image)
                          ? ItemBehaviour(shape: ShapeType.Image, image: e)
                          : ItemBehaviour(shape: ShapeType.FilledCircle))
                  .toList()
                  .cast<ItemBehaviour>(),
            ),
          SingleChildScrollView(
            child: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10),
                  if (widget.header != null)
                    widget.header!(widget.game) ?? Container(),
                  const SizedBox(height: 25),
                  Text(LocaleKeys.app_title.tr(),
                      style: TextStyle(
                          fontSize: 40.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  Text(widget.game.answer.title.tr(),
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontSize: 18.sp,
                          color: Colors.black54,
                          fontWeight: FontWeight.bold)),
                  if (widget.game.answer.difficulty != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Column(
                        children: [
                          // Visual difficulty indicator
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: List.generate(3, (index) {
                              int starCount = widget.game.answer.difficulty!.clamp(1, 3);
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 2),
                                child: index < starCount
                                    ?  Icon(
                                      Icons.star,
                                      size: 20,
                                      color: Colors.black45
                                    ) 
                                    : const Icon(
                                        Icons.star_outline,
                                        size: 20,
                                        color: Colors.black38,
                                      ),
                              );
                            }),
                          ),
                          // const SizedBox(height: 4),
                          // // Difficulty text - commented out as requested
                          // Text(
                          //   switch (widget.game.answer.difficulty!) {
                          //     1 => LocaleKeys.game_difficulty_easy.tr(),
                          //     3 => LocaleKeys.game_difficulty_medium.tr(),
                          //     5 => LocaleKeys.game_difficulty_difficult.tr(),
                          //     _ => 'Level ${widget.game.answer.difficulty}',
                          //   },
                          //   style: TextStyle(
                          //     fontSize: 15.sp,
                          //     color: switch (widget.game.answer.difficulty!) {
                          //       1 => const Color.fromARGB(255, 36, 105, 38),
                          //       3 => const Color.fromARGB(255, 172, 117, 34),
                          //       5 => const Color.fromARGB(255, 110, 49, 39),
                          //       _ => const Color.fromARGB(255, 172, 117, 34),
                          //     },
                          //     fontWeight: FontWeight.w600,
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  LinesWidget(
                      lines: widget.game.lines, wordLength: widget.game.length),

                  if (!widget.game.complete)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      child: TextField(
                        style: const TextStyle(
                          fontSize: 20,
                          color: Colors.black87,
                        ),
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
                        onSubmitted: submit,
                      ),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: (message.isNotEmpty)
                        ? Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(message,
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black)),
                          )
                        : Container(),
                  ),
                  if (!widget.game.complete)
                    HindiKeyboard(
                      onTap: (t) => controller.text += t,
                      onReturn: () => submit(controller.text.trim()),
                      onBackspace: onBackspace,
                      highlights: widget.game.lines
                          .map((line) => line.cells
                              .where((element) => [
                                    CellState.correct,
                                    CellState.misplaced,
                                    CellState.correctVyanjanWithAdhaRemoveAdha,
                                    CellState.correctVyanjanWithAdhaAddMatra,
                                    CellState
                                        .correctVyanjanWithMatraRemoveMatra,
                                    CellState.correctVyanjanWithMatraAddAdha,
                                    CellState
                                        .correctVyanjanWithMatraAndAdhaRemoveMatraAndAdha,
                                    CellState
                                        .correctVyanjanWithMatraAndAdhaRemoveMatra,
                                    CellState
                                        .correctVyanjanWithMatraAndAdhaRemoveAdha,
                                    CellState
                                        .correctVyanjanWithoutMatraAndAdhaAddMatra,
                                    CellState
                                        .correctVyanjanWithoutMatraAndAdhaAddAdha,
                                    CellState
                                        .correctVyanjanWithoutMatraAndAdhaAddMatraAndAdha,
                                    CellState
                                        .misplacedVyanjanWithAdhaRemoveAdha,
                                    CellState.misplacedVyanjanWithAdhaAddMatra,
                                    CellState
                                        .misplacedVyanjanWithMatraRemoveMatra,
                                    CellState.misplacedVyanjanWithMatraAddAdha,
                                    CellState
                                        .misplacedVyanjanWithMatraAndAdhaRemoveMatraAndAdha,
                                    CellState
                                        .misplacedVyanjanWithMatraAndAdhaRemoveMatra,
                                    CellState
                                        .misplacedVyanjanWithMatraAndAdhaRemoveAdha,
                                    CellState
                                        .misplacedVyanjanWithoutMatraAndAdhaAddMatra,
                                    CellState
                                        .misplacedVyanjanWithoutMatraAndAdhaAddAdha,
                                    CellState
                                        .misplacedVyanjanWithoutMatraAndAdhaAddMatraAndAdha,
                                  ].contains(element.state))
                              .map((e) => e.value.vyanjan))
                          .expand((element) => element)
                          .toList()
                        ..addAll(widget.game.name.characters.toList()
                            .map((e) => e.allModifiers.runes
                                .map((e) => String.fromCharCode(e).allModifiers))
                            .expand((element) => element))
                        ..add(widget.game.name.characters.toList()
                                .map((e) => e.allModifiers)
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

  bool get shouldShowHint {
    //print('tries: ${widget.game.tries}, whenToShowIcons: ${widget.game.answer.whenToShowIcons}, complete: ${widget.game.complete}, runCount: ${UserPrefs.instance.runCount}');
    return (widget.game.tries > widget.game.answer.whenToShowIcons ||
        widget.game.complete ||
        UserProperties.instance.runCount < 5);
  }

  ValueKey<String> get valueKey {
    return ValueKey(widget.game.answer.answer +
        hintIcons.toString() +
        widget.game.complete.toString() +
        (widget.game.tries > widget.game.answer.whenToShowIcons).toString() +
        widget.game.answer.backgroundColor.toString() +
        widget.game.answer.maxOpacity.toString() +
        widget.game.answer.minOpacity.toString() +
        widget.game.answer.itemsCount.toString() +
        widget.game.answer.moveHorizontal.toString() +
        widget.game.answer.moveVertical.toString() +
        widget.game.answer.maxSpeed.toString() +
        widget.game.answer.maxSize.toString() +
        widget.game.answer.minSpeed.toString() +
        widget.game.answer.minSize.toString() +
        widget.game.answer.colors.toString() +
        widget.game.answer.whenToShowIcons.toString() +
        widget.game.answer.title.toString());
  }



  void onBackspace() {
    return setState(() => controller.text = controller.text != '' &&
            (controller.text.characters.toList().last == 'क्ष' ||
                controller.text.characters.toList().last == 'त्र' ||
                controller.text.characters.toList().last == 'ज्ञ' ||
                controller.text.characters.toList().last == 'श्र')
        ? controller.text.substring(0, max(0, controller.text.length - 3))
        : controller.text.substring(0, max(0, controller.text.length - 1)));
  }

  void submit(value) {
    if (value.trim().toLowerCase() == 'notify') {
      testnotification().then((value) => setState(() {
            message = value;
            controller.clear();
          }));
    }
    String msg = widget.game.addGuess(value.trim());
    setState(() {
      controller.clear();
      message = msg;
    });
  }
}
