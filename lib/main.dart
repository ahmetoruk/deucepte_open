import 'package:deu_pos_api/deu_pos_api.dart';
import 'package:deu_refectory_meals_api/deu_refectory_meals_api.dart';
import 'package:flutter/material.dart';

import 'package:background_fetch/background_fetch.dart';
import 'package:deu_api/deu_api.dart' show DeuApi;
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:deucepte_open/app.dart';
import 'package:deucepte_open/core/services/background_notification/background_fetch.dart';

late PackageInfo packageInfo;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  packageInfo = await PackageInfo.fromPlatform();

  final sharedPreferences = await SharedPreferences.getInstance();
  final api = DeuApi.create(sharedPreferences);
  final deuPosApi = DeuPosApi();
  final deuRefectoryMealsApi = DeuRefectoryMealsApi();
  await deuRefectoryMealsApi.initilizateLocale();
  runApp(App(api, deuPosApi, deuRefectoryMealsApi, sharedPreferences));
  BackgroundFetch.registerHeadlessTask(headlessNotificationFetch);
}
