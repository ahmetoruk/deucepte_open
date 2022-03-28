// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture_metadata.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LectureMetadata _$$_LectureMetadataFromJson(Map<String, dynamic> json) =>
    _$_LectureMetadata(
      uniqueId: json['uniqueId'] as String,
      lectureId: json['lectureId'] as String,
      semesterId: json['semesterId'] as int,
      name: json['name'] as String,
      success: json['success'] as String,
      metaGrade: json['metaGrade'] as String,
    );

Map<String, dynamic> _$$_LectureMetadataToJson(_$_LectureMetadata instance) =>
    <String, dynamic>{
      'uniqueId': instance.uniqueId,
      'lectureId': instance.lectureId,
      'semesterId': instance.semesterId,
      'name': instance.name,
      'success': instance.success,
      'metaGrade': instance.metaGrade,
    };
