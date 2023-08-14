import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key, required this.onLocaleSelected})
      : super(key: key);
  final VoidCallback onLocaleSelected;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 241, 216, 236),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Select Language / भाषा चुनें',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            // add some space in between
            const SizedBox(height: 10),
            Column(
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    context.setLocale(const Locale('en', 'US'));
                    onLocaleSelected();
                  },
                  child: const Text('English', style: TextStyle(fontSize: 20)),
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(110, 60),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.all(16),
                  ),
                  onPressed: () {
                    context.setLocale(const Locale('hi', 'IN'));
                    onLocaleSelected();
                  },
                  child: const Text('हिंदी', style: TextStyle(fontSize: 20)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
