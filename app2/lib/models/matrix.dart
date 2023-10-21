import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hindi/utils/logging.dart';

class WordMatrices {
  static const Rect bounds = Rect.fromLTWH(0, 0, 40.0, 40.0);
  List<WordMatrix> matrices = [];
  WordMatrices({required this.matrices});
  void merge(WordMatrix first, WordMatrix second) {
    matrices.remove(first);
    matrices.remove(second);
    Offset newOffset = Offset(min(first.rect.left, second.rect.left),
        min(first.rect.top, second.rect.top));
    Offset newAnswer = Offset(newOffset.dx - first.rect.left + first.answer.dx,
        newOffset.dy - first.rect.top + first.answer.dy);
    matrices.add(WordMatrix.fromValues(values: [
      ...first.map.entries.map((e) => ((
            e.key.$1 + first.rect.left.round() - newOffset.dx.round(),
            e.key.$2 + first.rect.top.round() - newOffset.dy.round(),
            e.value
          ))),
      ...second.map.entries.map((e) => ((
            e.key.$1 + second.rect.left.round() - newOffset.dx.round(),
            e.key.$2 + second.rect.top.round() - newOffset.dy.round(),
            e.value
          ))),
    ], partOf: first.partOf, answer: newAnswer, offset: newOffset));
  }

  void moveMatrixTo(WordMatrix matrix, Offset offset) {
    matrices.remove(matrix);
    matrices.add(matrix.copyWithOffset(offset));
  }

  void checkMerges() {
    for (int i = 0; i < matrices.length; i++) {
      for (int j = i + 1; j < matrices.length; j++) {
        if ((matrices[i].rect.topLeft - matrices[i].answer) ==
            (matrices[j].rect.topLeft - matrices[j].answer)) {
          Log.d('merging $i and $j');
          merge(matrices[i], matrices[j]);
          return;
        }
      }
    }
  }
}

class WordMatrix {
  WordMatrix(
      {required this.map,
      required this.rect,
      required this.answer,
      required this.partOf});
  set offset(Offset offset) =>
      rect = Rect.fromLTWH(offset.dx, offset.dy, rect.width, rect.height);
  WordMatrix.fromValues(
      {required List<(int, int, String)> values,
      required Offset offset,
      required this.partOf,
      required this.answer})
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
  WordMatrix copyWithOffset(Offset offset) {
    return WordMatrix(
        map: map,
        answer: answer,
        partOf: partOf,
        rect: Rect.fromLTWH(offset.dx, offset.dy, rect.width, rect.height));
  }

  final Map<(int, int), String> map;
  Rect rect;
  final Offset answer;
  final WordMatrices partOf;
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

  Offset getSnapPosition() {
    var offset = Offset(
        max(0, min(WordMatrices.bounds.width, rect.left.roundToDouble())),
        max(0, min(WordMatrices.bounds.height, rect.top.roundToDouble())));
    Log.w('snap position for $offset');
    int x = 0;
    int y = 0;
    int dx = 0;
    int dy = -1;
    int maxI = (WordMatrices.bounds.width * WordMatrices.bounds.width).round();
    for (int i = 0; i < maxI; i++) {
      if ((-WordMatrices.bounds.width / 2 <= x &&
              x <= WordMatrices.bounds.width / 2) &&
          (-WordMatrices.bounds.height / 2 <= y &&
              y <= WordMatrices.bounds.height / 2)) {
        Offset o = Offset(offset.dx + x, offset.dy + y);
        Log.d(' $o');
        if (WordMatrices.bounds.contains(o) &&
            WordMatrices.bounds
                .contains(Offset(o.dx + rect.width, o.dy + rect.height)) &&
            o.dx > 0 &&
            o.dy > 0) {
          Log.d('checking : $o');
          if (!(partOf.matrices.any((e) => collidesWith(e, o)))) return o;
        }
      }
      if (x == y || (x < 0 && x == -y) || (x > 0 && x == 1 - y)) {
        int temp = dx;
        dx = -dy;
        dy = temp;
      }
      x += dx;
      y += dy;
    }
    Log.e('No snap position found for $offset');

    return offset;
  }
}
