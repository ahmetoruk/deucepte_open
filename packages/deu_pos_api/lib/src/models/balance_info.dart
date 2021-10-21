import 'package:deu_pos_api/src/models/weekly.dart';

class BalanceInfo {
  BalanceInfo(this.credit, this.weeklies, this.isWeekend);
  final String credit;
  final List<Weekly> weeklies;
  final bool isWeekend;
}
