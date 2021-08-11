import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show Lecture, Semester;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/lecture_repository.dart';

enum LectureListStatus { initial, loading, success, failure }

class LectureListState extends Equatable {
  LectureListState(
      {this.status = LectureListStatus.initial,
      List<Lecture>? lectures,
      Semester? semester})
      : lectures = lectures ?? const <Lecture>[],
        semester = semester ?? Semester.empty;

  final LectureListStatus status;
  final List<Lecture> lectures;
  final Semester semester;

  LectureListState copyWith(
      {LectureListStatus? status,
      List<Lecture>? lectures,
      Semester? semester}) {
    return LectureListState(
        status: status ?? this.status,
        lectures: lectures ?? this.lectures,
        semester: semester ?? this.semester);
  }

  @override
  List<Object?> get props => [status, lectures];
}

class LectureListCubit extends Cubit<LectureListState> {
  LectureListCubit(this.lectureRepository) : super(LectureListState());

  final LectureRepository lectureRepository;

  Future getLectureList(Semester semester) async {
    emit(state.copyWith(status: LectureListStatus.loading, semester: semester));
    try {
      var lectures = await lectureRepository.getLecturesCache(semester);
      if (lectures.isEmpty) {
        lectures = await lectureRepository.getLectures(semester);
      }
      emit(state.copyWith(
          status: LectureListStatus.success,
          lectures: lectures,
          semester: semester));
    } catch (e) {
      emit(state.copyWith(
          status: LectureListStatus.failure, semester: semester));
    }
  }
}
