import 'package:deu_api/deu_api.dart'
    show Lecture, LectureApi, LectureGrade, LectureNotification;

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/core/services/background_notification/background_fetch.dart';
import 'package:deucepte_open/core/services/background_notification/background_notification.dart';
import 'package:deucepte_open/data/repositories/lecture_notification_repository.dart';

enum LectureNotificationStatus { initial, success, failure }

class LectureNotificationListState extends Equatable {
  const LectureNotificationListState(
      {this.status = LectureNotificationStatus.initial,
      List<LectureNotification>? lectureNotifications})
      : lectureNotifications =
            lectureNotifications ?? const <LectureNotification>[];

  final LectureNotificationStatus status;
  final List<LectureNotification> lectureNotifications;

  LectureNotificationListState copyWith({
    LectureNotificationStatus? status,
    List<LectureNotification>? lectureNotifications,
  }) {
    return LectureNotificationListState(
      status: status ?? this.status,
      lectureNotifications: lectureNotifications ?? this.lectureNotifications,
    );
  }

  @override
  List<Object?> get props => [status, lectureNotifications];
}

class LectureNotificationListCubit extends Cubit<LectureNotificationListState> {
  LectureNotificationListCubit(
      this.lectureNotificationRepository, this.lectureApi)
      : super(const LectureNotificationListState());

  final LectureApi lectureApi;
  final LectureNotificationRepository lectureNotificationRepository;

  Future startBackgroundFetch() async {
    initBackgroundFetch(callback: checkNotifications);
  }

  void getNotifications() {
    try {
      emit(state.copyWith(status: LectureNotificationStatus.initial));
      final semesterList = lectureNotificationRepository.getNotifications();
      emit(state.copyWith(
          status: LectureNotificationStatus.success,
          lectureNotifications: semesterList));
    } catch (e) {
      emit(state.copyWith(status: LectureNotificationStatus.failure));
    }
  }

  void addNotification(Lecture lecture) {
    final lectureNotification =
        LectureNotification(lecture: lecture, notified: false);
    final notifications = lectureNotificationRepository.getNotifications() ??
        <LectureNotification>[];

    final lastNotifications = [...notifications, lectureNotification];
    lectureNotificationRepository.saveNotifications(lastNotifications);
    emit(state.copyWith(
        status: LectureNotificationStatus.success,
        lectureNotifications:
            lectureNotificationRepository.getNotifications()));
  }

  void removeNotification(Lecture lecture) {
    final notifications = lectureNotificationRepository.getNotifications();
    if (notifications != null) {
      final lastNotifications = notifications
          .where((final notification) =>
              notification.lecture.metaData.uniqueId !=
              lecture.metaData.uniqueId)
          .map((final notification) => notification.copyWith())
          .toList();
      lectureNotificationRepository.saveNotifications(lastNotifications);
    }

    emit(state.copyWith(
        status: LectureNotificationStatus.success,
        lectureNotifications:
            lectureNotificationRepository.getNotifications()));
  }

  Future checkNotifications() async {
    await _checkNotifications();
    emit(state.copyWith(
        status: LectureNotificationStatus.success,
        lectureNotifications:
            lectureNotificationRepository.getNotifications()));
  }

  Future _checkNotifications() async {
    final newLectureNotifications = <LectureNotification>[];
    final _notifications = state.lectureNotifications;
    for (final lectureNotification in _notifications) {
      final notifyList = <LectureGrade>[];
      final notificationLecture = lectureNotification.lecture;
      Lecture? lecture =
          await lectureApi.fetchLectureDetail(notificationLecture);
      if (lecture.gradeList != null && lecture.gradeList!.isNotEmpty) {
        if (notificationLecture.gradeList!.isNotEmpty) {
          for (final lectureGrade in lecture.gradeList!) {
            final changedGrades = notificationLecture.gradeList!
                .where((final element) =>
                    element.name == lectureGrade.name &&
                    element.note != lectureGrade.note)
                .toList();
            if (changedGrades.isNotEmpty) notifyList.add(lectureGrade);
          }
        } else {
          final changedGrades = lecture.gradeList!
              .where((final element) => element.note.isNotEmpty);
          if (changedGrades.isNotEmpty) notifyList.addAll(changedGrades);
        }
      }
      if (notifyList.isNotEmpty) {
        for (final lectureGrade in notifyList) {
          await backgroundNotification.showNotification(null,
              title: lecture.metaData.name,
              text:
                  '${lectureGrade.name}: ${lectureGrade.note} Sınıf ort: ${lectureGrade.classAverage}');
        }
      } else {
        newLectureNotifications.add(lectureNotification.copyWith());
      }
      await Future<void>.delayed(const Duration(seconds: 1));
    }
    lectureNotificationRepository.saveNotifications(newLectureNotifications);
  }
}
