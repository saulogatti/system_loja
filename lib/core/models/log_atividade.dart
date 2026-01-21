// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'log_atividade.g.dart';

/// Modelo de dados para Log de Atividade
///
/// Registra as atividades realizadas no sistema para fins de auditoria.
/// Armazena informações sobre qual ação foi realizada, por qual usuário,
/// quando e detalhes adicionais sobre a operação.
@JsonSerializable(explicitToJson: true)
class LogAtividade extends DefaultObject {
  @JsonKey(name: 'tipo_acao')
  TipoAcao tipoAcao;

  @JsonKey(name: 'entidade')
  final String entidade;

  @JsonKey(name: 'usuario_id')
  final int usuarioId;

  @JsonKey(name: 'usuario_nome')
  final String usuarioNome;

  @JsonKey(name: 'data_hora')
  final DateTime dataHora;

  final String detalhes;

  LogAtividade({
    required super.id,
    required this.entidade,
    required this.usuarioId,
    required this.usuarioNome,
    DateTime? dataHora,
    this.detalhes = '',
    super.lastUpdatedDate,
    super.registrationDate,
    String? action,
  }) : dataHora = dataHora ?? DateTime.now(),
       tipoAcao = TipoAcao.values.firstWhere(
         (e) => e.name == action,
         orElse: () => TipoAcao.ler,
       );

  /// Cria um objeto a partir de JSON
  factory LogAtividade.fromJson(Map<String, dynamic> json) =>
      _$LogAtividadeFromJson(json);
  String get action => tipoAcao.name;

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$LogAtividadeToJson(this);

  @override
  String toString() =>
      'LogAtividade(id: $id, tipoAcao: $tipoAcao, entidade: $entidade,  usuarioId: $usuarioId, usuarioNome: $usuarioNome, dataHora: $dataHora, detalhes: $detalhes)';
}

/// Tipos de ação que podem ser registradas no log
enum TipoAcao {
  /// Criação de um novo registro
  @JsonValue('CRIAR')
  criar,

  /// Leitura/consulta de um registro
  @JsonValue('LER')
  ler,

  /// Atualização de um registro
  @JsonValue('ATUALIZAR')
  atualizar,

  /// Exclusão de um registro
  @JsonValue('DELETAR')
  deletar,
}
