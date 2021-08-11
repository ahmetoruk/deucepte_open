import 'dart:convert';

import 'package:dio/dio.dart';

import 'package:deu_api/src/api.dart';

class ReLoginInterceptor extends InterceptorsWrapper {
  ReLoginInterceptor(this.previous) {
    refreshDio.interceptors.add(previous.cookieManager);
  }

  final DeuClient previous;
  final Dio refreshDio = Dio();

  @override
  Future<void> onResponse(
      Response response, ResponseInterceptorHandler handler) async {
    if (response.requestOptions.uri.toString() !=
            'https://debis.deu.edu.tr/debis.php' &&
        latin1
            .decode(response.data)
            .contains("<input type='text' name='username'")) {
      final username = previous.sharedPreferences.getString('username');
      final password = previous.sharedPreferences.getString('password');
      previous.lock();
      previous.interceptors.responseLock.lock();
      previous.interceptors.errorLock.lock();
      await Future.delayed(Duration(seconds: 1));
      await refreshDio.post(
        'https://debis.deu.edu.tr/debis.php',
        data: {
          'username': username,
          'emailHost': 'ogr.deu.edu.tr',
          'password': password,
        },
        options: Options(
          contentType: 'application/x-www-form-urlencoded',
          responseType: ResponseType.plain,
        ),
      );
      Response? refreshResponse;
      try {
        refreshResponse = await refreshDio.fetch(response.requestOptions);
      } catch (e) {
        print(e);
      }
      previous.unlock();
      previous.interceptors.responseLock.unlock();
      previous.interceptors.errorLock.unlock();
      return handler.resolve(refreshResponse ?? response);
    }
    return handler.next(response);
  }
}
