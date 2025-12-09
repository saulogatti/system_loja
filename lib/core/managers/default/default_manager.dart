import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/data/storage/json_storage.dart';
import 'package:system_loja/data/storage/sql_data_storage.dart';
import 'package:system_loja/data/storage/storage_data.dart';

abstract class DefaultManager {
  final AppSettings settingsApp;
  late BaseDataStorage _defaultDataStorage;
  DefaultManager({required this.settingsApp}) {
    switch (settingsApp.typeCache) {
      case EnumTypeCache.json:
        _defaultDataStorage = JsonDataStorage(
          storageType: runtimeType.toString(),
        );
        break;
      case EnumTypeCache.sql:
        _defaultDataStorage = SqlDataStorage(
          storageType: runtimeType.toString(),
        );
        break;
    }
  }

  BaseDataStorage get defaultDataStorage => _defaultDataStorage;
}
