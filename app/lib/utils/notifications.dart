import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:paheli/models/wotd.dart';
import 'package:paheli/utils/string.dart';

initializeNotifications() {
  print('Initializing notifications');
  AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_no',
      [
        NotificationChannel(
            channelGroupKey: 'samvargani',
            channelKey: 'samvargani',
            channelName: 'Daily game notifications',
            channelDescription: 'One notification per day',
            icon: 'resource://drawable/ic_stat_foreground',
            defaultColor: Color.fromARGB(255, 255, 123, 0),
            ledColor: Color.fromARGB(255, 255, 132, 0))
      ],
      // Channel groups are only visual and are not required
      // channelGroups: [
      //   NotificationChannelGroup(
      //       channelGroupkey: 'samvargani', channelGroupName: 'Samvargani')
      // ],
      debug: true);
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
      content: NotificationContent(
          id: 1,
          channelKey: 'samvargani',
          title: g.answer.title,
          body: g.answer.answer.allCharacters.map((e) => e.matra).join('_'))));
  ;
}
