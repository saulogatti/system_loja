import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';

part 'app_settings_entry.g.dart';

/// DTO JSON para persistência de [AppSettings] (sem herdar modelo de domínio).
@JsonSerializable()
class AppSettingsEntry {
  final bool notificacoesAtivadas;
  final bool notificarVendas;
  final bool notificarEstoqueBaixo;
  final int limiteEstoqueBaixo;
  final EnumColorAppThemeSettings corPrimaria;
  final bool temaEscuro;
  final bool backupAutomatico;
  final String frequenciaBackup;
  final String localBackup;
  final bool limpezaAutomatica;
  final int diasManterLogs;
  final bool exigirSenha;
  final int tempoBloqueioMinutos;
  final bool permitirMultiplosUsuarios;

  const AppSettingsEntry({
    this.notificacoesAtivadas = true,
    this.notificarVendas = true,
    this.notificarEstoqueBaixo = true,
    this.limiteEstoqueBaixo = 10,
    this.corPrimaria = EnumColorAppThemeSettings.azul,
    this.temaEscuro = false,
    this.backupAutomatico = false,
    this.frequenciaBackup = 'semanal',
    this.localBackup = '',
    this.limpezaAutomatica = false,
    this.diasManterLogs = 90,
    this.exigirSenha = false,
    this.tempoBloqueioMinutos = 15,
    this.permitirMultiplosUsuarios = false,
  });

  factory AppSettingsEntry.fromAppSettings(AppSettings configuracao) => AppSettingsEntry(
    notificacoesAtivadas: configuracao.notificacoesAtivadas,
    notificarVendas: configuracao.notificarVendas,
    notificarEstoqueBaixo: configuracao.notificarEstoqueBaixo,
    limiteEstoqueBaixo: configuracao.limiteEstoqueBaixo,
    corPrimaria: configuracao.corPrimaria,
    temaEscuro: configuracao.temaEscuro,
    backupAutomatico: configuracao.backupAutomatico,
    frequenciaBackup: configuracao.frequenciaBackup,
    localBackup: configuracao.localBackup,
    limpezaAutomatica: configuracao.limpezaAutomatica,
    diasManterLogs: configuracao.diasManterLogs,
    exigirSenha: configuracao.exigirSenha,
    tempoBloqueioMinutos: configuracao.tempoBloqueioMinutos,
    permitirMultiplosUsuarios: configuracao.permitirMultiplosUsuarios,
  );

  factory AppSettingsEntry.fromJson(Map<String, dynamic> json) => _$AppSettingsEntryFromJson(json);

  AppSettings toAppSettings() => AppSettings(
    notificacoesAtivadas: notificacoesAtivadas,
    notificarVendas: notificarVendas,
    notificarEstoqueBaixo: notificarEstoqueBaixo,
    limiteEstoqueBaixo: limiteEstoqueBaixo,
    corPrimaria: corPrimaria,
    temaEscuro: temaEscuro,
    backupAutomatico: backupAutomatico,
    frequenciaBackup: frequenciaBackup,
    localBackup: localBackup,
    limpezaAutomatica: limpezaAutomatica,
    diasManterLogs: diasManterLogs,
    exigirSenha: exigirSenha,
    tempoBloqueioMinutos: tempoBloqueioMinutos,
    permitirMultiplosUsuarios: permitirMultiplosUsuarios,
  );

  Map<String, dynamic> toJson() => _$AppSettingsEntryToJson(this);
}
