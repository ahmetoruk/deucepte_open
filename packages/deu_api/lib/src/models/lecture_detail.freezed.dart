// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'lecture_detail.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LectureDetail _$LectureDetailFromJson(Map<String, dynamic> json) {
  return _LectureDetail.fromJson(json);
}

/// @nodoc
class _$LectureDetailTearOff {
  const _$LectureDetailTearOff();

  _LectureDetail call({required String name, required String detail}) {
    return _LectureDetail(
      name: name,
      detail: detail,
    );
  }

  LectureDetail fromJson(Map<String, Object> json) {
    return LectureDetail.fromJson(json);
  }
}

/// @nodoc
const $LectureDetail = _$LectureDetailTearOff();

/// @nodoc
mixin _$LectureDetail {
  String get name => throw _privateConstructorUsedError;
  String get detail => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LectureDetailCopyWith<LectureDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LectureDetailCopyWith<$Res> {
  factory $LectureDetailCopyWith(
          LectureDetail value, $Res Function(LectureDetail) then) =
      _$LectureDetailCopyWithImpl<$Res>;
  $Res call({String name, String detail});
}

/// @nodoc
class _$LectureDetailCopyWithImpl<$Res>
    implements $LectureDetailCopyWith<$Res> {
  _$LectureDetailCopyWithImpl(this._value, this._then);

  final LectureDetail _value;
  // ignore: unused_field
  final $Res Function(LectureDetail) _then;

  @override
  $Res call({
    Object? name = freezed,
    Object? detail = freezed,
  }) {
    return _then(_value.copyWith(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      detail: detail == freezed
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
abstract class _$LectureDetailCopyWith<$Res>
    implements $LectureDetailCopyWith<$Res> {
  factory _$LectureDetailCopyWith(
          _LectureDetail value, $Res Function(_LectureDetail) then) =
      __$LectureDetailCopyWithImpl<$Res>;
  @override
  $Res call({String name, String detail});
}

/// @nodoc
class __$LectureDetailCopyWithImpl<$Res>
    extends _$LectureDetailCopyWithImpl<$Res>
    implements _$LectureDetailCopyWith<$Res> {
  __$LectureDetailCopyWithImpl(
      _LectureDetail _value, $Res Function(_LectureDetail) _then)
      : super(_value, (v) => _then(v as _LectureDetail));

  @override
  _LectureDetail get _value => super._value as _LectureDetail;

  @override
  $Res call({
    Object? name = freezed,
    Object? detail = freezed,
  }) {
    return _then(_LectureDetail(
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      detail: detail == freezed
          ? _value.detail
          : detail // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LectureDetail with DiagnosticableTreeMixin implements _LectureDetail {
  _$_LectureDetail({required this.name, required this.detail});

  factory _$_LectureDetail.fromJson(Map<String, dynamic> json) =>
      _$$_LectureDetailFromJson(json);

  @override
  final String name;
  @override
  final String detail;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'LectureDetail(name: $name, detail: $detail)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'LectureDetail'))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('detail', detail));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _LectureDetail &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.detail, detail) ||
                const DeepCollectionEquality().equals(other.detail, detail)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(detail);

  @JsonKey(ignore: true)
  @override
  _$LectureDetailCopyWith<_LectureDetail> get copyWith =>
      __$LectureDetailCopyWithImpl<_LectureDetail>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LectureDetailToJson(this);
  }
}

abstract class _LectureDetail implements LectureDetail {
  factory _LectureDetail({required String name, required String detail}) =
      _$_LectureDetail;

  factory _LectureDetail.fromJson(Map<String, dynamic> json) =
      _$_LectureDetail.fromJson;

  @override
  String get name => throw _privateConstructorUsedError;
  @override
  String get detail => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$LectureDetailCopyWith<_LectureDetail> get copyWith =>
      throw _privateConstructorUsedError;
}
