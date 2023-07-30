import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const _keys = [
  ["अ", "आ", "इ", "ई", "उ", "ऊ", "ए", "ऐ", "ओ", "औ"],
  ["क", "ख", "ग", "घ", "ङ", "च", "छ", "ज", "झ", "ञ"],
  ["ट", "ठ", "ड", "ढ", "ण", "त", "थ", "द", "ध", "न"],
  ["प", "फ", "ब", "भ", "म", "य", "र", "ल", "व", "श"],
  ["ष", "स", "ह", "क्ष", "त्र", "ज्ञ", "ऋ", /*"ॠ",*/ "अं", "अः", "अँ"],
  ["क़", "ख़", "ग़", "ज़", "ड़", "ढ़", "फ़", "य़"],
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
                        text: e,
                        onTap: (t) {
                          if (t == '⏎') {
                            onReturn();
                          } else if (t == '⌫') {
                            onBackspace();
                          } else {
                            onTap(t);
                          }
                        },
                        highlight: highlights.contains(e),
                        lowlight: lowlights.contains(e),
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
      required this.lowlight});
  final String text;
  final Function(String) onTap;
  final bool highlight;
  final bool lowlight;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(0),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(2),
              color: highlight
                  ? const Color.fromRGBO(129, 178, 154, 1)
                  : lowlight
                      ? const Color.fromRGBO(224, 122, 95, 1)
                      : ['⌫', '⏎'].contains(text)
                          ? Colors.black38
                          : Colors.black12),
          child: TextButton(
            clipBehavior: Clip.antiAlias,
            // style with no padding
            style: ButtonStyle(
                padding: MaterialStateProperty.all(EdgeInsets.zero)),
            onPressed: () => onTap(text),
            child: AutoSizeText(text,
                group: _group,
                maxLines: 1,
                style: const TextStyle(
                    color: Color.fromRGBO(61, 64, 91, 1), fontSize: 10000)),
          ),
        ),
      ),
    );
  }
}
