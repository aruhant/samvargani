import 'package:flutter/material.dart';
import 'package:custom_sliding_segmented_control/custom_sliding_segmented_control.dart';
import 'package:paheli/widgets/daily_game.dart';
import 'package:paheli/widgets/game_intro.dart';
import 'package:paheli/widgets/practice_game.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int? _currentSelection = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: CustomSlidingSegmentedControl<int>(
            fromMax: true,
            children: const {
              1: Text(
                'Practice',
                textAlign: TextAlign.center,
              ),
              2: Text(
                'Daily Challange',
                textAlign: TextAlign.center,
              ),
              3: Text(
                'Help',
                textAlign: TextAlign.center,
              ),
            },
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(12),
            ),
            thumbDecoration: BoxDecoration(
              color: Colors.greenAccent,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(.3),
                  blurRadius: 4.0,
                  spreadRadius: 1.0,
                  offset: const Offset(
                    0.0,
                    2.0,
                  ),
                ),
              ],
            ),
            onValueChanged: onValueChanged,
          )),
      body: _currentSelection == 1
          ? const PracticeGame()
          : _currentSelection == 2
              ? const DailyGame()
              : GameHelpWidget(onIntroEnd: () {}),
    );
  }

  void onValueChanged(int? newValue) {
    setState(() {
      _currentSelection = newValue;
    });
  }
}
