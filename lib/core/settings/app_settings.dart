import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';

/// Modelo de dados para Configurações do Sistema
///
/// Armazena preferências do usuário como notificações, temas,
/// opções de backup, segurança e tipo de banco de dados.

class AppSettings {
  /// Controla se as notificações estão ativadas globalmente no sistema
  final bool notificacoesAtivadas;

  /// Define se o sistema deve notificar sobre novas vendas realizadas
  final bool notificarVendas;

  /// Define se o sistema deve alertar quando o estoque de produtos estiver baixo
  final bool notificarEstoqueBaixo;

  /// Quantidade mínima de unidades em estoque para disparar alerta (1-50)
  final int limiteEstoqueBaixo;

  // Preferências de Tema

  /// Cor primária do tema do aplicativo
  final EnumColorAppThemeSettings corPrimaria;

  /// Define se o tema escuro está ativado no aplicativo
  final bool temaEscuro;

  // Opções de Backup

  /// Define se o backup automático dos dados está habilitado
  final bool backupAutomatico;

  /// Frequência do backup automático: 'diario', 'semanal' ou 'mensal'
  final String frequenciaBackup;

  /// Caminho do diretório onde os backups serão armazenados
  final String localBackup;

  // Opções de Limpeza de Dados

  AppSettings({
    this.notificacoesAtivadas = true,
    this.notificarVendas = true,
    this.notificarEstoqueBaixo = true,
    this.limiteEstoqueBaixo = 10,
    this.temaEscuro = false,
    this.backupAutomatico = false,
    this.frequenciaBackup = 'semanal',
    this.localBackup = 'data/backups',

    this.corPrimaria = EnumColorAppThemeSettings.azul,
  });

  /// Cria um objeto de configuração padrão
  factory AppSettings.createDefaultSettings() => AppSettings();

  /// Cria uma cópia da configuração com alterações opcionais
  AppSettings copyWith({
    bool? notificacoesAtivadas,
    bool? notificarVendas,
    bool? notificarEstoqueBaixo,
    int? limiteEstoqueBaixo,
    bool? temaEscuro,
    bool? backupAutomatico,
    String? frequenciaBackup,
    String? localBackup,

    EnumColorAppThemeSettings? corPrimaria,
  }) {
    return AppSettings(
      notificacoesAtivadas: notificacoesAtivadas ?? this.notificacoesAtivadas,
      notificarVendas: notificarVendas ?? this.notificarVendas,
      notificarEstoqueBaixo: notificarEstoqueBaixo ?? this.notificarEstoqueBaixo,
      limiteEstoqueBaixo: limiteEstoqueBaixo ?? this.limiteEstoqueBaixo,
      temaEscuro: temaEscuro ?? this.temaEscuro,
      backupAutomatico: backupAutomatico ?? this.backupAutomatico,
      frequenciaBackup: frequenciaBackup ?? this.frequenciaBackup,
      localBackup: localBackup ?? this.localBackup,
      corPrimaria: corPrimaria ?? this.corPrimaria,
    );
  }
}
