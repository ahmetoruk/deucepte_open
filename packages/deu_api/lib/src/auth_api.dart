import 'package:dio/dio.dart';
import 'package:html/parser.dart' as html;

import 'package:deu_api/src/api.dart';
import 'package:deu_api/src/helpers/encoding_helper.dart';

class AuthenticationException implements Exception {}

class AuthApi {
  AuthApi(this.client);

  final DeuClient client;

  Future<bool> login(String username, String password) async {
    username = username.toLowerCase();
    final response = await client.post(
      'https://debis.deu.edu.tr/debis.php',
      data: {
        'username': username,
        'emailHost': 'ogr.deu.edu.tr',
        'password': password,
      },
      options: Options(
        contentType: 'application/x-www-form-urlencoded',
        responseType: ResponseType.bytes,
      ),
    );
    final requestData = customEncode(response);
    final userNameElement = html.parse(requestData).querySelector('div > div');
    if (userNameElement == null) {
      throw AuthenticationException();
    }
    return true;
  }
}
