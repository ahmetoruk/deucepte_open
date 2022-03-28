// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lecture_metadata.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LectureMetadata _$LectureMetadataFromJson(Map<String, dynamic> json) {
  return _LectureMetadata.fromJson(json);
}

/// @nodoc
class _$LectureMetadataTearOff {
  const _$LectureMetadataTearOff();

  _LectureMetadata call(
      {required String uniqueId,
      required String lectureId,
      required int semesterId,
      required String name,
      required String success,
      required String metaGrade}) {
    return _LectureMetadata(
      uniqueId: uniqueId,
      lectureId: lectureId,
      semesterId: semesterId,
      name: name,
      success: success,
      metaGrade: metaGrade,
    );
  }

  LectureMetadata fromJson(Map<String, Object> json) {
    return LectureMetadata.fromJson(json);
  }
}

/// @nodoc
const $LectureMetadata = _$LectureMetadataTearOff();

/// @nodoc
mixin _$LectureMetadata {
  String get uniqueId => throw _privateConstructorUsedError;
  String get lectureId => throw _privateConstructorUsedError;
  int get semesterId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get success => throw _privateConstructorUsedError;
  String get metaGrade => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureMetadataCopyWith<LectureMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureMetadataCopyWith<$Res> {
  factory $LectureMetadataCopyWith(
          LectureMetadata value, $Res Function(LectureMetadata) then) =
      _$LectureMetadataCopyWithImpl<$Res>;
  $Res call(
      {String uniqueId,
      String lectureId,
      int semesterId,
      String name,
      String success,
      String metaGrade});
}

/// @nodoc
class _$LectureMetadataCopyWithImpl<$Res>
    implements $LectureMetadataCopyWith<$Res> {
  _$LectureMetadataCopyWithImpl(this._value, this._then);

  final LectureMetadata _value;
  // ignore: unused_field
  final $Res Function(LectureMetadata) _then;

  @override
  $Res call({
    Object? uniqueId = freezed,
    Object? lectureId = freezed,
    Object? semesterId = freezed,
    Object? name = freezed,
    Object? success = freezed,
    Object? metaGrade = freezed,
  }) {
    return _then(_value.copyWith(
      uniqueId: uniqueId == freezed
          ? _value.uniqueId
          : uniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      lectureId: lectureId == freezed
          ? _value.lectureId
          : lectureId // ignore: cast_nullable_to_non_nullable
              as String,
      semesterId: semesterId == freezed
          ? _value.semesterId
          : semesterId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String,
      metaGrade: metaGrade == freezed
          ? _value.metaGrade
          : metaGrade // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LectureMetadataCopyWith<$Res>
    implements $LectureMetadataCopyWith<$Res> {
  factory _$LectureMetadataCopyWith(
          _LectureMetadata value, $Res Function(_LectureMetadata) then) =
      __$LectureMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uniqueId,
      String lectureId,
      int semesterId,
      String name,
      String success,
      String metaGrade});
}

/// @nodoc
class __$LectureMetadataCopyWithImpl<$Res>
    extends _$LectureMetadataCopyWithImpl<$Res>
    implements _$LectureMetadataCopyWith<$Res> {
  __$LectureMetadataCopyWithImpl(
      _LectureMetadata _value, $Res Function(_LectureMetadata) _then)
      : super(_value, (v) => _then(v as _LectureMetadata));

  @override
  _LectureMetadata get _value => super._value as _LectureMetadata;

  @override
  $Res call({
    Object? uniqueId = freezed,
    Object? lectureId = freezed,
    Object? semesterId = freezed,
    Object? name = freezed,
    Object? success = freezed,
    Object? metaGrade = freezed,
  }) {
    return _then(_LectureMetadata(
      uniqueId: uniqueId == freezed
          ? _value.uniqueId
          : uniqueId // ignore: cast_nullable_to_non_nullable
              as String,
      lectureId: lectureId == freezed
          ? _value.lectureId
          : lectureId // ignore: cast_nullable_to_non_nullable
              as String,
      semesterId: semesterId == freezed
          ? _value.semesterId
          : semesterId // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      success: success == freezed
          ? _value.success
          : success // ignore: cast_nullable_to_non_nullable
              as String,
      metaGrade: metaGrade == freezed
          ? _value.metaGrade
          : metaGrade // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LectureMetadata
    with DiagnosticableTreeMixin
    implements _LectureMetadata {
  _$_LectureMetadata(
      {required this.uniqueId,
      required this.lectureId,
      required this.semesterId,
      required this.name,
      required this.success,
      required this.metaGrade});

  factory _$_LectureMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_LectureMetadataFromJson(json);

  @override
  final String uniqueId;
  @override
  final String lectureId;
  @override
  final int semesterId;
  @override
  final String name;
  @override
  final String success;
  @override
  final String metaGrade;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LectureMetadata(uniqueId: $uniqueId, lectureId: $lectureId, semesterId: $semesterId, name: $name, success: $success, metaGrade: $metaGrade)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LectureMetadata'))
      ..add(DiagnosticsProperty('uniqueId', uniqueId))
      ..add(DiagnosticsProperty('lectureId', lectureId))
      ..add(DiagnosticsProperty('semesterId', semesterId))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('success', success))
      ..add(DiagnosticsProperty('metaGrade', metaGrade));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LectureMetadata &&
            (identical(other.uniqueId, uniqueId) ||
                const DeepCollectionEquality()
                    .equals(other.uniqueId, uniqueId)) &&
            (identical(other.lectureId, lectureId) ||
                const DeepCollectionEquality()
                    .equals(other.lectureId, lectureId)) &&
            (identical(other.semesterId, semesterId) ||
                const DeepCollectionEquality()
                    .equals(other.semesterId, semesterId)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.success, success) ||
                const DeepCollectionEquality()
                    .equals(other.success, success)) &&
            (identical(other.metaGrade, metaGrade) ||
                const DeepCollectionEquality()
                    .equals(other.metaGrade, metaGrade)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uniqueId) ^
      const DeepCollectionEquality().hash(lectureId) ^
      const DeepCollectionEquality().hash(semesterId) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(success) ^
      const DeepCollectionEquality().hash(metaGrade);

  @JsonKey(ignore: true)
  @override
  _$LectureMetadataCopyWith<_LectureMetadata> get copyWith =>
      __$LectureMetadataCopyWithImpl<_LectureMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureMetadataToJson(this);
  }
}

abstract class _LectureMetadata implements LectureMetadata {
  factory _LectureMetadata(
      {required String uniqueId,
      required String lectureId,
      required int semesterId,
      required String name,
      required String success,
      required String metaGrade}) = _$_LectureMetadata;

  factory _LectureMetadata.fromJson(Map<String, dynamic> json) =
      _$_LectureMetadata.fromJson;

  @override
  String get uniqueId => throw _privateConstructorUsedError;
  @override
  String get lectureId => throw _privateConstructorUsedError;
  @override
  int get semesterId => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get success => throw _privateConstructorUsedError;
  @override
  String get metaGrade => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LectureMetadataCopyWith<_LectureMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
