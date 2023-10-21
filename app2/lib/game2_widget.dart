import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:hindi/models/matrix.dart';
import 'package:hindi/utils/logging.dart';

const GRID_SIZE = 100;

class Game2Widget extends StatefulWidget {
  const Game2Widget({super.key, required this.matrices});
  final WordMatrices matrices;
  @override
  State<Game2Widget> createState() => Game2WidgetState();
}

class Game2WidgetState extends State<Game2Widget> {
  @override
  Widget build(BuildContext context) => MaterialApp(
        home: Scaffold(
          body: LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        InteractiveViewer(
                          constrained: false,
                          minScale: 0.01,
                          child: GridPaper(
                            interval: GRID_SIZE.toDouble(),
                            divisions: 1,
                            subdivisions: 1,
                            color: Colors.red,
                            child: SizedBox(
                              width: 40.0 * GRID_SIZE,
                              height: 40.0 * GRID_SIZE,
                              child: Stack(
                                children: widget.matrices.matrices
                                    .map((e) => makeWidget(e))
                                    .toList(),
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          left: 0,
                          top: 0,
                          child: MaterialButton(
                              onPressed: () {
                                widget.matrices.merge(
                                    widget.matrices.matrices[0],
                                    widget.matrices.matrices[1]);
                              },
                              child: Text('Test')),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );

  Widget makeWidget(WordMatrix e) {
    return Positioned(
      top: e.rect.top * GRID_SIZE.toDouble(),
      left: e.rect.left * GRID_SIZE.toDouble(),
      child: MatrixWidget(
        matrix: e,
        getSnapPosition: () {
          return e.getSnapPosition(widget.matrices.matrices);
        },
        onOffsetChange: (offset) => setState(() => e.offset = offset),
      ),
    );
  }
}

class MatrixWidget extends StatefulWidget {
  const MatrixWidget(
      {super.key,
      required this.matrix,
      required this.getSnapPosition,
      required this.onOffsetChange});
  final WordMatrix matrix;
  final Function(Offset) onOffsetChange;
  final Offset Function() getSnapPosition;
  @override
  State<MatrixWidget> createState() => MatrixWidgetState();
}

class MatrixWidgetState extends State<MatrixWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanEnd: (details) {
        final Offset offset = widget.getSnapPosition();
        setState(() => widget.onOffsetChange(offset));
      },
      onPanUpdate: (details) {
        setState(() {
          final offset = Offset(
              widget.matrix.rect.left + details.delta.dx / GRID_SIZE,
              widget.matrix.rect.top + details.delta.dy / GRID_SIZE);
          widget.onOffsetChange(offset);
        });
      },
      child: Container(
        width: widget.matrix.rect.width * GRID_SIZE.toDouble(),
        height: widget.matrix.rect.height * GRID_SIZE.toDouble(),
        child: Stack(
          children: widget.matrix.map.entries
              .map((e) => Positioned(
                    top: e.key.$2 * GRID_SIZE.toDouble(),
                    left: e.key.$1 * GRID_SIZE.toDouble(),
                    child: Container(
                        height: GRID_SIZE.toDouble(),
                        width: GRID_SIZE.toDouble(),
                        color: Colors.black38,
                        alignment: Alignment.center,
                        child: AutoSizeText(
                          e.value,
                          maxLines: 1,
                          style: const TextStyle(
                              fontSize: 100, color: Colors.black87),
                        )),
                  ))
              .toList(),
        ),
      ),
    );
  }
}
