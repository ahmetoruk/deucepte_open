import 'dart:convert' show utf8;

import 'package:dio/dio.dart' show Response;

import 'package:deu_api/src/extensions/int_list.dart';

String customEncode(Response response) {
  var type =
      response.headers.map['content-type']!.first.split('=')[1].toLowerCase();
  var reponseBytes = response.data as List<int>;
  return type == 'utf-8'
      ? utf8.decode(reponseBytes, allowMalformed: true)
      : reponseBytes.latin9;
}
