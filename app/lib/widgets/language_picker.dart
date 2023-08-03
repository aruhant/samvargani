import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key, required this.onLocaleSelected})
      : super(key: key);
  final VoidCallback onLocaleSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // set backgroundColor to pink
      backgroundColor: const Color.fromARGB(255, 245, 194, 235),
      appBar: AppBar(
        title: const Text('Select Language/भाषा चुनें'),
        backgroundColor: const Color.fromARGB(255, 245, 194, 235),
        // allign
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('en', 'US'));
                onLocaleSelected();
              },
              child: const Text('English'),
            ),
            ElevatedButton(
              onPressed: () {
                context.setLocale(const Locale('hi', 'IN'));
                onLocaleSelected();
              },
              child: const Text('हिंदी'),
            ),
          ],
        ),
      ),
    );
  }
}
