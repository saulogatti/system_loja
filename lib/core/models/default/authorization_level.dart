/// Níveis de permissão disponíveis no sistema
enum AuthorizationLevel {
  /// Administrador com acesso total ao sistema
  administrador(1),

  /// Usuário comum com acesso limitado
  usuarioComum(2);

  final int value;
  const AuthorizationLevel(this.value);
}
