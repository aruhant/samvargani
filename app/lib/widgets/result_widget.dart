import 'package:flutter/material.dart';
import 'package:paheli/models/game.dart';

class ResultWidget extends StatelessWidget {
  const ResultWidget({required this.gameResult, super.key});
  final GameResult gameResult;
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black12,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            gradient: const LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurpleAccent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('आप सफल हैं!',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(
                'आपको जीतने में ${gameResult.tries} शब्द ${gameResult.tries == 1 ? 'लगा।' : 'लगे।'}'),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('OK'))
          ],
        ),
      ),
    );
  }
}
