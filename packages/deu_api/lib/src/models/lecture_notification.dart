import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:deu_api/src/models/lecture.dart';

part 'lecture_notification.freezed.dart';
part 'lecture_notification.g.dart';

@freezed
class LectureNotification with _$LectureNotification {
  factory LectureNotification(
      {required Lecture lecture,
      required bool notified}) = _LectureNotification;

  factory LectureNotification.fromJson(Map<String, dynamic> json) =>
      _$LectureNotificationFromJson(json);
}
