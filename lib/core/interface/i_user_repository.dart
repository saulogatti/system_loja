import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/database/system_database.dart';

/// Contrato de persistência de usuários do sistema.
///
/// {@category contratos}
/// {@subCategory Sistema}
///
/// CRUD de [User] no [SystemDatabase] (Drift). Erros voltam como
/// [ResultStatus.error].
///
/// Resolver com `appInjection.get<IUserRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<IUserRepository>();
/// final resultado = await repository.getUserByEmail('admin@system.com');
/// resultado.when(
///   onSuccess: (user) => print(user?.name),
///   onError: (mensagem) => print(mensagem),
/// );
/// ```
///
/// Veja também:
/// - [User] — modelo de domínio
/// - [ResultStatus] — retorno das operações
abstract interface class IUserRepository {
  /// Adiciona um novo usuário ao sistema.
  ///
  /// Parâmetros:
  /// - [user]: Objeto User a ser adicionado
  ///
  /// Retorna:
  /// - [ResultStatus] com true se adicionado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> createUser(User user);

  /// Remove um usuário do sistema pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do usuário a ser removido
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removido com sucesso
  Future<ResultStatus<bool, String>> deleteUser(int id);

  /// Retorna todos os usuários cadastrados no sistema.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de usuários (vazia se não houver usuários)
  Future<ResultStatus<List<User>, String>> fetchAllUsers();

  /// Busca um usuário específico pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do usuário
  ///
  /// Retorna:
  /// - [ResultStatus] com [User] encontrado ou null se não existir
  Future<ResultStatus<User?, String>> fetchUserById(int id);

  /// Busca um usuário pelo endereço de email.
  ///
  /// Útil para autenticação e verificação de duplicidade.
  ///
  /// Parâmetros:
  /// - [email]: Email do usuário a ser buscado
  ///
  /// Retorna:
  /// - [ResultStatus] com [User] encontrado ou null se não existir
  Future<ResultStatus<User?, String>> getUserByEmail(String email);

  /// Atualiza os dados de um usuário existente.
  ///
  /// O usuário deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [user]: Objeto User com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateUser(User user);
}
