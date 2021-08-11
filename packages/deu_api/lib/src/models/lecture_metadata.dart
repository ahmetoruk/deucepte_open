import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'lecture_metadata.freezed.dart';
part 'lecture_metadata.g.dart';

@freezed
class LectureMetadata with _$LectureMetadata {
  factory LectureMetadata({
    required String uniqueId,
    required String lectureId,
    required int semesterId,
    required String name,
    required String success,
    required String metaGrade,
  }) = _LectureMetadata;

  factory LectureMetadata.fromJson(Map<String, dynamic> json) =>
      _$LectureMetadataFromJson(json);
}
