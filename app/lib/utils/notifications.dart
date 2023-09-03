import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

initializeNotifications() {
  print('Initializing notifications');
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      'resource://drawable/res_app_icon',
      [
        NotificationChannel(
            channelGroupKey: 'samvargani',
            channelKey: 'samvargani',
            channelName: 'Daily game notifications',
            channelDescription: 'One notification per day',
            defaultColor: Color(0xFF9D50DD),
            ledColor: Colors.white)
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
  AwesomeNotifications().createNotification(
      content: NotificationContent(
          id: 10,
          channelKey: 'samvargani',
          title: 'Simple Notification',
          body: 'Simple body'));
}
