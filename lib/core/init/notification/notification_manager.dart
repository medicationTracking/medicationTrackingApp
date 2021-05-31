import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:medication_app_v0/core/init/notification/medication_notification.dart';
import 'package:medication_app_v0/views/home/Calendar/model/reminder.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as t;

class NotificationManager {
  static NotificationManager _instance;
  static NotificationManager get instance {
    if (_instance == null) _instance = NotificationManager._init();
    return _instance;
  }

  NotificationManager._init() {
    initNotificationManager();
  }

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  AndroidInitializationSettings initializationSettingsAndroid;
  IOSInitializationSettings initializationSettingsIOS;
  InitializationSettings initializationSettings;

  Future initNotificationManager() async {
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    initializationSettingsAndroid =
        AndroidInitializationSettings("app_icon");
    initializationSettingsIOS = IOSInitializationSettings();
    initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String payload) async {
          final NotificationAppLaunchDetails details =
          await flutterLocalNotificationsPlugin
              .getNotificationAppLaunchDetails();
          if (payload != null) {
            print('notification payload: ' + payload);
          }
        });
  }

  Future<void> scheduleNotification(MedicationNotification notification) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        "Medication", "Medicine", "Medication",
        icon: 'app_icon',
        largeIcon: DrawableResourceAndroidBitmap('app_icon'),
        autoCancel: false,
        enableLights: true,
        playSound: true,
        color: Colors.green,
        ledColor: const Color.fromARGB(255, 255, 0, 0),
        ledOnMs: 1000,
        ledOffMs: 500);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
        badgeNumber: 1);
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    final timeZone = TimeZone();

    // The device's timezone.
    String timeZoneName = await timeZone.getTimeZoneName();

    // Find the 'current location'
    final location = await timeZone.getLocation(timeZoneName);
    final scheduledDate = tz.TZDateTime.from(notification.notificationTime, location);

    await flutterLocalNotificationsPlugin.zonedSchedule(
        notification.notificationID,
        notification.notificationTitle,
        notification.notificationBody,
        scheduledDate,
        platformChannelSpecifics,
        payload: notification.payload,
    androidAllowWhileIdle: true);
  }


  Future<void> showNotification() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'your channel id', 'your channel name', 'your channel description',
        importance: Importance.max);
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);

    await flutterLocalNotificationsPlugin.show(
        0,
        'plain title',
        'plain body',
        platformChannelSpecifics,
        payload: 'item x');
  }

  void scheduleReminderNotification(ReminderModel reminder) {
    if (reminder.time.isAfter(DateTime.now())) {
      MedicationNotification notification = MedicationNotification(
          notificationTitle: reminder.pillName + " Medication Time",
          notificationID: reminder.time.millisecond,
          notificationTime: reminder.time,
          notificationBody:
          "${reminder.pillName} -  ${reminder.time.hour}:${reminder.time.minute}",
          payload: "emtpy");
      this.scheduleNotification(notification);
    }
  }
}


class TimeZone {
  factory TimeZone() => _this ?? TimeZone._();

  TimeZone._() {
    initializeTimeZones();
  }
  static TimeZone _this;

  Future<String> getTimeZoneName() async => FlutterNativeTimezone.getLocalTimezone();

  Future<t.Location> getLocation([String timeZoneName]) async {
    if(timeZoneName == null || timeZoneName.isEmpty){
      timeZoneName = await getTimeZoneName();
    }
    return t.getLocation(timeZoneName);
  }
}