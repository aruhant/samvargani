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
            gradient: const LinearGradient(colors: [
              Color.fromRGBO(165, 165, 165, 1),
              Color.fromRGBO(245, 245, 245, 1),
            ], begin: Alignment.topLeft, end: Alignment.bottomRight)),
        padding: const EdgeInsets.all(18),
        margin: const EdgeInsets.all(18),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text('आप सफल हुए!',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                    color: Colors.pinkAccent)),
            Text(
              // tell them what the word was and its meaning
              'शब्द: ${gameResult.answer.answer}\nइसका अर्थ है: ${gameResult.answer.meaning}\nआपको जीतने में ${gameResult.tries} शब्द ${gameResult.tries == 1 ? 'लगा।' : 'लगे।'}',
              style: const TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.close, size: 50))
          ],
        ),
      ),
    );
  }
}
