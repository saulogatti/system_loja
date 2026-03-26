import 'package:system_loja/core/models/default/people_data.dart';

/// Usuário do sistema com credenciais e nível de permissão.
///
/// Herda dados comuns de [PersonDefault] (nome, e-mail).
/// A senha é armazenada apenas como hash — nunca em texto plano.
class User extends PersonDefault {
  /// Hash da senha do usuário.
  final String passwordHash;

  /// Nível de permissão do usuário. Padrão 0 (sem privilégios especiais).
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

  /// Cria uma cópia do usuário com campos atualizados.
  ///
  /// Preserva [registrationDate] original. A [lastUpdatedDate] **não** é
  /// alterada automaticamente — atualize-a explicitamente se necessário.
  User copyWith({String? name, String? email, String? passwordHash, int? permission}) {
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
