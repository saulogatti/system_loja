// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'usuario.g.dart';

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
  
  @JsonKey(name: 'data_cadastro')
  final DateTime dataCadastro;
  
  @JsonKey(name: 'data_ultima_atualizacao')
  final DateTime dataUltimaAtualizacao;

  Usuario({
    required super.id,
    required String nome,
    required String email,
    required String senhaHash,
    required NivelPermissao nivelPermissao,
    DateTime? dataCadastro,
    DateTime? dataUltimaAtualizacao,
  })  : dadosUsuario = DadosUsuario(
          nome: nome,
          email: email,
          senhaHash: senhaHash,
          nivelPermissao: nivelPermissao,
        ),
        dataCadastro = dataCadastro ?? DateTime.now(),
        dataUltimaAtualizacao = dataUltimaAtualizacao ?? DateTime.now();

  /// Cria um objeto a partir de JSON
  factory Usuario.fromJson(Map<String, dynamic> json) => _$UsuarioFromJson(json);

  Usuario.withDados({
    required super.id,
    required this.dadosUsuario,
    DateTime? dataCadastro,
    DateTime? dataUltimaAtualizacao,
  })  : dataCadastro = dataCadastro ?? DateTime.now(),
        dataUltimaAtualizacao = dataUltimaAtualizacao ?? DateTime.now();

  String get nome => dadosUsuario.nome;
  String get email => dadosUsuario.email;
  String get senhaHash => dadosUsuario.senhaHash;
  NivelPermissao get nivelPermissao => dadosUsuario.nivelPermissao;

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$UsuarioToJson(this);

  @override
  String toString() =>
      'Usuario(id: $id, dadosUsuario: $dadosUsuario, dataCadastro: $dataCadastro, dataUltimaAtualizacao: $dataUltimaAtualizacao)';

  /// Cria uma cópia do usuário com campos atualizados
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
      dataCadastro: dataCadastro ?? this.dataCadastro,
      dataUltimaAtualizacao: dataUltimaAtualizacao ?? DateTime.now(),
    );
  }
}

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

  factory DadosUsuario.fromJson(Map<String, dynamic> json) => _$DadosUsuarioFromJson(json);
  Map<String, dynamic> toJson() => _$DadosUsuarioToJson(this);

  @override
  String toString() {
    return 'DadosUsuario(nome: $nome, email: $email, nivelPermissao: $nivelPermissao)';
  }
}
