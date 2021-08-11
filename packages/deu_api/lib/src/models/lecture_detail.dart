import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture_detail.freezed.dart';
part 'lecture_detail.g.dart';

@freezed
class LectureDetail with _$LectureDetail {
  factory LectureDetail({required String name, required String detail}) =
      _LectureDetail;

  factory LectureDetail.fromJson(Map<String, dynamic> json) =>
      _$LectureDetailFromJson(json);
}
