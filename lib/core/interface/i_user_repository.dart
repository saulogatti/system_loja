import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de repositório de usuários.
///
/// Esta interface abstrai as operações CRUD (Create, Read, Update, Delete)
/// para entidades [User], permitindo diferentes implementações de
/// persistência (Drift, JSON, etc.).
///
/// Inclui operações de autenticação, validação de email e gerenciamento
/// completo de usuários do sistema.
///
/// **Nota**: Alguns métodos desta interface usam nomenclatura em português
/// mantendo compatibilidade com código legado.
///
/// Exemplo de uso:
/// ```dart
/// final repository = appInjection.get<UserRepository>();
///
/// // Buscar usuário por email
/// final user = await repository.obterUsuarioPorEmail('admin@system.com');
/// if (user != null) {
///   print('Usuário: ${user.name}');
/// }
///
/// // Validar email
/// if (repository.validarEmail('teste@example.com')) {
///   print('Email válido');
/// }
/// ```
///
/// Veja também:
/// - [User] - modelo de domínio de usuário
/// - [ResultStatus] - tipo de retorno para operações
abstract interface class IUserRepository {
  /// Adiciona um novo usuário ao sistema.
  ///
  /// O email deve ser único e válido (use [validarEmail] para verificar).
  ///
  /// Parâmetros:
  /// - [usuario]: Objeto User a ser adicionado
  ///
  /// Retorna:
  /// - [ResultStatus] com true se adicionado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> adicionarUsuario(User usuario);

  /// Atualiza os dados de um usuário existente.
  ///
  /// O usuário deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [usuario]: Objeto User com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> atualizarUsuario(User usuario);

  /// Retorna todos os usuários cadastrados no sistema.
  Future<ResultStatus<List<User>, String>> obterTodosUsuarios();

  /// Busca um usuário pelo endereço de email.
  ///
  /// Útil para autenticação e verificação de duplicidade.
  ///
  /// Parâmetros:
  /// - [email]: Email do usuário a ser buscado
  ///
  /// Retorna:
  /// - Objeto [User] se encontrado ou null se não existir
  Future<User?> obterUsuarioPorEmail(String email);

  /// Busca um usuário específico pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do usuário
  ///
  /// Retorna:
  /// - Objeto [User] se encontrado ou null se não existir
  Future<User?> obterUsuarioPorId(int id);

  /// Remove um usuário do sistema pelo ID.
  ///
  /// **ATENÇÃO**: Verifique se há dependências (logs, vendas) antes de remover.
  ///
  /// Parâmetros:
  /// - [id]: ID único do usuário a ser removido
  ///
  Future<ResultStatus<bool, String>> removerUsuario(int id);
}
