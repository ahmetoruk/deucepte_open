import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/native_imp.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deu_api/deu_api.dart';
import 'package:deu_api/src/auth_api.dart';
import 'package:deu_api/src/lecture_api.dart';
import 'package:deu_api/src/message_api.dart';
import 'package:deu_api/src/relogin_interceptor.dart';
import 'package:deu_api/src/schedule_api.dart';
import 'package:deu_api/src/semester_api.dart';

class DeuClient extends DioForNative {
  DeuClient(this.sharedPreferences)
      : cookieManager = CookieManager(CookieJar(ignoreExpires: true)) {
    options.followRedirects = false;
    interceptors.add(cookieManager);
    interceptors.add(ReLoginInterceptor(this));
  }
  final SharedPreferences sharedPreferences;
  final CookieManager cookieManager;
}

class DeuApi {
  DeuApi._(DeuClient client)
      : _auth = AuthApi(client),
        _semester = SemesterApi(client),
        _lecture = LectureApi(client),
        _message = MessageApi(client),
        _schedule = ScheduleApi(client);

  factory DeuApi.create(SharedPreferences sharedPreferences) =>
      DeuApi._(DeuClient(sharedPreferences));

  final AuthApi _auth;
  final SemesterApi _semester;
  final LectureApi _lecture;
  final MessageApi _message;
  final ScheduleApi _schedule;
  AuthApi get auth => _auth;
  SemesterApi get semester => _semester;
  LectureApi get lecture => _lecture;
  MessageApi get message => _message;
  ScheduleApi get schedule => _schedule;
}
