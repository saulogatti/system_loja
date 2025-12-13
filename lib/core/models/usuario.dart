// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'usuario.g.dart';

/// Dados do usuário
@JsonSerializable()
class DadosUsuario {
  final String nome;
  final String email;

  @JsonKey(name: 'senha_hash')
  final String senhaHash;

  @JsonKey(name: 'nivel_permissao')
  final NivelPermissao nivelPermissao;

  DadosUsuario({
    required this.nome,
    required this.email,
    required this.senhaHash,
    required this.nivelPermissao,
  });

  factory DadosUsuario.fromJson(Map<String, dynamic> json) =>
      _$DadosUsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$DadosUsuarioToJson(this);

  @override
  String toString() {
    return 'DadosUsuario(nome: $nome, email: $email, nivelPermissao: $nivelPermissao)';
  }
}

/// Níveis de permissão disponíveis no sistema
enum NivelPermissao {
  /// Administrador com acesso total ao sistema
  @JsonValue('ADMINISTRADOR')
  administrador,

  /// Usuário comum com acesso limitado
  @JsonValue('USUARIO_COMUM')
  usuarioComum,
}

/// Modelo de dados para Usuario
///
/// Representa um usuário do sistema com informações de autenticação
/// e nível de permissão para controle de acesso.
@JsonSerializable(constructor: 'withDados', explicitToJson: true)
class Usuario extends DefaultObject {
  final DadosUsuario dadosUsuario;

  Usuario({
    required super.id,
    required String nome,
    required String email,
    required String senhaHash,
    required NivelPermissao nivelPermissao,
    super.registrationDate,
    super.lastUpdatedDate,
  }) : dadosUsuario = DadosUsuario(
         nome: nome,
         email: email,
         senhaHash: senhaHash,
         nivelPermissao: nivelPermissao,
       );

  /// Cria um objeto a partir de JSON
  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);

  Usuario.withDados({
    required super.id,
    required this.dadosUsuario,
    super.lastUpdatedDate,
    super.registrationDate,
  });

  String get email => dadosUsuario.email;
  NivelPermissao get nivelPermissao => dadosUsuario.nivelPermissao;
  String get nome => dadosUsuario.nome;
  String get senhaHash => dadosUsuario.senhaHash;

  /// Cria uma cópia do usuário com campos atualizados
  ///
  /// Atualiza automaticamente a data de última atualização para o momento atual,
  /// a menos que uma data específica seja fornecida.
  Usuario copyWith({
    int? id,
    String? nome,
    String? email,
    String? senhaHash,
    NivelPermissao? nivelPermissao,
    DateTime? dataCadastro,
    DateTime? dataUltimaAtualizacao,
  }) {
    return Usuario(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      senhaHash: senhaHash ?? this.senhaHash,
      nivelPermissao: nivelPermissao ?? this.nivelPermissao,
      lastUpdatedDate: dataUltimaAtualizacao ?? lastUpdatedDate,
      registrationDate: dataCadastro ?? registrationDate,
    );
  }

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  @override
  String toString() => 'Usuario(dadosUsuario: $dadosUsuario)';
}
