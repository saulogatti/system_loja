// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => AppSettings(
  notificacoesAtivadas: json['notificacoes_ativadas'] as bool? ?? true,
  notificarVendas: json['notificar_vendas'] as bool? ?? true,
  notificarEstoqueBaixo: json['notificar_estoque_baixo'] as bool? ?? true,
  limiteEstoqueBaixo: (json['limite_estoque_baixo'] as num?)?.toInt() ?? 10,
  temaEscuro: json['tema_escuro'] as bool? ?? false,
  backupAutomatico: json['backup_automatico'] as bool? ?? false,
  frequenciaBackup: json['frequencia_backup'] as String? ?? 'semanal',
  localBackup: json['local_backup'] as String? ?? 'data/backups',
  limpezaAutomatica: json['limpeza_automatica'] as bool? ?? false,
  diasManterLogs: (json['dias_manter_logs'] as num?)?.toInt() ?? 90,
  exigirSenha: json['exigir_senha'] as bool? ?? false,
  tempoBloqueioMinutos: (json['tempo_bloqueio_minutos'] as num?)?.toInt() ?? 15,
  permitirMultiplosUsuarios:
      json['permitir_multiplos_usuarios'] as bool? ?? false,
  corPrimaria:
      $enumDecodeNullable(
        _$EnumColorAppThemeSettingsEnumMap,
        json['cor_primaria'],
      ) ??
      EnumColorAppThemeSettings.azul,
);

Map<String, dynamic> _$AppSettingsToJson(AppSettings instance) =>
    <String, dynamic>{
      'notificacoes_ativadas': instance.notificacoesAtivadas,
      'notificar_vendas': instance.notificarVendas,
      'notificar_estoque_baixo': instance.notificarEstoqueBaixo,
      'limite_estoque_baixo': instance.limiteEstoqueBaixo,
      'cor_primaria': _$EnumColorAppThemeSettingsEnumMap[instance.corPrimaria]!,
      'tema_escuro': instance.temaEscuro,
      'backup_automatico': instance.backupAutomatico,
      'frequencia_backup': instance.frequenciaBackup,
      'local_backup': instance.localBackup,
      'limpeza_automatica': instance.limpezaAutomatica,
      'dias_manter_logs': instance.diasManterLogs,
      'exigir_senha': instance.exigirSenha,
      'tempo_bloqueio_minutos': instance.tempoBloqueioMinutos,
      'permitir_multiplos_usuarios': instance.permitirMultiplosUsuarios,
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
