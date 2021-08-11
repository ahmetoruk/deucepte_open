import 'dart:convert';

import 'package:deu_api/deu_api.dart' show ScheduleApi, ScheduleTextContainer;
import 'package:shared_preferences/shared_preferences.dart';

typedef ScheduleTextContainerTable = List<List<List<ScheduleTextContainer>>>;

abstract class IScheduleLocalStorage {
  void saveScheduleTable(ScheduleTextContainerTable scheduleTable);
  Future<ScheduleTextContainerTable> getScheduleTable();
}

class ScheduleLocalStorage implements IScheduleLocalStorage {
  ScheduleLocalStorage(this.sharedPreferences);

  final SharedPreferences sharedPreferences;
  final String key = 'scheduleJson';

  @override
  Future<ScheduleTextContainerTable> getScheduleTable() async {
    final scheduleJson = sharedPreferences.getString(key);
    if (scheduleJson != null) {
      final rootList = <List<List<ScheduleTextContainer>>>[];
      for (final nodeTable in jsonDecode(scheduleJson)) {
        final rowList = <List<ScheduleTextContainer>>[];
        for (final rowTable in nodeTable) {
          final cellList = <ScheduleTextContainer>[];
          for (final json in rowTable) {
            cellList.add(
                ScheduleTextContainer.fromJson(json as Map<String, dynamic>));
          }
          rowList.add(cellList);
        }
        rootList.add(rowList);
      }
      return rootList;
    }
    throw Exception();
  }

  @override
  void saveScheduleTable(ScheduleTextContainerTable scheduleTable) {
    sharedPreferences.setString(key, jsonEncode(scheduleTable));
  }
}

abstract class IScheduleRepository {
  void saveScheduleTable(ScheduleTextContainerTable scheduleTable);
  Future<ScheduleTextContainerTable> getScheduleTable();
  Future<ScheduleTextContainerTable> getScheduleTableCache();
}

class ScheduleRepository implements IScheduleRepository {
  ScheduleRepository(this.schuduleApi, SharedPreferences sharedPreferences)
      : _schuduleLocalStorage = ScheduleLocalStorage(sharedPreferences);

  final ScheduleApi schuduleApi;
  final ScheduleLocalStorage _schuduleLocalStorage;

  @override
  Future<ScheduleTextContainerTable> getScheduleTable(
      {bool cache = false}) async {
    if (cache) {
      try {
        return await getScheduleTableCache();
      } catch (_) {}
    }
    final scheduleTable = await schuduleApi.fetchSchuduleTable();
    saveScheduleTable(scheduleTable);
    return scheduleTable;
  }

  @override
  Future<ScheduleTextContainerTable> getScheduleTableCache() async {
    return await _schuduleLocalStorage.getScheduleTable();
  }

  @override
  void saveScheduleTable(ScheduleTextContainerTable scheduleTable) {
    _schuduleLocalStorage.saveScheduleTable(scheduleTable);
  }
}
