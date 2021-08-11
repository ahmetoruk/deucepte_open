import 'dart:convert';

import 'package:deu_api/deu_api.dart' show Lecture, LectureApi;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/data/repositories/lecture_repository.dart';

abstract class IAverageLocalStorage {
  Lecture? getAverageLectureDetail(Lecture lecture);
  void saveLectureDetail(Lecture lectures);
}

class AverageLocalStorage implements IAverageLocalStorage {
  AverageLocalStorage(this.sharedPreferences);

  final SharedPreferences sharedPreferences;

  @override
  Lecture? getAverageLectureDetail(Lecture lecture) {
    final lectureJson =
        sharedPreferences.getString('ders__${lecture.metaData.uniqueId}');
    if (lectureJson != null) {
      final json = jsonDecode(lectureJson) as Map<String, dynamic>;
      return Lecture.fromJson(json);
    }

    return null;
  }

  @override
  void saveLectureDetail(Lecture lecture) {
    sharedPreferences.setString(
        'ders__${lecture.metaData.uniqueId}', jsonEncode(lecture));
  }
}

abstract class IAverageRepository {
  Lecture? getAverageLectureDetail(Lecture lecture);
  void saveLectureDetail(Lecture lectures);
}

class AverageRepository extends LectureRepository
    implements IAverageRepository {
  AverageRepository(LectureApi lectureApi, SharedPreferences sharedPreferences)
      : averageLocalStorage = AverageLocalStorage(sharedPreferences),
        super(lectureApi);

  final AverageLocalStorage averageLocalStorage;

  @override
  void saveLectureDetail(Lecture lecture) {
    averageLocalStorage.saveLectureDetail(lecture);
  }

  @override
  Lecture? getAverageLectureDetail(Lecture lecture) {
    return averageLocalStorage.getAverageLectureDetail(lecture);
  }
}
