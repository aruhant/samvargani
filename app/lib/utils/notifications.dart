import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paheli/models/wotd.dart';

initializeNotifications() {
  print('Initializing notifications');
  AwesomeNotifications().initialize('resource://drawable/ic_stat_no', [
    NotificationChannel(
        channelGroupKey: 'samvargani',
        channelKey: 'samvargani',
        channelName: 'Daily game notifications',
        channelDescription: 'One notification per day',
        icon: 'resource://drawable/ic_stat_no',
        defaultColor: const Color.fromARGB(255, 255, 123, 0),
        enableVibration: false,
        ledColor: const Color.fromARGB(255, 255, 132, 0)),
  ]);
}

requestPermissions() async {
  AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
    if (!isAllowed) {
      AwesomeNotifications().requestPermissionToSendNotifications();
    }
  });
}

testNotification() {
  WotD.load().then((g) => AwesomeNotifications().createNotification(
      schedule: NotificationCalendar(
          timeZone: AwesomeNotifications.localTimeZoneIdentifier,
          hour: 9,
          minute: 0,
          second: 0,
          millisecond: 0,
          repeats: true),
      content: NotificationContent(
          id: 1,
          channelKey: 'samvargani',
          title: 'A new challange awaits you',
          body: 'Can you solve today\'s word of the day?')));
}
