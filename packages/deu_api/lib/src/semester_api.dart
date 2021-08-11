import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html;

import 'package:deu_api/src/api.dart';
import 'package:deu_api/src/helpers/encoding_helper.dart';
import 'package:deu_api/src/models/semester.dart';

class SemesterApi {
  SemesterApi(this.client);

  final DeuClient client;

  Future<List<Semester>> fetchSemesters() async {
    final fetchedSemesters = <Semester>[];
    final response = await client.get(
      'https://debis.deu.edu.tr/OgrenciIsleri/Ogrenci/OgrenciNotu/index.php',
      options: Options(responseType: ResponseType.bytes),
    );
    final requestData = customEncode(response);
    final optionElements = html
        .parse(requestData)
        .querySelector('#ogretim_donemi_id')!
        .querySelectorAll('option');
    optionElements.removeAt(0);
    for (final optionElement in optionElements) {
      final id = int.parse(optionElement.attributes['value']!);
      final name = optionElement.innerHtml;
      final semester = Semester(id: id, name: name);
      fetchedSemesters.add(semester);
    }
    return fetchedSemesters;
  }
}
