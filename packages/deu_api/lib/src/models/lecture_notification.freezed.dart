// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lecture_notification.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LectureNotification _$LectureNotificationFromJson(Map<String, dynamic> json) {
  return _LectureNotification.fromJson(json);
}

/// @nodoc
class _$LectureNotificationTearOff {
  const _$LectureNotificationTearOff();

  _LectureNotification call(
      {required Lecture lecture, required bool notified}) {
    return _LectureNotification(
      lecture: lecture,
      notified: notified,
    );
  }

  LectureNotification fromJson(Map<String, Object> json) {
    return LectureNotification.fromJson(json);
  }
}

/// @nodoc
const $LectureNotification = _$LectureNotificationTearOff();

/// @nodoc
mixin _$LectureNotification {
  Lecture get lecture => throw _privateConstructorUsedError;
  bool get notified => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureNotificationCopyWith<LectureNotification> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureNotificationCopyWith<$Res> {
  factory $LectureNotificationCopyWith(
          LectureNotification value, $Res Function(LectureNotification) then) =
      _$LectureNotificationCopyWithImpl<$Res>;
  $Res call({Lecture lecture, bool notified});

  $LectureCopyWith<$Res> get lecture;
}

/// @nodoc
class _$LectureNotificationCopyWithImpl<$Res>
    implements $LectureNotificationCopyWith<$Res> {
  _$LectureNotificationCopyWithImpl(this._value, this._then);

  final LectureNotification _value;
  // ignore: unused_field
  final $Res Function(LectureNotification) _then;

  @override
  $Res call({
    Object? lecture = freezed,
    Object? notified = freezed,
  }) {
    return _then(_value.copyWith(
      lecture: lecture == freezed
          ? _value.lecture
          : lecture // ignore: cast_nullable_to_non_nullable
              as Lecture,
      notified: notified == freezed
          ? _value.notified
          : notified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }

  @override
  $LectureCopyWith<$Res> get lecture {
    return $LectureCopyWith<$Res>(_value.lecture, (value) {
      return _then(_value.copyWith(lecture: value));
    });
  }
}

/// @nodoc
abstract class _$LectureNotificationCopyWith<$Res>
    implements $LectureNotificationCopyWith<$Res> {
  factory _$LectureNotificationCopyWith(_LectureNotification value,
          $Res Function(_LectureNotification) then) =
      __$LectureNotificationCopyWithImpl<$Res>;
  @override
  $Res call({Lecture lecture, bool notified});

  @override
  $LectureCopyWith<$Res> get lecture;
}

/// @nodoc
class __$LectureNotificationCopyWithImpl<$Res>
    extends _$LectureNotificationCopyWithImpl<$Res>
    implements _$LectureNotificationCopyWith<$Res> {
  __$LectureNotificationCopyWithImpl(
      _LectureNotification _value, $Res Function(_LectureNotification) _then)
      : super(_value, (v) => _then(v as _LectureNotification));

  @override
  _LectureNotification get _value => super._value as _LectureNotification;

  @override
  $Res call({
    Object? lecture = freezed,
    Object? notified = freezed,
  }) {
    return _then(_LectureNotification(
      lecture: lecture == freezed
          ? _value.lecture
          : lecture // ignore: cast_nullable_to_non_nullable
              as Lecture,
      notified: notified == freezed
          ? _value.notified
          : notified // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LectureNotification implements _LectureNotification {
  _$_LectureNotification({required this.lecture, required this.notified});

  factory _$_LectureNotification.fromJson(Map<String, dynamic> json) =>
      _$$_LectureNotificationFromJson(json);

  @override
  final Lecture lecture;
  @override
  final bool notified;

  @override
  String toString() {
    return 'LectureNotification(lecture: $lecture, notified: $notified)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LectureNotification &&
            (identical(other.lecture, lecture) ||
                const DeepCollectionEquality()
                    .equals(other.lecture, lecture)) &&
            (identical(other.notified, notified) ||
                const DeepCollectionEquality()
                    .equals(other.notified, notified)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(lecture) ^
      const DeepCollectionEquality().hash(notified);

  @JsonKey(ignore: true)
  @override
  _$LectureNotificationCopyWith<_LectureNotification> get copyWith =>
      __$LectureNotificationCopyWithImpl<_LectureNotification>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureNotificationToJson(this);
  }
}

abstract class _LectureNotification implements LectureNotification {
  factory _LectureNotification(
      {required Lecture lecture,
      required bool notified}) = _$_LectureNotification;

  factory _LectureNotification.fromJson(Map<String, dynamic> json) =
      _$_LectureNotification.fromJson;

  @override
  Lecture get lecture => throw _privateConstructorUsedError;
  @override
  bool get notified => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LectureNotificationCopyWith<_LectureNotification> get copyWith =>
      throw _privateConstructorUsedError;
}
