import 'package:json_annotation/json_annotation.dart';

part 'app_settings.g.dart';

/// Modelo de dados para Configurações do Sistema
///
/// Armazena preferências do usuário como notificações, temas,
/// opções de backup, segurança e tipo de banco de dados.
@JsonSerializable(explicitToJson: true)
class AppSettings {
  final EnumTypeCache typeCache;

  /// Controla se as notificações estão ativadas globalmente no sistema
  @JsonKey(name: 'notificacoes_ativadas')
  final bool notificacoesAtivadas;

  /// Define se o sistema deve notificar sobre novas vendas realizadas
  @JsonKey(name: 'notificar_vendas')
  final bool notificarVendas;

  /// Define se o sistema deve alertar quando o estoque de produtos estiver baixo
  @JsonKey(name: 'notificar_estoque_baixo')
  final bool notificarEstoqueBaixo;

  /// Quantidade mínima de unidades em estoque para disparar alerta (1-50)
  @JsonKey(name: 'limite_estoque_baixo')
  final int limiteEstoqueBaixo;

  // Preferências de Tema

  /// Define se o tema escuro está ativado no aplicativo
  @JsonKey(name: 'tema_escuro')
  final bool temaEscuro;

  /// Cor primária do tema em formato hexadecimal (ex: '#2196F3')
  @JsonKey(name: 'cor_primaria')
  final String corPrimaria;

  // Opções de Backup

  /// Define se o backup automático dos dados está habilitado
  @JsonKey(name: 'backup_automatico')
  final bool backupAutomatico;

  /// Frequência do backup automático: 'diario', 'semanal' ou 'mensal'
  @JsonKey(name: 'frequencia_backup')
  final String frequenciaBackup;

  /// Caminho do diretório onde os backups serão armazenados
  @JsonKey(name: 'local_backup')
  final String localBackup;

  // Opções de Limpeza de Dados

  /// Define se a limpeza automática de logs antigos está habilitada
  @JsonKey(name: 'limpeza_automatica')
  final bool limpezaAutomatica;

  /// Número de dias para manter logs no sistema antes da limpeza (7-365)
  @JsonKey(name: 'dias_manter_logs')
  final int diasManterLogs;

  // Opções de Segurança

  /// Define se o sistema deve exigir senha ao ser aberto
  @JsonKey(name: 'exigir_senha')
  final bool exigirSenha;

  /// Tempo em minutos de inatividade antes de solicitar senha novamente (1-60)
  @JsonKey(name: 'tempo_bloqueio_minutos')
  final int tempoBloqueioMinutos;

  /// Define se o sistema permite gestão de múltiplos usuários
  @JsonKey(name: 'permitir_multiplos_usuarios')
  final bool permitirMultiplosUsuarios;

  AppSettings({
    this.notificacoesAtivadas = true,
    this.notificarVendas = true,
    this.notificarEstoqueBaixo = true,
    this.limiteEstoqueBaixo = 10,
    this.temaEscuro = false,
    this.corPrimaria = '#2196F3', // Blue
    this.backupAutomatico = false,
    this.frequenciaBackup = 'semanal',
    this.localBackup = 'data/backups',
    this.limpezaAutomatica = false,
    this.diasManterLogs = 90,
    this.exigirSenha = false,
    this.tempoBloqueioMinutos = 15,
    this.permitirMultiplosUsuarios = false,
    this.typeCache = EnumTypeCache.json,
  });

  /// Cria um objeto de configuração padrão
  factory AppSettings.createDefaultSettings() => AppSettings();

  /// Cria um objeto a partir de JSON
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);

  /// Cria uma cópia da configuração com alterações opcionais
  AppSettings copyWith({
    bool? notificacoesAtivadas,
    bool? notificarVendas,
    bool? notificarEstoqueBaixo,
    int? limiteEstoqueBaixo,
    bool? temaEscuro,
    String? corPrimaria,
    bool? backupAutomatico,
    String? frequenciaBackup,
    String? localBackup,
    bool? limpezaAutomatica,
    int? diasManterLogs,
    bool? exigirSenha,
    int? tempoBloqueioMinutos,
    bool? permitirMultiplosUsuarios,
    EnumTypeCache? typeCache,
  }) {
    return AppSettings(
      notificacoesAtivadas: notificacoesAtivadas ?? this.notificacoesAtivadas,
      notificarVendas: notificarVendas ?? this.notificarVendas,
      notificarEstoqueBaixo:
          notificarEstoqueBaixo ?? this.notificarEstoqueBaixo,
      limiteEstoqueBaixo: limiteEstoqueBaixo ?? this.limiteEstoqueBaixo,
      temaEscuro: temaEscuro ?? this.temaEscuro,
      corPrimaria: corPrimaria ?? this.corPrimaria,
      backupAutomatico: backupAutomatico ?? this.backupAutomatico,
      frequenciaBackup: frequenciaBackup ?? this.frequenciaBackup,
      localBackup: localBackup ?? this.localBackup,
      limpezaAutomatica: limpezaAutomatica ?? this.limpezaAutomatica,
      diasManterLogs: diasManterLogs ?? this.diasManterLogs,
      exigirSenha: exigirSenha ?? this.exigirSenha,
      tempoBloqueioMinutos: tempoBloqueioMinutos ?? this.tempoBloqueioMinutos,
      permitirMultiplosUsuarios:
          permitirMultiplosUsuarios ?? this.permitirMultiplosUsuarios,
      typeCache: typeCache ?? this.typeCache,
    );
  }

  /// Converte o objeto para JSON
  Map<String, dynamic> toJson() => _$AppSettingsToJson(this);

  @override
  String toString() {
    return 'Configuracao('
        'notificacoesAtivadas: $notificacoesAtivadas, '
        'notificarVendas: $notificarVendas, '
        'notificarEstoqueBaixo: $notificarEstoqueBaixo, '
        'limiteEstoqueBaixo: $limiteEstoqueBaixo, '
        'temaEscuro: $temaEscuro, '
        'corPrimaria: $corPrimaria, '
        'backupAutomatico: $backupAutomatico, '
        'frequenciaBackup: $frequenciaBackup, '
        'localBackup: $localBackup, '
        'limpezaAutomatica: $limpezaAutomatica, '
        'diasManterLogs: $diasManterLogs, '
        'exigirSenha: $exigirSenha, '
        'tempoBloqueioMinutos: $tempoBloqueioMinutos, '
        'permitirMultiplosUsuarios: $permitirMultiplosUsuarios, '
        'typeCache: $typeCache'
        ')';
  }
}

enum EnumTypeCache { json, sql }
