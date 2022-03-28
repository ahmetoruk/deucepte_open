// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lecture_grade.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LectureGrade _$LectureGradeFromJson(Map<String, dynamic> json) {
  return _LectureGrade.fromJson(json);
}

/// @nodoc
class _$LectureGradeTearOff {
  const _$LectureGradeTearOff();

  _LectureGrade call(
      {required String name,
      required String announceDate,
      required String classAverage,
      required String note}) {
    return _LectureGrade(
      name: name,
      announceDate: announceDate,
      classAverage: classAverage,
      note: note,
    );
  }

  LectureGrade fromJson(Map<String, Object> json) {
    return LectureGrade.fromJson(json);
  }
}

/// @nodoc
const $LectureGrade = _$LectureGradeTearOff();

/// @nodoc
mixin _$LectureGrade {
  String get name => throw _privateConstructorUsedError;
  String get announceDate => throw _privateConstructorUsedError;
  String get classAverage => throw _privateConstructorUsedError;
  String get note => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureGradeCopyWith<LectureGrade> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureGradeCopyWith<$Res> {
  factory $LectureGradeCopyWith(
          LectureGrade value, $Res Function(LectureGrade) then) =
      _$LectureGradeCopyWithImpl<$Res>;
  $Res call(
      {String name, String announceDate, String classAverage, String note});
}

/// @nodoc
class _$LectureGradeCopyWithImpl<$Res> implements $LectureGradeCopyWith<$Res> {
  _$LectureGradeCopyWithImpl(this._value, this._then);

  final LectureGrade _value;
  // ignore: unused_field
  final $Res Function(LectureGrade) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? announceDate = freezed,
    Object? classAverage = freezed,
    Object? note = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      announceDate: announceDate == freezed
          ? _value.announceDate
          : announceDate // ignore: cast_nullable_to_non_nullable
              as String,
      classAverage: classAverage == freezed
          ? _value.classAverage
          : classAverage // ignore: cast_nullable_to_non_nullable
              as String,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LectureGradeCopyWith<$Res>
    implements $LectureGradeCopyWith<$Res> {
  factory _$LectureGradeCopyWith(
          _LectureGrade value, $Res Function(_LectureGrade) then) =
      __$LectureGradeCopyWithImpl<$Res>;
  @override
  $Res call(
      {String name, String announceDate, String classAverage, String note});
}

/// @nodoc
class __$LectureGradeCopyWithImpl<$Res> extends _$LectureGradeCopyWithImpl<$Res>
    implements _$LectureGradeCopyWith<$Res> {
  __$LectureGradeCopyWithImpl(
      _LectureGrade _value, $Res Function(_LectureGrade) _then)
      : super(_value, (v) => _then(v as _LectureGrade));

  @override
  _LectureGrade get _value => super._value as _LectureGrade;

  @override
  $Res call({
    Object? name = freezed,
    Object? announceDate = freezed,
    Object? classAverage = freezed,
    Object? note = freezed,
  }) {
    return _then(_LectureGrade(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      announceDate: announceDate == freezed
          ? _value.announceDate
          : announceDate // ignore: cast_nullable_to_non_nullable
              as String,
      classAverage: classAverage == freezed
          ? _value.classAverage
          : classAverage // ignore: cast_nullable_to_non_nullable
              as String,
      note: note == freezed
          ? _value.note
          : note // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LectureGrade with DiagnosticableTreeMixin implements _LectureGrade {
  _$_LectureGrade(
      {required this.name,
      required this.announceDate,
      required this.classAverage,
      required this.note});

  factory _$_LectureGrade.fromJson(Map<String, dynamic> json) =>
      _$$_LectureGradeFromJson(json);

  @override
  final String name;
  @override
  final String announceDate;
  @override
  final String classAverage;
  @override
  final String note;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LectureGrade(name: $name, announceDate: $announceDate, classAverage: $classAverage, note: $note)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LectureGrade'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('announceDate', announceDate))
      ..add(DiagnosticsProperty('classAverage', classAverage))
      ..add(DiagnosticsProperty('note', note));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LectureGrade &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.announceDate, announceDate) ||
                const DeepCollectionEquality()
                    .equals(other.announceDate, announceDate)) &&
            (identical(other.classAverage, classAverage) ||
                const DeepCollectionEquality()
                    .equals(other.classAverage, classAverage)) &&
            (identical(other.note, note) ||
                const DeepCollectionEquality().equals(other.note, note)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(announceDate) ^
      const DeepCollectionEquality().hash(classAverage) ^
      const DeepCollectionEquality().hash(note);

  @JsonKey(ignore: true)
  @override
  _$LectureGradeCopyWith<_LectureGrade> get copyWith =>
      __$LectureGradeCopyWithImpl<_LectureGrade>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureGradeToJson(this);
  }
}

abstract class _LectureGrade implements LectureGrade {
  factory _LectureGrade(
      {required String name,
      required String announceDate,
      required String classAverage,
      required String note}) = _$_LectureGrade;

  factory _LectureGrade.fromJson(Map<String, dynamic> json) =
      _$_LectureGrade.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get announceDate => throw _privateConstructorUsedError;
  @override
  String get classAverage => throw _privateConstructorUsedError;
  @override
  String get note => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LectureGradeCopyWith<_LectureGrade> get copyWith =>
      throw _privateConstructorUsedError;
}
