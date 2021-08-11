import 'package:flutter/material.dart';

import 'package:deu_api/deu_api.dart' show Lecture, Semester;

extension SemesterExtension on List<Lecture> {
  List<Lecture> filterBySemester(Semester semester) {
    return where(
            (Lecture lecture) => lecture.metaData.semesterId == semester.id)
        .toList();
  }
}

extension LectureExtension on Lecture {
  Color? get averageColor {
    final status = statusText!.toUpperCase();
    if (status == 'ALIYOR') {
      return Colors.green;
    } else if (status.contains('KAL')) {
      return Colors.orange;
    } else {
      return null;
    }
  }
}
