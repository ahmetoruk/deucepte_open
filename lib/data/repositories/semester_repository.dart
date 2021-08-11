import 'package:deu_api/deu_api.dart' show Semester, SemesterApi;

abstract class ISemesterMemoryStorage {
  void saveSemesters(List<Semester> semesters);
  Future<List<Semester>> getSemesters();
}

class SemesterMemoryStorage implements ISemesterMemoryStorage {
  List<Semester> _semesters = [];

  @override
  void saveSemesters(List<Semester> semesters) async {
    _semesters = semesters;
  }

  @override
  Future<List<Semester>> getSemesters() async {
    return _semesters;
  }
}

abstract class ISemesterRepository {
  void saveSemesters(List<Semester> semesters);
  Future<List<Semester>> getSemesters();
  Future<List<Semester>> getSemestersCache();
}

class SemesterRepository implements ISemesterRepository {
  SemesterRepository(this.semesterApi)
      : _semesterMemoryStorage = SemesterMemoryStorage();

  final SemesterApi semesterApi;
  final SemesterMemoryStorage _semesterMemoryStorage;

  @override
  Future<List<Semester>> getSemesters() async {
    final cachedSemesters = await getSemestersCache();
    if (cachedSemesters.isNotEmpty) return cachedSemesters;
    final semesters = await semesterApi.fetchSemesters();
    saveSemesters(semesters);
    return semesters;
  }

  @override
  Future<List<Semester>> getSemestersCache() async {
    return await _semesterMemoryStorage.getSemesters();
  }

  @override
  void saveSemesters(List<Semester> semesters) {
    _semesterMemoryStorage.saveSemesters(semesters);
  }
}
