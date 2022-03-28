// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'schedule_text_container.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ScheduleTextContainer _$ScheduleTextContainerFromJson(
    Map<String, dynamic> json) {
  return _ScheduleTextContainer.fromJson(json);
}

/// @nodoc
class _$ScheduleTextContainerTearOff {
  const _$ScheduleTextContainerTearOff();

  _ScheduleTextContainer call(
      {required String text, required bool bold, required bool isLectureRoom}) {
    return _ScheduleTextContainer(
      text: text,
      bold: bold,
      isLectureRoom: isLectureRoom,
    );
  }

  ScheduleTextContainer fromJson(Map<String, Object> json) {
    return ScheduleTextContainer.fromJson(json);
  }
}

/// @nodoc
const $ScheduleTextContainer = _$ScheduleTextContainerTearOff();

/// @nodoc
mixin _$ScheduleTextContainer {
  String get text => throw _privateConstructorUsedError;
  bool get bold => throw _privateConstructorUsedError;
  bool get isLectureRoom => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ScheduleTextContainerCopyWith<ScheduleTextContainer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ScheduleTextContainerCopyWith<$Res> {
  factory $ScheduleTextContainerCopyWith(ScheduleTextContainer value,
          $Res Function(ScheduleTextContainer) then) =
      _$ScheduleTextContainerCopyWithImpl<$Res>;
  $Res call({String text, bool bold, bool isLectureRoom});
}

/// @nodoc
class _$ScheduleTextContainerCopyWithImpl<$Res>
    implements $ScheduleTextContainerCopyWith<$Res> {
  _$ScheduleTextContainerCopyWithImpl(this._value, this._then);

  final ScheduleTextContainer _value;
  // ignore: unused_field
  final $Res Function(ScheduleTextContainer) _then;

  @override
  $Res call({
    Object? text = freezed,
    Object? bold = freezed,
    Object? isLectureRoom = freezed,
  }) {
    return _then(_value.copyWith(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      bold: bold == freezed
          ? _value.bold
          : bold // ignore: cast_nullable_to_non_nullable
              as bool,
      isLectureRoom: isLectureRoom == freezed
          ? _value.isLectureRoom
          : isLectureRoom // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$ScheduleTextContainerCopyWith<$Res>
    implements $ScheduleTextContainerCopyWith<$Res> {
  factory _$ScheduleTextContainerCopyWith(_ScheduleTextContainer value,
          $Res Function(_ScheduleTextContainer) then) =
      __$ScheduleTextContainerCopyWithImpl<$Res>;
  @override
  $Res call({String text, bool bold, bool isLectureRoom});
}

/// @nodoc
class __$ScheduleTextContainerCopyWithImpl<$Res>
    extends _$ScheduleTextContainerCopyWithImpl<$Res>
    implements _$ScheduleTextContainerCopyWith<$Res> {
  __$ScheduleTextContainerCopyWithImpl(_ScheduleTextContainer _value,
      $Res Function(_ScheduleTextContainer) _then)
      : super(_value, (v) => _then(v as _ScheduleTextContainer));

  @override
  _ScheduleTextContainer get _value => super._value as _ScheduleTextContainer;

  @override
  $Res call({
    Object? text = freezed,
    Object? bold = freezed,
    Object? isLectureRoom = freezed,
  }) {
    return _then(_ScheduleTextContainer(
      text: text == freezed
          ? _value.text
          : text // ignore: cast_nullable_to_non_nullable
              as String,
      bold: bold == freezed
          ? _value.bold
          : bold // ignore: cast_nullable_to_non_nullable
              as bool,
      isLectureRoom: isLectureRoom == freezed
          ? _value.isLectureRoom
          : isLectureRoom // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ScheduleTextContainer implements _ScheduleTextContainer {
  _$_ScheduleTextContainer(
      {required this.text, required this.bold, required this.isLectureRoom});

  factory _$_ScheduleTextContainer.fromJson(Map<String, dynamic> json) =>
      _$$_ScheduleTextContainerFromJson(json);

  @override
  final String text;
  @override
  final bool bold;
  @override
  final bool isLectureRoom;

  @override
  String toString() {
    return 'ScheduleTextContainer(text: $text, bold: $bold, isLectureRoom: $isLectureRoom)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _ScheduleTextContainer &&
            (identical(other.text, text) ||
                const DeepCollectionEquality().equals(other.text, text)) &&
            (identical(other.bold, bold) ||
                const DeepCollectionEquality().equals(other.bold, bold)) &&
            (identical(other.isLectureRoom, isLectureRoom) ||
                const DeepCollectionEquality()
                    .equals(other.isLectureRoom, isLectureRoom)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(text) ^
      const DeepCollectionEquality().hash(bold) ^
      const DeepCollectionEquality().hash(isLectureRoom);

  @JsonKey(ignore: true)
  @override
  _$ScheduleTextContainerCopyWith<_ScheduleTextContainer> get copyWith =>
      __$ScheduleTextContainerCopyWithImpl<_ScheduleTextContainer>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ScheduleTextContainerToJson(this);
  }
}

abstract class _ScheduleTextContainer implements ScheduleTextContainer {
  factory _ScheduleTextContainer(
      {required String text,
      required bool bold,
      required bool isLectureRoom}) = _$_ScheduleTextContainer;

  factory _ScheduleTextContainer.fromJson(Map<String, dynamic> json) =
      _$_ScheduleTextContainer.fromJson;

  @override
  String get text => throw _privateConstructorUsedError;
  @override
  bool get bold => throw _privateConstructorUsedError;
  @override
  bool get isLectureRoom => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$ScheduleTextContainerCopyWith<_ScheduleTextContainer> get copyWith =>
      throw _privateConstructorUsedError;
}
