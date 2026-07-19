import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/interface/i_log_repository.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/repository_error_mapper.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';

/// Repositório para gerenciamento de usuários usando Drift.
///
/// Coordena operações CRUD sobre [User] via [UsersDao] e registra eventos
/// de auditoria via [ILogRepository]. Todos os erros são capturados
/// internamente e devolvidos como [ResultStatus.error] com mensagem amigável.
///
/// Veja também:
/// - [IUserRepository] - contrato da interface
/// - [UsersDao] - DAO do Drift
class UserRepository with LoggerClassMixin implements IUserRepository {
  UserRepository({required ILogRepository logRepository, required UsersDao usersDao})
    : _logRepository = logRepository,
      _usersDao = usersDao;
  final ILogRepository _logRepository;
  final UsersDao _usersDao;

  @override
  Future<ResultStatus<bool, String>> createUser(User user) async {
    try {
      final result = await _usersDao.insertUser(user);
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.criar,
        entityName: runtimeType.toString(),
        userId: result?.id ?? user.id,
        logDetails: 'Usuário ${user.name} (ID: ${result?.id ?? user.id}) criado.',
        username: user.name,
      );
      return ResultStatus.success(result != null);
    } catch (e) {
      return ResultStatus.error(mensagemErroRepositorio(e, contexto: 'Falha ao adicionar usuário'));
    }
  }

  @override
  Future<ResultStatus<bool, String>> deleteUser(int id) async {
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
    } catch (e) {
      return ResultStatus.error(mensagemErroRepositorio(e, contexto: 'Falha ao remover usuário'));
    }
  }

  @override
  Future<ResultStatus<List<User>, String>> fetchAllUsers() async {
    try {
      final res = await _usersDao.getAll();
      if (res.isEmpty) {
        logInfo('Nenhum usuário encontrado no banco de dados.');
        return ResultStatus.success([]);
      }
      return ResultStatus.success(res);
    } catch (e) {
      return ResultStatus.error(mensagemErroRepositorio(e, contexto: 'Falha ao listar usuários'));
    }
  }

  @override
  Future<ResultStatus<User?, String>> fetchUserById(int id) async {
    try {
      final dados = await _usersDao.getById(id);
      if (dados != null) {
        await _logRepository.createAndLogEntry(
          logActionType: ActionType.ler,
          entityName: runtimeType.toString(),
          userId: id,
          username: dados.name,
          logDetails: 'Usuário ${dados.name} (ID: ${dados.id}) carregado.',
        );
        return ResultStatus.success(dados);
      }
      return ResultStatus.success(null);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao buscar usuário por id'),
      );
    }
  }

  @override
  Future<ResultStatus<User?, String>> getUserByEmail(String email) async {
    try {
      final user = await _usersDao.findByEmail(email);
      return ResultStatus.success(user);
    } catch (e) {
      return ResultStatus.error(mensagemErroRepositorio(e, contexto: 'Falha ao buscar usuário por email'));
    }
  }

  @override
  Future<ResultStatus<bool, String>> updateUser(User usuario) async {
    try {
      final exists = await _usersDao.getById(usuario.id);
      if (exists == null) {
        return ResultStatus.error('Usuário com ID ${usuario.id} não encontrado.');
      }
      await _logRepository.createAndLogEntry(
        logActionType: ActionType.atualizar,
        entityName: runtimeType.toString(),
        userId: usuario.id,
        username: usuario.name,
      );
      final result = await _usersDao.updateUser(usuario);
      return ResultStatus.success(result);
    } catch (e) {
      return ResultStatus.error(mensagemErroRepositorio(e, contexto: 'Falha ao atualizar usuário'));
    }
  }
}
