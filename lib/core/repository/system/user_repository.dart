import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';

import '../../models/user.dart';

/// Gerenciador de Usuários
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
/// Implementa funcionalidades de hash de senha para segurança.
class UserRepository with LoggerClassMixin implements IUserRepository {
  final LogRepository _logRepository;
  final UsersDao _usersDao;
  UserRepository({
    required LogRepository logRepository,
    required UsersDao usersDao,
  }) : _logRepository = logRepository,
       _usersDao = usersDao;

  /// Tamanho mínimo da senha

  /// Adiciona um novo usuário
  ///
  /// A senha será automaticamente convertida em hash antes de salvar.
  /// Retorna true se o usuário foi adicionado com sucesso.
  @override
  Future<ResultStatus<bool, String>> adicionarUsuario(User usuario) async {
    final result = await _usersDao.insertUser(usuario);
    await _logRepository.createAndLogEntry(
      logActionType: ActionType.criar,
      entityName: runtimeType.toString(),
      logDetails: 'Usuário ${usuario.name} (ID: ${usuario.id}) criado.',
      userId: usuario.id,
      username: usuario.name,
    );
    return ResultStatus.success(result > 0);
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  @override
  Future<ResultStatus<bool, String>> atualizarUsuario(User usuario) async {
    final exists = await _usersDao.getById(usuario.id);
    if (exists == null) {
      return ResultStatus.error('Usuário com ID ${usuario.id} não encontrado.');
    } else {
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.atualizar,
        entityName: runtimeType.toString(),
        userId: usuario.id,
        username: usuario.name,
      );
      final result = await _usersDao.updateUser(usuario);
      return ResultStatus.success(result);
    }
  }

  /// Obtém todos os usuários
  @override
  Future<List<User>> obterTodosUsuarios() async {
    final res = await _usersDao.getAll();
    if (res.isEmpty) {
      logInfo('Nenhum usuário encontrado no banco de dados.');
      return [];
    }

    final usuariosCarregados = res;
    return usuariosCarregados;
  }

  /// Obtém um usuário por email
  @override
  Future<User?> obterUsuarioPorEmail(String email) async {
    return await _usersDao.findByEmail(email);
  }

  /// Obtém um usuário por ID
  @override
  Future<User?> obterUsuarioPorId(int id) async {
    final dados = await _usersDao.getById(id);
    if (dados != null) {
      final user = dados;
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.ler,
        entityName: runtimeType.toString(),
        userId: id,
        username: user.name,
        logDetails: 'Usuário ${user.name} (ID: ${user.id}) carregado.',
      );
      return user;
    }
    return null;
  }

  /// Remove um usuário pelo ID
  ///
  /// Retorna true se o usuário foi removido com sucesso.
  @override
  Future<bool> removerUsuario(int id) async {
    final resultado = await _usersDao.deleteUser(id);
    if (resultado > 0) {
      final success = true;
      logInfo('Usuário removido com sucesso: ID $id');
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.deletar,
        entityName: runtimeType.toString(),
        userId: id,
        username: '',
        logDetails: 'Usuário com ID $id removido.',
      );
      return success;
    }
    return false;
  }

  /// Valida o formato do email
  @override
  bool validarEmail(String email) {
    return email.isValidEmail();
  }
}
