import 'package:flutter/material.dart';
import 'package:paheli/models/answer.dart';
import 'package:paheli/translations/locale_keys.g.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vitality/models/ItemBehaviour.dart';
import 'package:vitality/models/WhenOutOfScreenMode.dart';
import 'package:vitality/vitality.dart';

class YesterdayWord extends StatelessWidget {
  GameAnswer answer;
  YesterdayWord({super.key, required this.answer});
  @override
  Widget build(BuildContext context) {
    return Material(
      color: answer.backgroundColor,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Vitality.randomly(
              background: answer.backgroundColor,
              maxOpacity: answer.maxOpacity, // 0,4
              minOpacity: answer.minOpacity, // 0,15
              itemsCount: 10, // 6
              enableXMovements: answer.moveHorizontal,
              enableYMovements: answer.moveVertical,
              whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
              maxSpeed: answer.maxSpeed, // 0,4
              maxSize: answer.maxSize, // 30
              minSpeed: answer.minSpeed, // 0,25
              minSize: answer.minSize, // 150
              randomItemsColors: answer.colors,
              randomItemsBehaviours: answer.hintIcons
                  .map((e) => e is IconData
                      ? ItemBehaviour(shape: ShapeType.Icon, icon: e)
                      : ItemBehaviour(shape: ShapeType.FilledTriangle))
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
                  Text(answer.title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: const Color.fromARGB(255, 6, 7, 10))),
                  SizedBox(height: 10.h),
                  (Column(
                    children: [
                      Text(
                        answer.answer,
                        style: TextStyle(
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        LocaleKeys.yesterday_meaning.tr(args: [answer.meaning]),
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
