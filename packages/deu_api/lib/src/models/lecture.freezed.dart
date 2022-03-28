// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lecture.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Lecture _$LectureFromJson(Map<String, dynamic> json) {
  return _Lecture.fromJson(json);
}

/// @nodoc
class _$LectureTearOff {
  const _$LectureTearOff();

  _Lecture call(
      {required LectureMetadata metaData,
      String? statusText,
      double? credit,
      String? finalGrade,
      String? initialFinalGrade,
      bool duplicated = false,
      List<LectureGrade>? gradeList,
      List<LectureDetail>? detailList}) {
    return _Lecture(
      metaData: metaData,
      statusText: statusText,
      credit: credit,
      finalGrade: finalGrade,
      initialFinalGrade: initialFinalGrade,
      duplicated: duplicated,
      gradeList: gradeList,
      detailList: detailList,
    );
  }

  Lecture fromJson(Map<String, Object> json) {
    return Lecture.fromJson(json);
  }
}

/// @nodoc
const $Lecture = _$LectureTearOff();

/// @nodoc
mixin _$Lecture {
  LectureMetadata get metaData => throw _privateConstructorUsedError;
  String? get statusText => throw _privateConstructorUsedError;
  double? get credit => throw _privateConstructorUsedError;
  String? get finalGrade => throw _privateConstructorUsedError;
  String? get initialFinalGrade => throw _privateConstructorUsedError;
  bool get duplicated => throw _privateConstructorUsedError;
  List<LectureGrade>? get gradeList => throw _privateConstructorUsedError;
  List<LectureDetail>? get detailList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureCopyWith<Lecture> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureCopyWith<$Res> {
  factory $LectureCopyWith(Lecture value, $Res Function(Lecture) then) =
      _$LectureCopyWithImpl<$Res>;
  $Res call(
      {LectureMetadata metaData,
      String? statusText,
      double? credit,
      String? finalGrade,
      String? initialFinalGrade,
      bool duplicated,
      List<LectureGrade>? gradeList,
      List<LectureDetail>? detailList});

  $LectureMetadataCopyWith<$Res> get metaData;
}

/// @nodoc
class _$LectureCopyWithImpl<$Res> implements $LectureCopyWith<$Res> {
  _$LectureCopyWithImpl(this._value, this._then);

  final Lecture _value;
  // ignore: unused_field
  final $Res Function(Lecture) _then;

  @override
  $Res call({
    Object? metaData = freezed,
    Object? statusText = freezed,
    Object? credit = freezed,
    Object? finalGrade = freezed,
    Object? initialFinalGrade = freezed,
    Object? duplicated = freezed,
    Object? gradeList = freezed,
    Object? detailList = freezed,
  }) {
    return _then(_value.copyWith(
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as LectureMetadata,
      statusText: statusText == freezed
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String?,
      credit: credit == freezed
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as double?,
      finalGrade: finalGrade == freezed
          ? _value.finalGrade
          : finalGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      initialFinalGrade: initialFinalGrade == freezed
          ? _value.initialFinalGrade
          : initialFinalGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      duplicated: duplicated == freezed
          ? _value.duplicated
          : duplicated // ignore: cast_nullable_to_non_nullable
              as bool,
      gradeList: gradeList == freezed
          ? _value.gradeList
          : gradeList // ignore: cast_nullable_to_non_nullable
              as List<LectureGrade>?,
      detailList: detailList == freezed
          ? _value.detailList
          : detailList // ignore: cast_nullable_to_non_nullable
              as List<LectureDetail>?,
    ));
  }

  @override
  $LectureMetadataCopyWith<$Res> get metaData {
    return $LectureMetadataCopyWith<$Res>(_value.metaData, (value) {
      return _then(_value.copyWith(metaData: value));
    });
  }
}

/// @nodoc
abstract class _$LectureCopyWith<$Res> implements $LectureCopyWith<$Res> {
  factory _$LectureCopyWith(_Lecture value, $Res Function(_Lecture) then) =
      __$LectureCopyWithImpl<$Res>;
  @override
  $Res call(
      {LectureMetadata metaData,
      String? statusText,
      double? credit,
      String? finalGrade,
      String? initialFinalGrade,
      bool duplicated,
      List<LectureGrade>? gradeList,
      List<LectureDetail>? detailList});

  @override
  $LectureMetadataCopyWith<$Res> get metaData;
}

/// @nodoc
class __$LectureCopyWithImpl<$Res> extends _$LectureCopyWithImpl<$Res>
    implements _$LectureCopyWith<$Res> {
  __$LectureCopyWithImpl(_Lecture _value, $Res Function(_Lecture) _then)
      : super(_value, (v) => _then(v as _Lecture));

  @override
  _Lecture get _value => super._value as _Lecture;

  @override
  $Res call({
    Object? metaData = freezed,
    Object? statusText = freezed,
    Object? credit = freezed,
    Object? finalGrade = freezed,
    Object? initialFinalGrade = freezed,
    Object? duplicated = freezed,
    Object? gradeList = freezed,
    Object? detailList = freezed,
  }) {
    return _then(_Lecture(
      metaData: metaData == freezed
          ? _value.metaData
          : metaData // ignore: cast_nullable_to_non_nullable
              as LectureMetadata,
      statusText: statusText == freezed
          ? _value.statusText
          : statusText // ignore: cast_nullable_to_non_nullable
              as String?,
      credit: credit == freezed
          ? _value.credit
          : credit // ignore: cast_nullable_to_non_nullable
              as double?,
      finalGrade: finalGrade == freezed
          ? _value.finalGrade
          : finalGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      initialFinalGrade: initialFinalGrade == freezed
          ? _value.initialFinalGrade
          : initialFinalGrade // ignore: cast_nullable_to_non_nullable
              as String?,
      duplicated: duplicated == freezed
          ? _value.duplicated
          : duplicated // ignore: cast_nullable_to_non_nullable
              as bool,
      gradeList: gradeList == freezed
          ? _value.gradeList
          : gradeList // ignore: cast_nullable_to_non_nullable
              as List<LectureGrade>?,
      detailList: detailList == freezed
          ? _value.detailList
          : detailList // ignore: cast_nullable_to_non_nullable
              as List<LectureDetail>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Lecture with DiagnosticableTreeMixin implements _Lecture {
  _$_Lecture(
      {required this.metaData,
      this.statusText,
      this.credit,
      this.finalGrade,
      this.initialFinalGrade,
      this.duplicated = false,
      this.gradeList,
      this.detailList});

  factory _$_Lecture.fromJson(Map<String, dynamic> json) =>
      _$$_LectureFromJson(json);

  @override
  final LectureMetadata metaData;
  @override
  final String? statusText;
  @override
  final double? credit;
  @override
  final String? finalGrade;
  @override
  final String? initialFinalGrade;
  @JsonKey(defaultValue: false)
  @override
  final bool duplicated;
  @override
  final List<LectureGrade>? gradeList;
  @override
  final List<LectureDetail>? detailList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Lecture(metaData: $metaData, statusText: $statusText, credit: $credit, finalGrade: $finalGrade, initialFinalGrade: $initialFinalGrade, duplicated: $duplicated, gradeList: $gradeList, detailList: $detailList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Lecture'))
      ..add(DiagnosticsProperty('metaData', metaData))
      ..add(DiagnosticsProperty('statusText', statusText))
      ..add(DiagnosticsProperty('credit', credit))
      ..add(DiagnosticsProperty('finalGrade', finalGrade))
      ..add(DiagnosticsProperty('initialFinalGrade', initialFinalGrade))
      ..add(DiagnosticsProperty('duplicated', duplicated))
      ..add(DiagnosticsProperty('gradeList', gradeList))
      ..add(DiagnosticsProperty('detailList', detailList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Lecture &&
            (identical(other.metaData, metaData) ||
                const DeepCollectionEquality()
                    .equals(other.metaData, metaData)) &&
            (identical(other.statusText, statusText) ||
                const DeepCollectionEquality()
                    .equals(other.statusText, statusText)) &&
            (identical(other.credit, credit) ||
                const DeepCollectionEquality().equals(other.credit, credit)) &&
            (identical(other.finalGrade, finalGrade) ||
                const DeepCollectionEquality()
                    .equals(other.finalGrade, finalGrade)) &&
            (identical(other.initialFinalGrade, initialFinalGrade) ||
                const DeepCollectionEquality()
                    .equals(other.initialFinalGrade, initialFinalGrade)) &&
            (identical(other.duplicated, duplicated) ||
                const DeepCollectionEquality()
                    .equals(other.duplicated, duplicated)) &&
            (identical(other.gradeList, gradeList) ||
                const DeepCollectionEquality()
                    .equals(other.gradeList, gradeList)) &&
            (identical(other.detailList, detailList) ||
                const DeepCollectionEquality()
                    .equals(other.detailList, detailList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(metaData) ^
      const DeepCollectionEquality().hash(statusText) ^
      const DeepCollectionEquality().hash(credit) ^
      const DeepCollectionEquality().hash(finalGrade) ^
      const DeepCollectionEquality().hash(initialFinalGrade) ^
      const DeepCollectionEquality().hash(duplicated) ^
      const DeepCollectionEquality().hash(gradeList) ^
      const DeepCollectionEquality().hash(detailList);

  @JsonKey(ignore: true)
  @override
  _$LectureCopyWith<_Lecture> get copyWith =>
      __$LectureCopyWithImpl<_Lecture>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureToJson(this);
  }
}

abstract class _Lecture implements Lecture {
  factory _Lecture(
      {required LectureMetadata metaData,
      String? statusText,
      double? credit,
      String? finalGrade,
      String? initialFinalGrade,
      bool duplicated,
      List<LectureGrade>? gradeList,
      List<LectureDetail>? detailList}) = _$_Lecture;

  factory _Lecture.fromJson(Map<String, dynamic> json) = _$_Lecture.fromJson;

  @override
  LectureMetadata get metaData => throw _privateConstructorUsedError;
  @override
  String? get statusText => throw _privateConstructorUsedError;
  @override
  double? get credit => throw _privateConstructorUsedError;
  @override
  String? get finalGrade => throw _privateConstructorUsedError;
  @override
  String? get initialFinalGrade => throw _privateConstructorUsedError;
  @override
  bool get duplicated => throw _privateConstructorUsedError;
  @override
  List<LectureGrade>? get gradeList => throw _privateConstructorUsedError;
  @override
  List<LectureDetail>? get detailList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LectureCopyWith<_Lecture> get copyWith =>
      throw _privateConstructorUsedError;
}
