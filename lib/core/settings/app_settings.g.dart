// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppSettings _$AppSettingsFromJson(Map<String, dynamic> json) => $checkedCreate(
  'AppSettings',
  json,
  ($checkedConvert) {
    final val = AppSettings(
      notificacoesAtivadas: $checkedConvert(
        'notificacoes_ativadas',
        (v) => v as bool? ?? true,
      ),
      notificarVendas: $checkedConvert(
        'notificar_vendas',
        (v) => v as bool? ?? true,
      ),
      notificarEstoqueBaixo: $checkedConvert(
        'notificar_estoque_baixo',
        (v) => v as bool? ?? true,
      ),
      limiteEstoqueBaixo: $checkedConvert(
        'limite_estoque_baixo',
        (v) => (v as num?)?.toInt() ?? 10,
      ),
      temaEscuro: $checkedConvert('tema_escuro', (v) => v as bool? ?? false),
      backupAutomatico: $checkedConvert(
        'backup_automatico',
        (v) => v as bool? ?? false,
      ),
      frequenciaBackup: $checkedConvert(
        'frequencia_backup',
        (v) => v as String? ?? 'semanal',
      ),
      localBackup: $checkedConvert(
        'local_backup',
        (v) => v as String? ?? 'data/backups',
      ),
      limpezaAutomatica: $checkedConvert(
        'limpeza_automatica',
        (v) => v as bool? ?? false,
      ),
      diasManterLogs: $checkedConvert(
        'dias_manter_logs',
        (v) => (v as num?)?.toInt() ?? 90,
      ),
      exigirSenha: $checkedConvert('exigir_senha', (v) => v as bool? ?? false),
      tempoBloqueioMinutos: $checkedConvert(
        'tempo_bloqueio_minutos',
        (v) => (v as num?)?.toInt() ?? 15,
      ),
      permitirMultiplosUsuarios: $checkedConvert(
        'permitir_multiplos_usuarios',
        (v) => v as bool? ?? false,
      ),
      corPrimaria: $checkedConvert(
        'cor_primaria',
        (v) =>
            $enumDecodeNullable(_$EnumColorAppThemeSettingsEnumMap, v) ??
            EnumColorAppThemeSettings.azul,
      ),
    );
    return val;
  },
  fieldKeyMap: const {
    'notificacoesAtivadas': 'notificacoes_ativadas',
    'notificarVendas': 'notificar_vendas',
    'notificarEstoqueBaixo': 'notificar_estoque_baixo',
    'limiteEstoqueBaixo': 'limite_estoque_baixo',
    'temaEscuro': 'tema_escuro',
    'backupAutomatico': 'backup_automatico',
    'frequenciaBackup': 'frequencia_backup',
    'localBackup': 'local_backup',
    'limpezaAutomatica': 'limpeza_automatica',
    'diasManterLogs': 'dias_manter_logs',
    'exigirSenha': 'exigir_senha',
    'tempoBloqueioMinutos': 'tempo_bloqueio_minutos',
    'permitirMultiplosUsuarios': 'permitir_multiplos_usuarios',
    'corPrimaria': 'cor_primaria',
  },
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
