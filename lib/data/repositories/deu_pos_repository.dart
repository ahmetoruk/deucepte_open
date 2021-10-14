import 'package:deu_pos_api/deu_pos_api.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class IDeuPosRepository {
  Future<BalanceInfo> getAccountBalance();
}

class DeuPosRepository implements IDeuPosRepository {
  DeuPosRepository(this.deuPosApi, this.sharedPreferences);

  final DeuPosApi deuPosApi;
  final SharedPreferences sharedPreferences;
  @override
  Future<BalanceInfo> getAccountBalance() async {
    final username = sharedPreferences.getString("username");
    final password = sharedPreferences.getString("password");
    if (username != null && password != null) {
      await deuPosApi.login(username, password);
    }
    return await deuPosApi.getBalance();
  }
}
