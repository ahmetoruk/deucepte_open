import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule_text_container.freezed.dart';
part 'schedule_text_container.g.dart';

@freezed
class ScheduleTextContainer with _$ScheduleTextContainer {
  factory ScheduleTextContainer(
      {required String text,
      required bool bold,
      required bool isLectureRoom}) = _ScheduleTextContainer;

  factory ScheduleTextContainer.fromJson(Map<String, dynamic> json) =>
      _$ScheduleTextContainerFromJson(json);
}
