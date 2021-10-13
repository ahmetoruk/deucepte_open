import 'package:deu_pos_api/src/models/weekly.dart';

class BalanceInfo {
  BalanceInfo(this.credit, this.weeklies);
  final String credit;
  final List<Weekly> weeklies;
}
