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
      limpezaAutomatica: json['limpezaAutomatica'] as bool? ?? false,
      diasManterLogs: (json['diasManterLogs'] as num?)?.toInt() ?? 90,
      exigirSenha: json['exigirSenha'] as bool? ?? false,
      tempoBloqueioMinutos:
          (json['tempoBloqueioMinutos'] as num?)?.toInt() ?? 15,
      permitirMultiplosUsuarios:
          json['permitirMultiplosUsuarios'] as bool? ?? false,
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
      'limpezaAutomatica': instance.limpezaAutomatica,
      'diasManterLogs': instance.diasManterLogs,
      'exigirSenha': instance.exigirSenha,
      'tempoBloqueioMinutos': instance.tempoBloqueioMinutos,
      'permitirMultiplosUsuarios': instance.permitirMultiplosUsuarios,
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
