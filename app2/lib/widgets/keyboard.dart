import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

const _keys = [
  ["अ", "आ", "इ", "ई", "उ", "ऊ", "ए", "ऐ", "ओ", "औ"],
  ["क", "ख", "ग", "घ", "ङ ", " च", "छ", "ज", "झ", "ञ"],
  ["ट", "ठ", "ड", "ढ", "ण ", " त", "थ", "द", "ध", "न"],
  ["प", "फ", "ब", "भ", "म ", " य", "र", "ल", "व", "श"],
  ["ष", "स", "ह", "क्ष", "त्र", "ज्ञ", "श्र", "ऋ", "अं", "अः", "अँ"],
  ["्", "ा", "ि", "ी", "ु", "ू", "े", "ै", "⌫"],
  ["ो", "ौ", "ृ", "ं", "़", "ः", "ँ", "⏎"]
];
AutoSizeGroup _group = AutoSizeGroup();

class HindiKeyboard extends StatelessWidget {
  const HindiKeyboard(
      {required this.onTap,
      required this.onReturn,
      required this.onBackspace,
      super.key,
      required this.highlights,
      required this.lowlights});
  final Function(String) onTap;
  final Function() onReturn, onBackspace;

  final List<String> highlights;
  final List<String> lowlights;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          for (var row in _keys)
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: row
                  .map<Widget>((e) => _Key(
                        text: e.trim(),
                        leftMargin: e.startsWith(' '),
                        rightMargin: e.endsWith(' '),
                        onTap: (t) {
                          if (t == '⏎') {
                            onReturn();
                          } else if (t == '⌫') {
                            onBackspace();
                          } else {
                            onTap(t);
                          }
                        },
                        highlight: highlights.contains(e.trim()),
                        lowlight: lowlights.contains(e.trim()),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  const _Key(
      {required this.text,
      required this.onTap,
      required this.highlight,
      required this.lowlight,
      required this.rightMargin,
      required this.leftMargin});

  final String text;
  final bool leftMargin, rightMargin;
  final Function(String) onTap;
  final bool highlight;
  final bool lowlight;
  @override
  Widget build(BuildContext context) {
    Color? fillcolor = highlight
        ? const Color.fromRGBO(129, 178, 154, 1)
        : lowlight
            ? const Color.fromRGBO(224, 122, 95, 1)
            : ['⌫', '⏎'].contains(text)
                ? const Color.fromARGB(255, 42, 110, 145).withOpacity(0.8)
                : null;

    Color borderColor = Colors.white24;
    Color separatorColor = Colors.white38;
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(0),
          decoration: BoxDecoration(
              border: Border(
                top: BorderSide(color: borderColor, width: 2),
                bottom: BorderSide(color: borderColor, width: 2),
                left: leftMargin
                    ? BorderSide(color: separatorColor, width: 4)
                    : BorderSide(color: borderColor, width: 2),
                right: rightMargin
                    ? BorderSide(color: separatorColor, width: 4)
                    : BorderSide(color: borderColor, width: 2),
              ),
              color: fillcolor ?? Colors.black12),
          child: TextButton(
            clipBehavior: Clip.antiAlias,
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () => onTap(text),
            child: ['⌫', '⏎'].contains(text)
                ? Icon(text == '⌫' ? Icons.backspace : Icons.keyboard_return,
                    color: Colors.white, size: 28.sp)
                : AutoSizeText(text,
                    group: _group,
                    maxLines: 1,
                    style:
                        const TextStyle(color: Colors.black, fontSize: 10000)),
          ),
        ),
      ),
    );
  }
}
