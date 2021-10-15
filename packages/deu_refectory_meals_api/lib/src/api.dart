import 'dart:convert' show jsonDecode;

import 'package:deu_refectory_meals_api/src/models/meal.dart';
import 'package:deu_refectory_meals_api/src/models/refectory_day.dart';
import 'package:dio/dio.dart';
import 'package:intl/date_symbol_data_local.dart';

class DeuRefectoryMealsApi {
  final client = Dio();

  Future initilizateLocale() async {
    await initializeDateFormatting("tr_TR", null);
  }

  Future<List<RefectoryDay>> getRefectoryMeals() async {
    final response = await client.get(
        "https://raw.githubusercontent.com/ahmetoruk/deu_yemekhane_json/main/yemekhane.json");
    final parsed = jsonDecode(response.data) as Map<String, dynamic>;
    final refectoryDays = <RefectoryDay>[];
    for (final dayEntry in parsed.entries) {
      final parsedMeals =
          (dayEntry.value as List<dynamic>).map((e) => e as String);
      var kcal = "";
      final meals = <Meal>[];
      for (final meal in parsedMeals) {
        if (meal.toLowerCase().contains("kcal")) {
          kcal = meal;
        } else {
          final mealText = meal
              .toLowerCase()
              .split(" ")
              .map((word) => word[0].toUpperCase() + word.substring(1))
              .join(" ");
          meals.add(Meal(mealText));
        }
      }
      refectoryDays.add(RefectoryDay(dayEntry.key, kcal, meals));
    }
    return refectoryDays;
  }
}
