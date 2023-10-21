import 'package:flutter/material.dart';

class WordMatrix {
  WordMatrix({required List<(int, int, String)> values, required Offset offset})
      : map = Map<(int, int), String>.fromEntries(
            values.map(((int, int, String) e) => MapEntry((e.$1, e.$2), e.$3))),
        rect = Rect.fromLTWH(
            offset.dx,
            offset.dy,
            1.0 +
                values.map((e) => e.$1).reduce(
                    (value, element) => value > element ? value : element),
            1.0 +
                values.map((e) => e.$2).reduce(
                    (value, element) => value > element ? value : element));

  final Map<(int, int), String> map;
  Rect rect;
  set offset(Offset offset) =>
      rect = Rect.fromLTWH(offset.dx, offset.dy, rect.width, rect.height);
  bool collidesWith(WordMatrix other) {
    for (final entry in map.entries) {
      if (other.map.containsKey(entry.key)) {
        return true;
      }
    }
    return false;
  }
}
