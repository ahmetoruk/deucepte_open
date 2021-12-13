import 'dart:async';

import 'package:deu_api/deu_api.dart' show Lecture, Semester;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:deucepte_open/core/constants/constants.dart';
import 'package:deucepte_open/core/extensions/lecture.dart';
import 'package:deucepte_open/logic/cubits/average/average_loading_cubit.dart';

enum AverageLoadingError { connection, semester, lecture, unknown }

class AverageResult {
  const AverageResult(this.cumAvg, this.newSemesterList);
  final double cumAvg;
  final List<Semester> newSemesterList;
}

enum AverageCalcStatus { initial, success }

class AverageCalcState extends Equatable {
  const AverageCalcState(
      {this.status = AverageCalcStatus.initial,
      this.semesters = const <Semester>[],
      this.lectures = const <Lecture>[],
      this.initialAverage = 0,
      this.finalAverage = 0});

  final AverageCalcStatus status;
  final List<Semester> semesters;
  final List<Lecture> lectures;
  final double initialAverage, finalAverage;

  AverageCalcState copyWith(
      {AverageCalcStatus? status,
      List<Semester>? semesters,
      List<Lecture>? lectures,
      double? initialAverage,
      double? finalAverage}) {
    return AverageCalcState(
        status: status ?? this.status,
        semesters: semesters ?? this.semesters,
        lectures: lectures ?? this.lectures,
        initialAverage: initialAverage ?? this.initialAverage,
        finalAverage: finalAverage ?? this.finalAverage);
  }

  @override
  List<Object?> get props => [status, semesters, lectures, finalAverage];
}

class AverageCalcCubit extends Cubit<AverageCalcState> {
  AverageCalcCubit(this.averageLoadingCubit) : super(const AverageCalcState()) {
    subscription = averageLoadingCubit.stream.listen(
      (state) {
        if (state.status == AverageLoadingStatus.success) {
          final averageResult = calcSemesterAverages(
              semesters: state.semesters, lectures: state.lectures);
          emit(AverageCalcState(
              status: AverageCalcStatus.success,
              semesters: averageResult.newSemesterList,
              lectures: state.lectures,
              initialAverage: averageResult.cumAvg,
              finalAverage: averageResult.cumAvg));
        }
      },
    );
  }

  final AverageLoadingCubit averageLoadingCubit;
  StreamSubscription? subscription;

  void updateGrade(Lecture lecture, String grade) {
    final lectures = state.lectures
        .map((lectureMap) =>
            lectureMap.metaData.uniqueId == lecture.metaData.uniqueId
                ? lectureMap.copyWith(finalGrade: grade)
                : lectureMap)
        .toList();
    final averageResult =
        calcSemesterAverages(semesters: state.semesters, lectures: lectures);
    emit(state.copyWith(
        status: AverageCalcStatus.success,
        semesters: averageResult.newSemesterList,
        lectures: lectures,
        finalAverage: averageResult.cumAvg));
  }

  void resetLectureGrades() {
    final updateLectures = state.lectures
        .map((lectureMap) => lectureMap.copyWith(
            finalGrade: lectureMap.initialFinalGrade!.isNotEmpty
                ? lectureMap.initialFinalGrade
                : lectureMap.finalGrade))
        .toList();
    final averageResult = calcSemesterAverages(
        semesters: state.semesters, lectures: updateLectures);
    emit(state.copyWith(
        status: AverageCalcStatus.success,
        semesters: averageResult.newSemesterList,
        lectures: updateLectures,
        finalAverage: averageResult.cumAvg));
  }

  void setAllSemesterLecturesToCC(Semester semester) {
    final updateLectures = state.lectures
        .map((lectureMap) => lectureMap.copyWith(
            finalGrade: lectureMap.metaData.semesterId == semester.id &&
                    lectureMap.initialFinalGrade!.isEmpty &&
                    lectureMap.metaData.metaGrade != 'B'
                ? 'CC'
                : lectureMap.finalGrade))
        .toList();
    final averageResult = calcSemesterAverages(
        semesters: state.semesters, lectures: updateLectures);
    emit(state.copyWith(
        status: AverageCalcStatus.success,
        semesters: averageResult.newSemesterList,
        lectures: updateLectures,
        finalAverage: averageResult.cumAvg));
  }

  AverageResult calcSemesterAverages(
      {required List<Semester> semesters, required List<Lecture> lectures}) {
    final newSemesters = <Semester>[];
    var totalCreditFinal = 0.0, totalEarnedCreditFinal = 0.0;
    for (final semester in semesters) {
      var semesterResult = 0.0;
      var totalCredit = 0.0, totalEarnedCredit = 0.0;
      for (final lecture in lectures.filterBySemester(semester)) {
        if (lecture.finalGrade != '--') {
          final letterIndex = letterGradeList.indexOf(lecture.finalGrade!);
          final lectureCredit = lecture.credit!;
          final mult = 4 - (letterIndex * 0.5);
          totalCredit += lectureCredit;
          totalCreditFinal += lectureCredit;
          totalEarnedCredit += lectureCredit * mult;
          totalEarnedCreditFinal += lectureCredit * mult;
        }
      }
      semesterResult = totalEarnedCredit / totalCredit;
      newSemesters.add(semester.copyWith(average: semesterResult));
    }
    final finalResult = totalEarnedCreditFinal / totalCreditFinal;
    return AverageResult(finalResult, newSemesters);
  }

  @override
  Future<void> close() async {
    await subscription?.cancel();
    await super.close();
  }
}
