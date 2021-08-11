import 'package:dio/dio.dart';
import 'package:html/dom.dart';
import 'package:html/parser.dart' as html;

import 'package:deu_api/src/api.dart';
import 'package:deu_api/src/helpers/encoding_helper.dart';
import 'package:deu_api/src/models/schedule_text_container.dart';

class ScheduleApi {
  ScheduleApi(this.client);

  final DeuClient client;

  Future<List<List<List<ScheduleTextContainer>>>> fetchSchuduleTable() async {
    final scheduleTable = <List<List<ScheduleTextContainer>>>[];
    var isLectureRoom = false;
    final response = await client.get(
      'https://debis.deu.edu.tr/OgrenciIsleri/Ogrenci/DersProgrami/index.php',
      options: Options(responseType: ResponseType.bytes),
    );
    final requestData = customEncode(response);
    final trElements = html
        .parse(requestData)
        .querySelectorAll('table')[6]
        .children[0]
        .children
      ..removeAt(0);
    for (final trElement in trElements) {
      final row = <List<ScheduleTextContainer>>[];
      for (final fontElement in trElement.querySelectorAll('font')) {
        isLectureRoom = false;
        final cell = <ScheduleTextContainer>[];
        for (final node in fontElement.nodes) {
          if (node.nodeType == Node.ELEMENT_NODE) {
            if (node.toString() == '<html b>') {
              if (node.text == 'Derslik:') {
                cell.add(
                  ScheduleTextContainer(
                      text: 'Derslik', bold: true, isLectureRoom: false),
                );
                isLectureRoom = true;
              } else {
                cell.add(
                  ScheduleTextContainer(
                      text: node.text ?? '', bold: true, isLectureRoom: false),
                );
              }
            }
          } else if (node.nodeType == Node.TEXT_NODE) {
            cell.add(ScheduleTextContainer(
                text: node.text ?? '',
                bold: false,
                isLectureRoom: isLectureRoom));
            if (isLectureRoom) {
              isLectureRoom = false;
            }
          }
        }
        row.add(cell);
      }
      scheduleTable.add(row);
    }
    return scheduleTable;
  }
}
