import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture_grade.freezed.dart';
part 'lecture_grade.g.dart';

@freezed
class LectureGrade with _$LectureGrade {
  factory LectureGrade(
      {required String name,
      required String announceDate,
      required String classAverage,
      required String note}) = _LectureGrade;

  factory LectureGrade.fromJson(Map<String, dynamic> json) =>
      _$LectureGradeFromJson(json);
}
