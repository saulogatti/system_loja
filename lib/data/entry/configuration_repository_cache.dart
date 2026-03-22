import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';
import 'package:system_loja/domain/repository/configuration_repository.dart';

part 'configuration_repository_cache.g.dart';

@JsonSerializable()
class AppSettingsEntry extends AppSettings {
  AppSettingsEntry({
    super.notificacoesAtivadas = true,
    super.notificarVendas = true,
    super.notificarEstoqueBaixo = true,
    super.limiteEstoqueBaixo = 10,
    super.corPrimaria = EnumColorAppThemeSettings.azul,
    super.temaEscuro = false,
    super.backupAutomatico = false,
    super.frequenciaBackup = 'semanal',
    super.localBackup = 'data/backups',
    super.limpezaAutomatica = false,
  });
  factory AppSettingsEntry.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsEntryFromJson(json);

  AppSettings toAppSettings() => AppSettings(
    notificacoesAtivadas: notificacoesAtivadas,
    notificarVendas: notificarVendas,
    notificarEstoqueBaixo: notificarEstoqueBaixo,
    limiteEstoqueBaixo: limiteEstoqueBaixo,
    corPrimaria: corPrimaria,
    temaEscuro: temaEscuro,
  );

  Map<String, dynamic> toJson() => _$AppSettingsEntryToJson(this);
  static AppSettingsEntry fromAppSettings(AppSettings configuracao) =>
      AppSettingsEntry(
        notificacoesAtivadas: configuracao.notificacoesAtivadas,
        notificarVendas: configuracao.notificarVendas,
        notificarEstoqueBaixo: configuracao.notificarEstoqueBaixo,
        limiteEstoqueBaixo: configuracao.limiteEstoqueBaixo,
        corPrimaria: configuracao.corPrimaria,
        temaEscuro: configuracao.temaEscuro,
      );
}

@JsonSerializable()
class ConfigurationRepositoryCache extends Cacheable {
  final AppSettingsEntry configuracao;
  ConfigurationRepositoryCache({required this.configuracao});
  factory ConfigurationRepositoryCache.fromJson(Map<String, dynamic> json) =>
      _$ConfigurationRepositoryCacheFromJson(json);
  @override
  String get cacheKey => keyConfigurationRepositoryCache;
  @override
  Map<String, dynamic> toJson() => _$ConfigurationRepositoryCacheToJson(this);
}
