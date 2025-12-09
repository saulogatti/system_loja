import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/json_storage.dart';
import 'package:system_loja/data/storage/sql_data_storage.dart';
import 'package:system_loja/data/storage/storage_data.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

abstract class RepositoryManager {
  
  late BaseDataStorage _defaultDataStorage;
  RepositoryManager() {
    final settingsApp = SettingsService().currentSettings;
    switch (settingsApp.typeCache) {
      case EnumTypeCache.json:
        _defaultDataStorage = JsonDataStorage(
          storageCategory: runtimeType.toString(),
        );
        break;
      case EnumTypeCache.sql:
        _defaultDataStorage = SqlDataStorage(
          storageCategory: runtimeType.toString(),
        );
        break;
    }
  }

  BaseDataStorage get defaultDataStorage => _defaultDataStorage;
  Future<int> obtainNextId() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationSuccess(result: final dataList):
        if (dataList.isEmpty) {
          return 1;
        }
        final ids = dataList.map((data) => data.id).toList();
        return (ids.reduce((a, b) => a > b ? a : b)) + 1;
      case OperationError(error: final errorMessage):
        throw Exception('Erro ao carregar clientes: $errorMessage');
    }
  }
}
