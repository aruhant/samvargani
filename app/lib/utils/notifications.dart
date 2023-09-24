import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:paheli/translations/locale_keys.g.dart';

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

Future<bool> hasPermissions() async {
  return await AwesomeNotifications().isNotificationAllowed();
}

Future<bool> requestPermissions() async {
  bool isAllowed = await AwesomeNotifications().isNotificationAllowed();
  if (!isAllowed) {
    bool pressedYes =
        await AwesomeNotifications().requestPermissionToSendNotifications();
    return pressedYes;
  } else
    print('Permissions already granted');
  return true;
}

setupNotification() async {
  print('setupNotification');
  bool r = await AwesomeNotifications().createNotification(
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
          title: LocaleKeys.notification_title.tr(),
          body: LocaleKeys.notification_message.tr()));
  print(r);
}

Future<String> testnotification() async {
  try {
    bool r = await AwesomeNotifications().createNotification(
        schedule: NotificationCalendar(
            timeZone: AwesomeNotifications.localTimeZoneIdentifier,
            hour: DateTime.now().hour,
            minute: DateTime.now().minute + 1,
            second: DateTime.now().second,
            millisecond: 0,
            repeats: false),
        content: NotificationContent(
            id: 1,
            channelKey: 'samvargani',
            title: LocaleKeys.notification_title.tr(),
            body: LocaleKeys.notification_message.tr()));
    return r ? 'Notification created' : 'Notification not created';
  } catch (e) {
    return e.toString();
  }
}
