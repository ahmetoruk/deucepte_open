import 'package:flutter/foundation.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'semester.freezed.dart';

@freezed
class Semester with _$Semester {
  factory Semester({required int id, required String name, double? average}) =
      _Semester;

  static final empty = Semester(id: -1, name: '');
}
