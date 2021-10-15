import 'package:deu_refectory_meals_api/deu_refectory_meals_api.dart';

abstract class IDeuRefectoryMealsRepositoryMemoryStorage {
  void saveRefectoryMeals(List<RefectoryDay> meals);
  Future<List<RefectoryDay>> getRefectoryMeals();
}

class DeuRefectoryMealsRepositoryMemoryStorage implements IDeuRefectoryMealsRepositoryMemoryStorage {
  List<RefectoryDay> _refectoryMeals = [];
  @override
  Future<List<RefectoryDay>> getRefectoryMeals() async {
    return _refectoryMeals;
  }

  @override
  void saveRefectoryMeals(List<RefectoryDay> meals) {
    _refectoryMeals = meals;
  }
}

abstract class IDeuRefectoryMealsRepository {
  void saveRefectoryMeals(List<RefectoryDay> meals);
  Future<List<RefectoryDay>> getRefectoryMeals(bool cache);
}

class DeuRefectoryMealsRepository implements IDeuRefectoryMealsRepository {
  DeuRefectoryMealsRepository(this.deuRefectoryMealsApi)
      : _refectoryMealsMemoryStorage = DeuRefectoryMealsRepositoryMemoryStorage();

  final DeuRefectoryMealsApi deuRefectoryMealsApi;
  final DeuRefectoryMealsRepositoryMemoryStorage _refectoryMealsMemoryStorage;
  @override
  Future<List<RefectoryDay>> getRefectoryMeals(bool cache) async {
    if (cache) {
      return _refectoryMealsMemoryStorage.getRefectoryMeals();
    }
    final fetchedRefectoryMeals =
        await deuRefectoryMealsApi.getRefectoryMeals();
    saveRefectoryMeals(fetchedRefectoryMeals);
    return fetchedRefectoryMeals;
  }

  @override
  void saveRefectoryMeals(List<RefectoryDay> meals) {
    _refectoryMealsMemoryStorage.saveRefectoryMeals(meals);
  }
}
