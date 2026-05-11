// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings_entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettingsEntry _$AppSettingsEntryFromJson(Map<String, dynamic> json) =>
    AppSettingsEntry(
      notificacoesAtivadas: json['notificacoesAtivadas'] as bool? ?? true,
      notificarVendas: json['notificarVendas'] as bool? ?? true,
      notificarEstoqueBaixo: json['notificarEstoqueBaixo'] as bool? ?? true,
      limiteEstoqueBaixo: (json['limiteEstoqueBaixo'] as num?)?.toInt() ?? 10,
      corPrimaria:
          $enumDecodeNullable(
            _$EnumColorAppThemeSettingsEnumMap,
            json['corPrimaria'],
          ) ??
          EnumColorAppThemeSettings.azul,
      temaEscuro: json['temaEscuro'] as bool? ?? false,
      backupAutomatico: json['backupAutomatico'] as bool? ?? false,
      frequenciaBackup: json['frequenciaBackup'] as String? ?? 'semanal',
      localBackup: json['localBackup'] as String? ?? '',
    );

Map<String, dynamic> _$AppSettingsEntryToJson(AppSettingsEntry instance) =>
    <String, dynamic>{
      'notificacoesAtivadas': instance.notificacoesAtivadas,
      'notificarVendas': instance.notificarVendas,
      'notificarEstoqueBaixo': instance.notificarEstoqueBaixo,
      'limiteEstoqueBaixo': instance.limiteEstoqueBaixo,
      'corPrimaria': _$EnumColorAppThemeSettingsEnumMap[instance.corPrimaria]!,
      'temaEscuro': instance.temaEscuro,
      'backupAutomatico': instance.backupAutomatico,
      'frequenciaBackup': instance.frequenciaBackup,
      'localBackup': instance.localBackup,
    };

const _$EnumColorAppThemeSettingsEnumMap = {
  EnumColorAppThemeSettings.azul: 'azul',
  EnumColorAppThemeSettings.verde: 'verde',
  EnumColorAppThemeSettings.laranka: 'laranka',
  EnumColorAppThemeSettings.roxo: 'roxo',
  EnumColorAppThemeSettings.vermelho: 'vermelho',
  EnumColorAppThemeSettings.rosa: 'rosa',
  EnumColorAppThemeSettings.ciano: 'ciano',
  EnumColorAppThemeSettings.indigo: 'indigo',
};
