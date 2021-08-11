import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

import 'package:deu_api/src/models/lecture_detail.dart';
import 'package:deu_api/src/models/lecture_grade.dart';
import 'package:deu_api/src/models/lecture_metadata.dart';

part 'lecture.freezed.dart';
part 'lecture.g.dart';

@freezed
class Lecture with _$Lecture {
  factory Lecture(
      {required LectureMetadata metaData,
      String? statusText,
      double? credit,
      String? finalGrade,
      String? initialFinalGrade,
      @Default(false) bool duplicated,
      List<LectureGrade>? gradeList,
      List<LectureDetail>? detailList}) = _Lecture;

  factory Lecture.fromJson(Map<String, dynamic> json) =>
      _$LectureFromJson(json);

  static final empty = Lecture(
      metaData: LectureMetadata(
          uniqueId: '',
          lectureId: '',
          semesterId: -1,
          name: '',
          success: '',
          metaGrade: ''));
}
