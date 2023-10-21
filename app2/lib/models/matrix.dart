import 'package:flutter/material.dart';
import 'package:hindi/utils/logging.dart';

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
  bool collidesWith(WordMatrix other, Offset offset) {
    if (other == this) return false;
    for (final entry in map.entries) {
      if (other.map.containsKey((
        entry.key.$1 + offset.dx.round() - other.rect.left.round(),
        entry.key.$2 + offset.dy.round() - other.rect.top.round(),
      ))) {
        return true;
      }
    }
     return false;
  }

  Offset getSnapPosition(List<WordMatrix> matrices) {
    final x = rect.left.roundToDouble();
    final y = rect.top.roundToDouble();
    var offset = Offset(x, y);
    int i = 0;
    while (i < 100) {
      for (int s = -1; s <= 1; s += 2) {
        Offset o = Offset(offset.dx + (s * i), offset.dy);
        if (!(matrices.any((e) => collidesWith(e, o)))) return o;

        o = Offset(offset.dx, offset.dy + (s * i));
        if (!(matrices.any((e) => collidesWith(e, o)))) return o;
        o = Offset(offset.dx + s * i ~/ 2, offset.dy + s * i ~/ 2);
        if (!(matrices.any((e) => collidesWith(e, o)))) return o;
      }
      i++;
    }

    return offset;
  }
}
