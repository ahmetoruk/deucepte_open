import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show Semester;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/semester_repository.dart';

enum SemesterListStatus { initial, loading, success, failure }

class SemesterListState extends Equatable {
  const SemesterListState(
      {this.status = SemesterListStatus.initial,
      this.semesters = const <Semester>[]});

  final SemesterListStatus status;
  final List<Semester> semesters;

  SemesterListState copyWith({
    SemesterListStatus? status,
    List<Semester>? semesters,
  }) =>
      SemesterListState(
        status: status ?? this.status,
        semesters: semesters ?? this.semesters,
      );

  @override
  List<Object?> get props => [status, semesters];
}

class SemesterListCubit extends Cubit<SemesterListState> {
  SemesterListCubit(this.semesterRepository) : super(const SemesterListState());

  final SemesterRepository semesterRepository;

  Future getSemesters() async {
    try {
      emit(state.copyWith(status: SemesterListStatus.loading));
      final semesters = await semesterRepository.getSemesters();
      emit(state.copyWith(
          status: SemesterListStatus.success, semesters: semesters));
    } catch (e) {
      emit(state.copyWith(status: SemesterListStatus.failure));
    }
  }
}
