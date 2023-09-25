import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';
import 'package:vitality/vitality.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class YesterdayWord extends StatefulWidget {
  GameAnswer answer;
  YesterdayWord({super.key, required this.answer});

  @override
  State<YesterdayWord> createState() => _YesterdayWordState();
}

class _YesterdayWordState extends State<YesterdayWord> {
  List hintIcons = [];

  @override
  void initState() {
    super.initState();
    widget.answer.hintIcons
        .then((value) => mounted ? setState(() => hintIcons = value) : null);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: widget.answer.backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Vitality.randomly(
              key: ValueKey(widget.answer.answer + hintIcons.toString()),
              background: widget.answer.backgroundColor,
              maxOpacity: widget.answer.maxOpacity, // 0,4
              minOpacity: widget.answer.minOpacity, // 0,15
              itemsCount: 10, // 6
              enableXMovements: widget.answer.moveHorizontal,
              enableYMovements: widget.answer.moveVertical,
              whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
              maxSpeed: widget.answer.maxSpeed, // 0,4
              maxSize: widget.answer.maxSize, // 30
              minSpeed: widget.answer.minSpeed, // 0,25
              minSize: widget.answer.minSize, // 150
              randomItemsColors: widget.answer.colors,
              randomItemsBehaviours: hintIcons.isEmpty
                  ? [ItemBehaviour(shape: ShapeType.Icon)]
                  : hintIcons
                      .map((e) => e is IconData
                          ? ItemBehaviour(shape: ShapeType.Icon, icon: e)
                          : (e is ui.Image)
                              ? ItemBehaviour(shape: ShapeType.Image, image: e)
                              : ItemBehaviour(shape: ShapeType.FilledCircle))
                      .toList()
                      .cast<ItemBehaviour>()),
          Padding(
            padding: const EdgeInsets.all(12.0).w,
            child: Align(
              alignment: Alignment.topRight,
              child: IconButton(
                icon: Icon(Icons.close, size: 24.sp),
                color: Colors.black,
                onPressed: () async {
                  Navigator.of(context).pop();
                },
              ),
            ),
          ),
          FittedBox(
            fit: BoxFit.fill,
            alignment: Alignment.center,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                mainAxisSize: MainAxisSize.max,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 10.h),
                  Text(widget.answer.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 6, 7, 10))),
                  SizedBox(height: 10.h),
                  (Column(
                    children: [
                      Text(
                        widget.answer.answer,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocaleKeys.yesterday_meaning
                            .tr(args: [widget.answer.meaning]),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 30.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ))
                ]),
          ),
        ],
      ),
    );
  }
}
