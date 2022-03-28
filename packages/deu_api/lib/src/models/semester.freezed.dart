// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'semester.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$SemesterTearOff {
  const _$SemesterTearOff();

  _Semester call({required int id, required String name, double? average}) {
    return _Semester(
      id: id,
      name: name,
      average: average,
    );
  }
}

/// @nodoc
const $Semester = _$SemesterTearOff();

/// @nodoc
mixin _$Semester {
  int get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double? get average => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $SemesterCopyWith<Semester> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SemesterCopyWith<$Res> {
  factory $SemesterCopyWith(Semester value, $Res Function(Semester) then) =
      _$SemesterCopyWithImpl<$Res>;
  $Res call({int id, String name, double? average});
}

/// @nodoc
class _$SemesterCopyWithImpl<$Res> implements $SemesterCopyWith<$Res> {
  _$SemesterCopyWithImpl(this._value, this._then);

  final Semester _value;
  // ignore: unused_field
  final $Res Function(Semester) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? average = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      average: average == freezed
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
abstract class _$SemesterCopyWith<$Res> implements $SemesterCopyWith<$Res> {
  factory _$SemesterCopyWith(_Semester value, $Res Function(_Semester) then) =
      __$SemesterCopyWithImpl<$Res>;
  @override
  $Res call({int id, String name, double? average});
}

/// @nodoc
class __$SemesterCopyWithImpl<$Res> extends _$SemesterCopyWithImpl<$Res>
    implements _$SemesterCopyWith<$Res> {
  __$SemesterCopyWithImpl(_Semester _value, $Res Function(_Semester) _then)
      : super(_value, (v) => _then(v as _Semester));

  @override
  _Semester get _value => super._value as _Semester;

  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? average = freezed,
  }) {
    return _then(_Semester(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int,
      name: name == freezed
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      average: average == freezed
          ? _value.average
          : average // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc

class _$_Semester with DiagnosticableTreeMixin implements _Semester {
  _$_Semester({required this.id, required this.name, this.average});

  @override
  final int id;
  @override
  final String name;
  @override
  final double? average;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Semester(id: $id, name: $name, average: $average)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Semester'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('average', average));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Semester &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.average, average) ||
                const DeepCollectionEquality().equals(other.average, average)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(average);

  @JsonKey(ignore: true)
  @override
  _$SemesterCopyWith<_Semester> get copyWith =>
      __$SemesterCopyWithImpl<_Semester>(this, _$identity);
}

abstract class _Semester implements Semester {
  factory _Semester({required int id, required String name, double? average}) =
      _$_Semester;

  @override
  int get id => throw _privateConstructorUsedError;
  @override
  String get name => throw _privateConstructorUsedError;
  @override
  double? get average => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$SemesterCopyWith<_Semester> get copyWith =>
      throw _privateConstructorUsedError;
}
