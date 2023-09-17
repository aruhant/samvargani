import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:paheli/models/cell.dart';
import 'package:paheli/models/user_prefs.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class CellWidget extends StatelessWidget {
  const CellWidget(
      {required this.cell,
      super.key,
      required this.group,
      this.disableTooltip = false});
  final AutoSizeGroup group;
  final Cell cell;
  final bool disableTooltip;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: disableTooltip
          ? makeCellContents()
          : Tooltip(
              waitDuration: disableTooltip ? const Duration(hours: 1) : null,
              showDuration: const Duration(seconds: 12),
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black87,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 10,
                        offset: const Offset(0, 5))
                  ]),
              triggerMode: disableTooltip
                  ? TooltipTriggerMode.manual
                  : TooltipTriggerMode.tap,
              textStyle: TextStyle(color: Colors.white, fontSize: 15.sp),
              message: cell.state.tooltip(cell.value),
              onTriggered: () {
                UserPrefs.instance.onTooltipPressed();
                FirebaseAnalytics.instance.setUserProperty(
                    name: 'tooltipsPressed',
                    value: UserPrefs.instance.tooltipsPressed.toString());
              },
              child: makeCellContents(),
            ),
    );
  }

  Container makeCellContents() {
    return Container(
        padding: EdgeInsets.all(2.w),
        margin: EdgeInsets.all(1.w),
        height: 50.w,
        width: 50.w,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: cell.state.color),
        child: Center(
            child: AutoSizeText(cell.value,
                group: group,
                maxLines: 1,
                maxFontSize: 10000,
                minFontSize: 1,
                style: const TextStyle(
                    color: Color.fromRGBO(61, 64, 91, 1), fontSize: 10000))));
  }
}
