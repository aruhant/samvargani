import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:url_launcher/url_launcher.dart';

class LanguagePicker extends StatelessWidget {
  const LanguagePicker({Key? key, required this.onLocaleSelected})
      : super(key: key);
  final VoidCallback onLocaleSelected;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromARGB(255, 241, 216, 236),
        bottomNavigationBar: makePrivacyPolicy(context),
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

                      FirebaseAnalytics.instance
                          .logEvent(name: 'language_selected_English');
                      FirebaseAnalytics.instance
                          .setUserProperty(name: 'language', value: 'English');
                    },
                    child:
                        const Text('English', style: TextStyle(fontSize: 20)),
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
                      FirebaseAnalytics.instance
                          .logEvent(name: 'language_selected_Hindi');
                      FirebaseAnalytics.instance
                          .setUserProperty(name: 'language', value: 'Hindi');
                    },
                    child: const Text('हिंदी', style: TextStyle(fontSize: 20)),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  makePrivacyPolicy(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: TextButton(
        child: const Text('Privacy Policy',
            style: TextStyle(
                color: Colors.blue,
                fontSize: 20,
                decoration: TextDecoration.underline)),
        onPressed: () {
          launchUrl(Uri.parse('https://aruhant.github.io/privacy.html'));
        },
      ),
    );
  }
}
