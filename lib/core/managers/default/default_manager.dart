import 'package:system_loja/core/managers/default/repository/system_repository.dart';
import 'package:system_loja/core/settings/settings_app.dart';

abstract class DefaultManager<S extends SystemRepository> {
  final SettingsApp settingsApp;
  late S _systemRepository;
  DefaultManager({required this.settingsApp}) {
    switch (settingsApp.typeCache) {
      case EnumTypeCache.json:
        _systemRepository = JsonSystemRepository() as S;
        break;
      case EnumTypeCache.sql:
        _systemRepository = SqlSystemRepository() as S;
        break;
    }
  }
  S get systemRepository => _systemRepository;
}
