/// Níveis de permissão disponíveis no sistema.
///
/// {@category modelos}
/// {@subCategory Sistema}
enum AuthorizationLevel {
  /// Administrador com acesso total ao sistema
  administrador(1),

  /// Usuário comum com acesso limitado
  usuarioComum(2);

  const AuthorizationLevel(this.value);
  final int value;
}
