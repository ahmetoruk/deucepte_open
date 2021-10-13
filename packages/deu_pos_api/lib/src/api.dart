import 'package:cookie_jar/cookie_jar.dart';
import 'package:deu_pos_api/src/constants.dart';
import 'package:deu_pos_api/src/models/balance_info.dart';
import 'package:deu_pos_api/src/models/weekly.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:html/parser.dart' as html;

class DeuPosApi {
  final Dio client = Dio()
    ..interceptors.add(CookieManager(CookieJar(ignoreExpires: true)));

  Future<bool> login(String username, String password) async {
    final response = await client.get('https://pos.deu.edu.tr/index.php');
    final formKey = html
        .parse(response.data)
        .querySelector("input[name='kullanici_girisanahtar']")!
        .attributes["value"];
    final loginResponse = await client.post(
        'https://pos.deu.edu.tr/page/login.php',
        options: Options(
            headers: {"Content-Type": "application/x-www-form-urlencoded"},
            followRedirects: false,
            validateStatus: (status) => status! < 500),
        data: {
          "kullanici_posta": username,
          "kullanici_tip": "O",
          "kullanici_parola": password,
          "kullanici_girisanahtar": formKey
        });
    var location = loginResponse.headers["location"]?.first;
    if (location == null) return false;
    if (location == "index.php") return true;

    return false;
  }

  Future<BalanceInfo> getBalance() async {
    final balanceResponse =
        await client.get("https://pos.deu.edu.tr/page/index.php?p=account");
    final accountHTML = html.parse(balanceResponse.data);
    final credit = accountHTML
        .querySelector("h3")!
        .text
        .replaceAll("  ", "")
        .split(":")[1]
        .trim();
    final h5Elements = accountHTML.querySelectorAll("h5");
    final weeklies = <Weekly>[];
    for (var h5Element in h5Elements) {
      Map<String, bool> weeklyDays = Map.from(days);
      final date =
          h5Element.querySelector("strong")?.text.replaceFirst(" ~ ", "\n") ??
              "Hata!";
      String elem;
      final isFullWeek = h5Element.text.toLowerCase().contains("5 gün");
      for (int i = 0; i < days.length; i++) {
        elem = days.keys.elementAt(i);
        if (h5Element.text.contains(days.keys.elementAt(i)) || isFullWeek) {
          weeklyDays[elem] = true;
        }
      }
      weeklies.add(Weekly(date, weeklyDays));
    }

    return BalanceInfo(credit, weeklies);
  }
}
