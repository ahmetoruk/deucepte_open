import 'package:deu_refectory_meals_api/src/models/meal.dart';
import 'package:intl/intl.dart';

class RefectoryDay {
  RefectoryDay(this.date, this.kcal, this.meals);

  final String date, kcal;
  final List<Meal> meals;

  DateTime get dateTime {
    final format = DateFormat("dd MMMM yyyy EEEE", "tr_TR");
    return format.parse(date);
  }
}
