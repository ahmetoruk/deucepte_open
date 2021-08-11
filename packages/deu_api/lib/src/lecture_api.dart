import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html;

import 'package:deu_api/src/api.dart';
import 'package:deu_api/src/helpers/encoding_helper.dart';
import 'package:deu_api/src/models/lecture.dart';
import 'package:deu_api/src/models/lecture_detail.dart';
import 'package:deu_api/src/models/lecture_grade.dart';
import 'package:deu_api/src/models/lecture_metadata.dart';

class LectureApi {
  LectureApi(this.client);

  final DeuClient client;

  Future<List<Lecture>> fetchLectureList(int semesterId) async {
    final fetchedLectureList = <Lecture>[];
    final response = await client.post(
      'https://debis.deu.edu.tr/OgrenciIsleri/Ogrenci/OgrenciNotu/index.php',
      data: {'ogretim_donemi_id': semesterId},
      options: Options(
          contentType: 'application/x-www-form-urlencoded',
          responseType: ResponseType.bytes),
    );
    final requestData = customEncode(response);
    final optionList = html
        .parse(requestData)
        .querySelector('#ders')!
        .querySelectorAll('option');
    optionList.removeAt(0);
    for (final optionElement in optionList) {
      final name = optionElement.innerHtml;
      final uniqueId = optionElement.attributes['value']!;
      final uniqueIdList = uniqueId.split('_');
      final lectureId = uniqueIdList[3] + '_' + uniqueIdList[4];
      final success = uniqueIdList[0];
      final metaGrade = uniqueIdList[1];

      final lectureMetaData = LectureMetadata(
          uniqueId: uniqueId,
          lectureId: lectureId,
          semesterId: semesterId,
          name: name,
          success: success,
          metaGrade: metaGrade);
      final lecture = Lecture(metaData: lectureMetaData);
      fetchedLectureList.add(lecture);
    }
    return fetchedLectureList;
  }

  Future<Lecture> fetchLectureDetail(Lecture lecture) async {
    final response = await client.post(
        'https://debis.deu.edu.tr/OgrenciIsleri/Ogrenci/OgrenciNotu/index.php',
        data: {
          'ders': lecture.metaData.uniqueId,
          'ogretim_donemi_id': lecture.metaData.semesterId.toString()
        },
        options: Options(
            contentType: 'application/x-www-form-urlencoded',
            responseType: ResponseType.bytes));
    final requestData = customEncode(response);
    final newGrades = <LectureGrade>[];
    final newDetails = <LectureDetail>[];
    final document = html.parse(requestData);
    final tableElement = document.querySelectorAll('table')[6];
    final gradeElements =
        tableElement.querySelectorAll('table')[1].querySelectorAll('tr');
    final detailTableElement = tableElement.querySelectorAll('table').first;
    final creditString =
        detailTableElement.querySelectorAll('td')[11].innerHtml;
    final status = tableElement.querySelectorAll('tr').last.text.trim();
    for (final trElement in detailTableElement.querySelectorAll('tr')) {
      final tdDetailElementList = trElement.querySelectorAll('td');
      final title = tdDetailElementList[0].text.trim();
      newDetails.add(LectureDetail(
          name: (title == 'ÖĞRETİM GÖREVLİSİ' ? 'ÖĞR. GÖREVLİSİ' : title),
          detail: tdDetailElementList[2].text.replaceFirst('(', '\n(')));
    }
    gradeElements.removeAt(0);
    for (final trElement in gradeElements) {
      final tdGradeElementList = trElement.querySelectorAll('td');
      newGrades.add(LectureGrade(
          name: tdGradeElementList[0].innerHtml,
          announceDate: tdGradeElementList[1].innerHtml,
          classAverage: tdGradeElementList[2].innerHtml,
          note: tdGradeElementList[4].innerHtml));
    }
    final credit = double.parse(creditString.replaceAll(',', '.'));
    var letterNote = '';
    try {
      final grade = newGrades.firstWhere((LectureGrade lectureGrade) =>
          lectureGrade.name.contains('Yarıyıl Sonu') ||
          lectureGrade.name.contains('Başarı'));
      letterNote = grade.note.replaceAll(' ', '');
    } catch (_) {}
    return lecture.copyWith(
        statusText: status,
        credit: credit,
        gradeList: newGrades,
        detailList: newDetails,
        finalGrade: letterNote,
        initialFinalGrade: letterNote);
  }
}
