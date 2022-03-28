// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'lecture.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lecture _$$_LectureFromJson(Map<String, dynamic> json) => _$_Lecture(
      metaData:
          LectureMetadata.fromJson(json['metaData'] as Map<String, dynamic>),
      statusText: json['statusText'] as String?,
      credit: (json['credit'] as num?)?.toDouble(),
      finalGrade: json['finalGrade'] as String?,
      initialFinalGrade: json['initialFinalGrade'] as String?,
      duplicated: json['duplicated'] as bool? ?? false,
      gradeList: (json['gradeList'] as List<dynamic>?)
          ?.map((e) => LectureGrade.fromJson(e as Map<String, dynamic>))
          .toList(),
      detailList: (json['detailList'] as List<dynamic>?)
          ?.map((e) => LectureDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_LectureToJson(_$_Lecture instance) =>
    <String, dynamic>{
      'metaData': instance.metaData,
      'statusText': instance.statusText,
      'credit': instance.credit,
      'finalGrade': instance.finalGrade,
      'initialFinalGrade': instance.initialFinalGrade,
      'duplicated': instance.duplicated,
      'gradeList': instance.gradeList,
      'detailList': instance.detailList,
    };
