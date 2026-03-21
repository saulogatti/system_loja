import 'package:system_loja/core/models/default/people_data.dart';

/// Modelo de dados para Usuario
///
/// Representa um usuário do sistema com informações de autenticação
/// e nível de permissão para controle de acesso.

class User extends PersonDefault {
  final String passwordHash;

  final int permission;

  User({
    required super.name,
    required super.email,
    required this.passwordHash,
    this.permission = 0,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });

  /// Cria uma cópia do usuário com campos atualizados
  ///
  /// Atualiza automaticamente a data de última atualização para o momento atual,
  /// a menos que uma data específica seja fornecida.
  User copyWith({
    String? name,
    String? email,
    String? passwordHash,
    int? permission,
  }) {
    return User(
      name: name ?? this.name,
      email: email ?? this.email,
      passwordHash: passwordHash ?? this.passwordHash,
      permission: permission ?? this.permission,
      registrationDate: registrationDate,
      lastUpdatedDate: lastUpdatedDate,
    );
  }

  @override
  String toString() {
    return 'User(name: $name, email: $email, passwordHash: $passwordHash, permission: $permission)';
  }
}
