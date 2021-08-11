import 'dart:convert';

import 'package:deu_api/deu_api.dart' show LectureNotification;
import 'package:shared_preferences/shared_preferences.dart';

abstract class ILectureNotificationLocalStorage {
  void saveNotifications(List<LectureNotification> notifications);
  List<LectureNotification>? getNotifications();
}

class LectureNotificationLocalStorage
    implements ILectureNotificationRepository {
  LectureNotificationLocalStorage(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  final String key = 'notifications';

  @override
  List<LectureNotification>? getNotifications() {
    final notificationsJson = sharedPreferences.getString(key);
    if (notificationsJson != null) {
      final jsonList = jsonDecode(notificationsJson) as List;
      final notifications = jsonList
          .map<LectureNotification>((dynamic json) =>
              LectureNotification.fromJson(json as Map<String, dynamic>))
          .toList();
      return notifications;
    }
    return null;
  }

  @override
  void saveNotifications(List<LectureNotification> notifications) {
    sharedPreferences.setString(key, jsonEncode(notifications));
  }
}

abstract class ILectureNotificationRepository {
  void saveNotifications(List<LectureNotification> notifications);
  List<LectureNotification>? getNotifications();
}

class LectureNotificationRepository implements ILectureNotificationRepository {
  LectureNotificationRepository(SharedPreferences sharedPreferences)
      : lectureNotificationLocalStorage =
            LectureNotificationLocalStorage(sharedPreferences);

  final LectureNotificationLocalStorage lectureNotificationLocalStorage;

  @override
  List<LectureNotification>? getNotifications() {
    return lectureNotificationLocalStorage.getNotifications();
  }

  @override
  void saveNotifications(List<LectureNotification> notifications) {
    lectureNotificationLocalStorage.saveNotifications(notifications);
  }
}
