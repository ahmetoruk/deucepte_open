import 'package:deu_api/deu_api.dart' show Lecture, LectureApi, Semester;

abstract class ILectureMemoryStorage {
  Future<List<Lecture>> getLectures(Semester semester);
  void saveLectures(List<Lecture> lectures);
}

class LectureMemoryStorage implements ILectureMemoryStorage {
  final List<Lecture> _lectures = [];

  @override
  Future<List<Lecture>> getLectures(Semester? semester) async {
    return semester != null
        ? _lectures
            .where((elem) => elem.metaData.semesterId == semester.id)
            .toList()
        : _lectures;
  }

  @override
  void saveLectures(List<Lecture> lectures) {
    return _lectures.addAll(lectures);
  }
}

abstract class ILectureRepository {
  Future<List<Lecture>> getLectures(Semester semester);
  Future<Lecture> getLectureDetail(Lecture lecture);
  Future<List<Lecture>> getLecturesCache(Semester semester);
  Future<List<Lecture>> getAllLectures();
  void saveLectures(List<Lecture> lectures);
}

class LectureRepository implements ILectureRepository {
  LectureRepository(this.lectureApi)
      : _lectureMemoryStorage = LectureMemoryStorage();

  final LectureApi lectureApi;
  final LectureMemoryStorage _lectureMemoryStorage;

  @override
  Future<List<Lecture>> getLectures(Semester semester) async {
    var lectures = await getLecturesCache(semester);
    if (lectures.isEmpty) {
      lectures = await lectureApi.fetchLectureList(semester.id);
    }
    _lectureMemoryStorage.saveLectures(lectures);
    return lectures;
  }

  @override
  Future<Lecture> getLectureDetail(Lecture lecture) async {
    return await lectureApi.fetchLectureDetail(lecture);
  }

  @override
  Future<List<Lecture>> getLecturesCache(Semester semester) async {
    return await _lectureMemoryStorage.getLectures(semester);
  }

  @override
  void saveLectures(List<Lecture> lectures) {
    _lectureMemoryStorage.saveLectures(lectures);
  }

  @override
  Future<List<Lecture>> getAllLectures() async {
    return await _lectureMemoryStorage.getLectures(null);
  }
}
