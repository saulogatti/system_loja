import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/aplication/system_error_manager.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';

import '../../../core/models/user.dart';

/// Gerenciador de Usuários
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
/// Implementa funcionalidades de hash de senha para segurança.
class UserRepository with LoggerClassMixin implements IUserRepository {
  final ILogRepository _logRepository;
  final UsersDao _usersDao;
  UserRepository({
    required ILogRepository logRepository,
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
    try {
      final result = await _usersDao.insertUser(usuario);
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.criar,
        entityName: runtimeType.toString(),
        userId: result?.id ?? usuario.id,
        logDetails:
            'Usuário ${usuario.name} (ID: ${result?.id ?? usuario.id}) criado.',
        username: usuario.name,
      );
      return ResultStatus.success(result != null);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao adicionar usuário: $e', stackTrace);
      return ResultStatus.error('Erro ao adicionar usuário.');
    }
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  @override
  Future<ResultStatus<bool, String>> atualizarUsuario(User usuario) async {
    try {
      final exists = await _usersDao.getById(usuario.id);
      if (exists == null) {
        return ResultStatus.error(
          'Usuário com ID ${usuario.id} não encontrado.',
        );
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
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao atualizar usuário: $e', stackTrace);
      return ResultStatus.error('Erro ao atualizar usuário.');
    }
  }

  /// Obtém todos os usuários
  @override
  Future<ResultStatus<List<User>, String>> obterTodosUsuarios() async {
    try {
      final res = await _usersDao.getAll();
      if (res.isEmpty) {
        logInfo('Nenhum usuário encontrado no banco de dados.');
        return ResultStatus.success([]);
      }

      return ResultStatus.success(res);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao buscar usuários: $e', stackTrace);
      return ResultStatus.error('Erro ao carregar usuários.');
    }
  }

  /// Obtém um usuário por email
  @override
  Future<ResultStatus<User?, String>> obterUsuarioPorEmail(String email) async {
    try {
      return ResultStatus.success(await _usersDao.findByEmail(email));
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao buscar usuário por email: $e', stackTrace);
      return ResultStatus.error('Erro ao buscar usuário por email.');
    }
  }

  /// Obtém um usuário por ID
  @override
  Future<ResultStatus<User?, String>> obterUsuarioPorId(int id) async {
    try {
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
        return ResultStatus.success(user);
      }
      return ResultStatus.success(null);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao buscar usuário por ID: $e', stackTrace);
      return ResultStatus.error('Erro ao buscar usuário por ID.');
    }
  }

  /// Remove um usuário pelo ID
  ///
  /// Retorna true se o usuário foi removido com sucesso.
  @override
  Future<ResultStatus<bool, String>> removerUsuario(int id) async {
    try {
      final resultado = await _usersDao.deleteUser(id);
      if (resultado > 0) {
        logInfo('Usuário removido com sucesso: ID $id');
        await _logRepository.createAndLogEntry(
          logActionType: ActionType.deletar,
          entityName: runtimeType.toString(),
          userId: id,
          username: '',
          logDetails: 'Usuário com ID $id removido.',
        );
        return ResultStatus.success(true);
      }
      return ResultStatus.error('Usuário com ID $id não encontrado.');
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      logError('Erro ao remover usuário: $e', stackTrace);
      return ResultStatus.error('Erro ao remover usuário.');
    }
  }
}
