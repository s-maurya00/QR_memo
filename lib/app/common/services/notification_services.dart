import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone_updated_gradle/flutter_native_timezone.dart';
import 'package:get/get.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../../models/item.dart';

class NotifyHelper {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  initializeNotification() async {
    // tz.initializeTimeZones();
    _configureLocalTimeZone();

    const AndroidInitializationSettings initializationSettingsAndroid =
        AndroidInitializationSettings("drawable/app_icon");

    InitializationSettings initializationSettings =
        const InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onSelectNotification: selectNotification,
    );
  }

  // Future onDidReceiveLocalNotification(
  //     int id, String? title, String? body, String? payload) async {
  //   display a dialog with the notification details, tap ok to go to another page
  //   showDialog(
  //     //context: Get.context!,
  //     builder: (BuildContext context) => CupertinoAlertDialog(
  //       title: Text(title!),
  //       content: Text(body!),
  //       actions: [
  //         CupertinoDialogAction(
  //           isDefaultAction: true,
  //           child: Text('Ok'),
  //           onPressed: () async {
  //             Navigator.of(context, rootNavigator: true).pop();
  //             await Navigator.push(
  //               context,
  //               MaterialPageRoute(
  //                 builder: (context) => SecondScreen(payload),
  //               ),
  //             );
  //           },
  //         ),
  //       ],
  //     ),
  //   );

  //   Get.dialog(Text("Welcome to flutter"));
  // }

  Future selectNotification(String? payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    } else {
      debugPrint("Notification Done");
    }
    Get.to(() => Container());
  }

  displayNotification({required String title, required String body}) async {
    AndroidNotificationDetails androidPlatformChannelSpecifics =
        const AndroidNotificationDetails(
      'your channel id',
      'your channel name',
      playSound: true,
      importance: Importance.max,
      priority: Priority.high,
    );

    NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      platformChannelSpecifics,
      payload: 'It_could_be_anything_you_pass',
    );
  }

  scheduledNotification(
    Item item,
    int year,
    int month,
    int day,
    int hour,
    int minutes,
  ) async {
    AndroidScheduleMode androidScheduleMode =
        AndroidScheduleMode.exactAllowWhileIdle;

    await flutterLocalNotificationsPlugin.zonedSchedule(
      item.id!.toInt(),
      item.name,
      item.descp,
      _convertTimeToTimeZone(year, month, day, hour, minutes),
      // tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
      const NotificationDetails(
        android: AndroidNotificationDetails(
          'your channel id',
          'your channel name',
        ),
      ),
      androidScheduleMode: androidScheduleMode,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: item.repeat == "None"
          ? null
          : (item.repeat == "Daily"
              ? DateTimeComponents.time
              : (item.repeat == "Weekly"
                  ? DateTimeComponents.dayOfWeekAndTime
                  : DateTimeComponents.dayOfMonthAndTime)),
    );
  }

  tz.TZDateTime _convertTimeToTimeZone(
    int year,
    int month,
    int day,
    int hours,
    int minute,
  ) {
    final tz.TZDateTime now = tz.TZDateTime.now(tz.local);

    final tz.TZDateTime scheduledDate = tz.TZDateTime(
      tz.local,
      year,
      month,
      day,
      hours,
      minute,
    );

    if (scheduledDate.isBefore(now)) {
      scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  Future<void> _configureLocalTimeZone() async {
    tz.initializeTimeZones();

    final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();

    try {
      tz.setLocalLocation(tz.getLocation(timeZoneName));
    } catch (e) {
      debugPrint(e.toString());
      tz.setLocalLocation(tz.getLocation("Asia/Kolkata"));
    }
  }

  // Future<void> cancelNotification() async {
  //   await flutterLocalNotificationsPlugin.cancel(0);
  // }
}
