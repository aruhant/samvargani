import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

const _keys = [
  ["क", "ख", "ग", "घ", "ङ"],
  ["च", "छ", "ज", "झ", "ञ"],
  ["ट", "ठ", "ड", "ढ", "ण"],
  ["त", "थ", "द", "ध", "न"],
  ["प", "फ", "ब", "भ", "म"],
  ["य", "र", "ल", "व", "श"],
  ["ष", "स", "ह"]
];

class HindiKeyboard extends StatelessWidget {
  const HindiKeyboard(
      {required this.onTap, super.key, required this.highlights});
  final Function(String) onTap;
  final List<String> highlights;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black12,
      padding: const EdgeInsets.all(30),
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
                        onTap: onTap,
                        highlight: highlights.contains(e),
                      ))
                  .toList(),
            ),
        ],
      ),
    );
  }
}

class _Key extends StatelessWidget {
  _Key({required this.text, required this.onTap, required this.highlight});
  final String text;
  final Function(String) onTap;
  final bool highlight;
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AspectRatio(
        aspectRatio: 1,
        child: Container(
          padding: const EdgeInsets.all(1),
          margin: const EdgeInsets.all(2),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: highlight ? Colors.green : Colors.black12),
          child: TextButton(
            onPressed: () => onTap(text),
            child: AutoSizeText(text,
                maxLines: 1,
                style: const TextStyle(
                    color: Color.fromRGBO(61, 64, 91, 1), fontSize: 10000)),
          ),
        ),
      ),
    );
  }
}
