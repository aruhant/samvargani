import 'dart:async';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/translations/locale_keys.g.dart';

class Loading extends StatefulWidget {
  @override
  State<Loading> createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  bool showAdditionalMessage = false;

  @override
  void initState() {
    super.initState();
    // Start a timer after 10 seconds to show the additional message
    Timer(const Duration(seconds: 10), () {
      if (mounted) {
        setState(() {
          showAdditionalMessage = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: const Color.fromARGB(255, 226, 149, 174),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          if (!showAdditionalMessage)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(LocaleKeys.dailyGame_loading.tr()),
            ),
          if (showAdditionalMessage)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text('Additional message after 10 seconds'),
            ),
          const CircularProgressIndicator(),
        ],
      ),
    );
  }
}
