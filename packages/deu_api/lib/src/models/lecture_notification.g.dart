// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_notification.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LectureNotification _$$_LectureNotificationFromJson(
        Map<String, dynamic> json) =>
    _$_LectureNotification(
      lecture: Lecture.fromJson(json['lecture'] as Map<String, dynamic>),
      notified: json['notified'] as bool,
    );

Map<String, dynamic> _$$_LectureNotificationToJson(
        _$_LectureNotification instance) =>
    <String, dynamic>{
      'lecture': instance.lecture,
      'notified': instance.notified,
    };
