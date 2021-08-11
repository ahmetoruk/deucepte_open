import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show Lecture;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/lecture_repository.dart';

enum LectureDetailStatus { initial, loading, success, failure }

class LectureDetailState extends Equatable {
  LectureDetailState(
      {this.status = LectureDetailStatus.initial, Lecture? lecture})
      : lecture = lecture ?? Lecture.empty;

  final LectureDetailStatus status;
  final Lecture lecture;

  LectureDetailState copyWith({
    LectureDetailStatus? status,
    Lecture? lecture,
  }) {
    return LectureDetailState(
      status: status ?? this.status,
      lecture: lecture ?? this.lecture,
    );
  }

  @override
  List<Object?> get props => [status, lecture];
}

class LectureDetailCubit extends Cubit<LectureDetailState> {
  LectureDetailCubit(this.lectureRepository) : super(LectureDetailState());

  final LectureRepository lectureRepository;

  Future getLectureDetail(Lecture lecture, {bool refresh = false}) async {
    if (!refresh) {
      emit(state.copyWith(status: LectureDetailStatus.loading));
    }
    try {
      final lectureDetail = await lectureRepository.getLectureDetail(lecture);
      emit(state.copyWith(
          status: LectureDetailStatus.success, lecture: lectureDetail));
    } catch (e) {
      emit(state.copyWith(
          status: LectureDetailStatus.failure, lecture: lecture));
    }
  }
}
