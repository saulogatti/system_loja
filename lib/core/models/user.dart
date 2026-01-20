// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:system_loja/core/models/default/default_object.dart';

part 'user.g.dart';

/// Níveis de permissão disponíveis no sistema
enum AuthorizationLevel {
  /// Administrador com acesso total ao sistema
  @JsonValue('ADMINISTRADOR')
  administrador(1),

  /// Usuário comum com acesso limitado
  @JsonValue('USUARIO_COMUM')
  usuarioComum(2);

  final int value;
  const AuthorizationLevel(this.value);
}

/// Modelo de dados para Usuario
///
/// Representa um usuário do sistema com informações de autenticação
/// e nível de permissão para controle de acesso.
@JsonSerializable(constructor: 'withDados', explicitToJson: true)
class User extends DefaultObject {
  final String name;
  final String email;

  @JsonKey(name: 'senha_hash')
  final String passwordHash;

  @JsonKey(name: 'nivel_permissao')
  final int permission;

  User({
    required super.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    this.permission = 0,
    super.registrationDate,
    super.lastUpdatedDate,
  });

  /// Cria um objeto a partir de JSON
  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  User.withDados({
    required super.id,
    required this.name,
    required this.email,
    required this.passwordHash,
    this.permission = 0,
    super.lastUpdatedDate,
    super.registrationDate,
  });

  /// Cria uma cópia do usuário com campos atualizados
  ///
  /// Atualiza automaticamente a data de última atualização para o momento atual,
  /// a menos que uma data específica seja fornecida.
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? passwordHash,
    int? permission,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      permission: permission ?? this.permission,
      registrationDate: registrationDate,
      lastUpdatedDate: DateTime.now(),
    );
  }

  /// Converte o objeto para JSON
  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User(name: $name, email: $email, passwordHash: $passwordHash, permission: $permission)';
  }
}

/// Dados do usuário
