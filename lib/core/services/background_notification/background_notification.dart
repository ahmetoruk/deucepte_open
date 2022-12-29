import 'dart:math' show Random;

import 'package:flutter/material.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final _localNotification = BackgroundNotification();
BackgroundNotification get backgroundNotification => _localNotification;

class BackgroundNotification {
  BackgroundNotification() {
    const _androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'depcepte_lectureimp',
      'Not bildirim kanalı',
      channelDescription: 'DEUCepte Notlarınız açıklandığında bildirim alın.',
      groupKey: 'com.ahmetoruk.deucepte_open.lecture',
      importance: Importance.max,
      color: Colors.purple,
      priority: Priority.max,
    );
    platformChannelSpecifics =
        const NotificationDetails(android: _androidPlatformChannelSpecifics);
    const initializationSettingsAndroid =
        AndroidInitializationSettings('ic_notification_deu');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  final flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  late final NotificationDetails platformChannelSpecifics;

  Future showNotification(int? id,
      {required String title, required String text}) async {
    id ??= Random().nextInt(99999999);
    await flutterLocalNotificationsPlugin.show(
        id, title, text, platformChannelSpecifics);
  }
}
