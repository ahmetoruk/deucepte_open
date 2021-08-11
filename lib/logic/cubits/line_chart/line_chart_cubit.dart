import 'dart:async';
import 'dart:convert';

import 'package:deu_api/deu_api.dart' show Lecture;
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/logic/cubits/average/average_loading_cubit.dart';

enum LineChartStatus { initial, loading, success, failure }

class LineChartState extends Equatable {
  LineChartState(
      {this.status = LineChartStatus.initial,
      List<Lecture>? lectures,
      Lecture? selectedLecture})
      : lectures = lectures ?? const <Lecture>[],
        selectedLecture = selectedLecture ?? Lecture.empty;

  final LineChartStatus status;
  final List<Lecture> lectures;
  final Lecture selectedLecture;

  LineChartState copyWith(
      {LineChartStatus? status,
      List<Lecture>? lectures,
      Lecture? selectedLecture}) {
    return LineChartState(
        status: status ?? this.status,
        lectures: lectures ?? this.lectures,
        selectedLecture: selectedLecture ?? this.selectedLecture);
  }

  @override
  List<Object?> get props => [status, lectures, selectedLecture];
}

class LineChartCubit extends Cubit<LineChartState> {
  LineChartCubit(this.averageLoadingCubit, this.sharedPreferences)
      : super(LineChartState()) {
    subscription = averageLoadingCubit.stream.listen(
      (state) {
        if (state.status == AverageLoadingStatus.success) {
          getLineChartData();
        }
      },
    );
  }

  final AverageLoadingCubit averageLoadingCubit;
  final SharedPreferences sharedPreferences;
  StreamSubscription? subscription;

  void getLineChartData() {
    final lineChartJson = sharedPreferences.getString('line_chart_list');
    if (lineChartJson != null) {
      final jsonList = jsonDecode(lineChartJson) as List;
      final lectures = jsonList
          .map<Lecture>(
              (dynamic json) => Lecture.fromJson(json as Map<String, dynamic>))
          .toList();
      emit(
        LineChartState(
          status: LineChartStatus.success,
          lectures: lectures,
          selectedLecture: Lecture.empty.copyWith(
              metaData:
                  Lecture.empty.metaData.copyWith(name: 'Başarı Grafiği')),
        ),
      );
    }
  }

  void selectLecture(int lectureIndex) {
    if (state.status == LineChartStatus.success) {
      emit(state.copyWith(selectedLecture: state.lectures[lectureIndex]));
    }
  }

  @override
  Future<void> close() async {
    await subscription?.cancel();
    await super.close();
  }
}
