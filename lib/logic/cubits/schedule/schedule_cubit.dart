import 'package:bloc/bloc.dart';
import 'package:deu_api/deu_api.dart' show ScheduleTextContainer;
import 'package:equatable/equatable.dart';

import 'package:deucepte_open/data/repositories/schedule_repository.dart';

class CurrentScheduleLecture {
  const CurrentScheduleLecture(this.dayOfWeek, this.rowIndex, this.timeLeft);
  final int dayOfWeek;
  final int rowIndex;
  final String timeLeft;
}

enum ScheduleStatus { initial, loading, success, failure }

class ScheduleState extends Equatable {
  const ScheduleState(
      {this.status = ScheduleStatus.initial,
      this.scheduleTable = const <List<List<ScheduleTextContainer>>>[],
      this.currentLecture});

  final ScheduleStatus status;
  final List<List<List<ScheduleTextContainer>>> scheduleTable;
  final CurrentScheduleLecture? currentLecture;

  ScheduleState copyWith(
          {ScheduleStatus? status,
          List<List<List<ScheduleTextContainer>>>? scheduleTable,
          CurrentScheduleLecture? currentLecture}) =>
      ScheduleState(
          status: status ?? this.status,
          scheduleTable: scheduleTable ?? this.scheduleTable,
          currentLecture: currentLecture ?? this.currentLecture);

  @override
  List<Object?> get props => [status, scheduleTable];
}

class ScheduleCubit extends Cubit<ScheduleState> {
  ScheduleCubit(this.scheduleRepository) : super(const ScheduleState());

  final ScheduleRepository scheduleRepository;

  Future getScheduleTable({bool cache = false}) async {
    try {
      emit(state.copyWith(status: ScheduleStatus.loading));
      final scheduleTable =
          await scheduleRepository.getScheduleTable(cache: cache);
      final currentLecture = calculateCurrentLecture(scheduleTable);
      emit(state.copyWith(
          status: ScheduleStatus.success,
          scheduleTable: scheduleTable,
          currentLecture: currentLecture));
    } catch (e) {
      emit(state.copyWith(status: ScheduleStatus.failure));
    }
  }

  CurrentScheduleLecture? calculateCurrentLecture(
      List<List<List<ScheduleTextContainer>>> table) {
    final nowDate = DateTime.now();
    var timeLeft = '';
    var isEmpty = false;
    final dayIndex = nowDate.weekday > 5 ? 1 : nowDate.weekday;
    var selectedRow = 0;
    timeLeft = '';
    try {
      DateTime? prevEndTime;
      late DateTime startTime;
      late DateTime endTime;
      for (var i = 0; i < table.length; i++) {
        isEmpty = false;
        selectedRow = i;
        final startClock = table[i][0][0].text.split(' ')[0].split(':');
        final endClock = table[i][0][0].text.split(' ')[1].split(':');
        startTime = DateTime(nowDate.year, nowDate.month, nowDate.day,
            int.parse(startClock[0]), int.parse(startClock[1]));
        endTime = DateTime(nowDate.year, nowDate.month, nowDate.day,
            int.parse(endClock[0]), int.parse(endClock[1]));
        final isBetween =
            nowDate.isAfter(startTime) && nowDate.isBefore(endTime);
        final isAtStartHour = nowDate.hour == startTime.hour &&
            nowDate.minute == startTime.minute;
        final isBefore = nowDate.isBefore(startTime);
        if (table[i][dayIndex].length != 1) {
          if (isBefore || isBetween || isAtStartHour) {
            break;
          } else {
            if (prevEndTime == null) {
              prevEndTime = endTime;
            } else {
              if (nowDate.isAfter(prevEndTime) && endTime.isAfter(nowDate)) {
                break;
              } else {
                prevEndTime = endTime;
              }
            }
          }
        } else {
          isEmpty = true;
        }
      }
      if (startTime.isAfter(nowDate) && !isEmpty) {
        final timeDifference = startTime.difference(nowDate);
        timeLeft =
            '${timeDifference.inHours.remainder(60).toString().padLeft(2, '0')}:${timeDifference.inMinutes.remainder(60).toString().padLeft(2, '0')}:${timeDifference.inSeconds.remainder(60).toString().padLeft(2, '0')}';
      }
      return CurrentScheduleLecture(dayIndex, selectedRow, timeLeft);
    } catch (_) {}
    return null;
  }
}
