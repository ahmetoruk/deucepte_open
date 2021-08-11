import 'dart:convert';

import 'package:deu_api/deu_api.dart' show Lecture, Semester;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/data/repositories/average_repository.dart';
import 'package:deucepte_open/data/repositories/semester_repository.dart';

enum AverageLoadingStatus {
  initial,
  semestersLoading,
  semesterProgress,
  lectureProgress,
  success,
  failure
}

class AverageLoadingState extends Equatable {
  AverageLoadingState(
      {this.status = AverageLoadingStatus.initial,
      this.total = 0,
      this.current = 0,
      Semester? currentSemester,
      Lecture? currentLecture,
      this.semesters = const <Semester>[],
      this.lectures = const <Lecture>[]})
      : currentSemester = currentSemester ?? Semester.empty,
        currentLecture = currentLecture ?? Lecture.empty;

  final AverageLoadingStatus status;
  final int total;
  final int current;
  final Semester currentSemester;
  final Lecture currentLecture;
  final List<Semester> semesters;
  final List<Lecture> lectures;

  AverageLoadingState copyWith(
      {AverageLoadingStatus? status,
      int? total,
      int? current,
      Semester? currentSemester,
      Lecture? currentLecture,
      List<Semester>? semesters,
      List<Lecture>? lectures}) {
    return AverageLoadingState(
        status: status ?? this.status,
        total: total ?? this.total,
        current: current ?? this.current,
        currentLecture: currentLecture ?? this.currentLecture,
        currentSemester: currentSemester ?? this.currentSemester,
        semesters: semesters ?? this.semesters,
        lectures: lectures ?? this.lectures);
  }

  @override
  List<Object?> get props => [
        status,
        total,
        current,
        currentSemester,
        currentLecture,
        semesters,
        lectures
      ];
}

class AverageLoadingCubit extends Cubit<AverageLoadingState> {
  AverageLoadingCubit(
      this.semesterRepository, this.averageRepository, this.sharedPreferences)
      : super(AverageLoadingState());

  final SemesterRepository semesterRepository;
  final AverageRepository averageRepository;
  final SharedPreferences sharedPreferences;

  Future loadAverage() async {
    final lectures = <Lecture>[];
    emit(state.copyWith(status: AverageLoadingStatus.semestersLoading));
    final semesters = await semesterRepository.getSemesters();
    var count = 1;
    final semesterLectures = <Lecture>[];
    for (final semester in semesters) {
      try {
        var wait = false;
        var lectures = await averageRepository.getLecturesCache(semester);
        if (lectures.isEmpty) {
          lectures = await averageRepository.getLectures(semester);
          wait = true;
        }
        semesterLectures.addAll(lectures);
        emit(AverageLoadingState(
            status: AverageLoadingStatus.semesterProgress,
            total: semesters.length,
            current: count,
            currentSemester: semester));
        count++;
        if (wait) {
          await Future<void>.delayed(const Duration(seconds: 1));
        }
      } catch (e) {
        emit(state.copyWith(status: AverageLoadingStatus.failure));
        return;
      }
    }
    count = 1;
    final lastSemester = semesters.reversed.last;
    for (final lecture in semesterLectures.reversed) {
      final lectureLastSemester =
          lecture.metaData.semesterId == lastSemester.id;
      var wait = true;
      Lecture? newLecture;
      try {
        if (!lectureLastSemester) {
          newLecture = averageRepository.getAverageLectureDetail(lecture);
          if (newLecture != null) {
            wait = false;
          } else {
            newLecture = await averageRepository.getLectureDetail(lecture);
          }
        } else {
          newLecture = await averageRepository.getLectureDetail(lecture);
        }
        averageRepository.saveLectureDetail(newLecture);
        emit(AverageLoadingState(
            status: AverageLoadingStatus.lectureProgress,
            total: semesterLectures.length,
            current: count,
            currentLecture: lecture));
        lectures.add(newLecture);
        if (wait) await Future<void>.delayed(const Duration(seconds: 1));
      } catch (e) {
        emit(state.copyWith(status: AverageLoadingStatus.failure));
        return;
      }
      count++;
    }
    await filterLectures(lectures);
  }

  Future filterLectures(List<Lecture> lectures) async {
    final filteredLectures = lectures.map((final e) => e.copyWith()).toList();
    final averageLectures = <Lecture>[];
    final semesters = await semesterRepository.getSemesters();
    for (final lecture in filteredLectures) {
      if (averageLectures
          .where((element) =>
              element.metaData.lectureId == lecture.metaData.lectureId)
          .isNotEmpty) {
        continue;
      }
      var newLecture = lecture.copyWith();
      final duplicateLectures = filteredLectures
          .where((final element) =>
              element.metaData.lectureId == lecture.metaData.lectureId &&
              element.metaData.semesterId != lecture.metaData.semesterId)
          .toList();
      if (duplicateLectures.isNotEmpty) {
        var cloneLecture = lecture.copyWith();
        for (final duplicateLecture in duplicateLectures) {
          cloneLecture = lecture.copyWith(
              statusText: duplicateLecture.statusText,
              finalGrade: duplicateLecture.finalGrade!.isNotEmpty
                  ? duplicateLecture.finalGrade
                  : cloneLecture.finalGrade,
              initialFinalGrade: duplicateLecture.initialFinalGrade!.isNotEmpty
                  ? duplicateLecture.initialFinalGrade
                  : cloneLecture.initialFinalGrade,
              gradeList: duplicateLecture.gradeList,
              duplicated: true);
        }
        newLecture = cloneLecture;
      }
      var finalGrade = newLecture.finalGrade!;
      final lectureFinalGrade = lecture.finalGrade ?? '';
      if (lectureFinalGrade.isEmpty ||
          lectureFinalGrade.toUpperCase() == 'B' ||
          lectureFinalGrade.toUpperCase() == 'Y' ||
          lectureFinalGrade.toUpperCase() == 'E' ||
          lectureFinalGrade.toUpperCase() == 'M') {
        finalGrade = '--';
      } else if (lectureFinalGrade.toUpperCase() == 'D') {
        finalGrade = 'FF';
      }
      newLecture = newLecture.copyWith(finalGrade: finalGrade);
      averageLectures.add(newLecture);
    }
    final lecturesLineChart = averageLectures
        .where((Lecture lecture) => lecture.finalGrade != '--')
        .toList();
    await sharedPreferences.setString(
        'line_chart_list', jsonEncode(lecturesLineChart));
    emit(state.copyWith(
        status: AverageLoadingStatus.success,
        semesters: semesters.reversed.toList(),
        lectures: averageLectures));
  }
}
