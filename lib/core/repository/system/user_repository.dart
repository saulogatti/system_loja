import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/models/log_atividade.dart';
import 'package:system_loja/core/repository/system/log_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/data/database/dao/users_dao.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

import '../../models/user.dart';

/// Gerenciador de Usuários
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
/// Implementa funcionalidades de hash de senha para segurança.
class UserRepository with LoggerClassMixin {
  final LogRepository _logManager = LogRepository();

  /// Tamanho mínimo da senha
  UsersDao defaultDataStorage = AppInjection.instance.systemDatabase.usersDao;
  UserRepository();

  /// Adiciona um novo usuário
  ///
  /// A senha será automaticamente convertida em hash antes de salvar.
  /// Retorna true se o usuário foi adicionado com sucesso.
  Future<ExecutionResult<bool, String>> adicionarUsuario(User usuario) async {
    final result = await defaultDataStorage.insertUser(usuario);
    await _logManager.criarERegistrarLog(
      tipoAcao: TipoAcao.criar,
      entidade: runtimeType.toString(),
      detalhes: 'Usuário ${usuario.name} (ID: ${usuario.id}) criado.',
      usuarioId: usuario.id,
      usuarioNome: usuario.name,
    );
    return ExecutionResult.success(result > 0);
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  Future<ExecutionResult<bool, String>> atualizarUsuario(User usuario) async {
    final exists = await defaultDataStorage.getById(usuario.id);
    if (exists == null) {
      return ExecutionResult.error(
        'Usuário com ID ${usuario.id} não encontrado.',
      );
    } else {
      await _logManager.criarERegistrarLog(
        tipoAcao: TipoAcao.atualizar,
        entidade: runtimeType.toString(),
        usuarioId: usuario.id,
        usuarioNome: usuario.name,
      );
      final result = await defaultDataStorage.updateUser(usuario);
      return ExecutionResult.success(result);
    }
  }

  /// Obtém todos os usuários
  Future<List<User>> obterTodosUsuarios() async {
    final res = await defaultDataStorage.getAll();
    if (res.isEmpty) {
      logInfo('Nenhum usuário encontrado no banco de dados.');
      return [];
    }

    final usuariosCarregados = res;
    return usuariosCarregados;
  }

  /// Obtém um usuário por email
  Future<User?> obterUsuarioPorEmail(String email) async {
    return await defaultDataStorage.findByEmail(email);
  }

  /// Obtém um usuário por ID
  Future<User?> obterUsuarioPorId(int id) async {
    final dados = await defaultDataStorage.getById(id);
    if (dados != null) {
      final user = dados;
      await _logManager.criarERegistrarLog(
        tipoAcao: TipoAcao.ler,
        entidade: runtimeType.toString(),
        usuarioId: id,
        usuarioNome: user.name,
        detalhes: 'Usuário ${user.name} (ID: ${user.id}) carregado.',
      );
      return user;
    }
    return null;
  }

  /// Remove um usuário pelo ID
  ///
  /// Retorna true se o usuário foi removido com sucesso.
  Future<bool> removerUsuario(int id) async {
    final resultado = await defaultDataStorage.deleteUser(id);
    if (resultado > 0) {
      final success = true;
      logInfo('Usuário removido com sucesso: ID $id');
      await _logManager.criarERegistrarLog(
        tipoAcao: TipoAcao.deletar,
        entidade: runtimeType.toString(),
        usuarioId: id,
        usuarioNome: '',
        detalhes: 'Usuário com ID $id removido.',
      );
      return success;
    }
    return false;
  }

  /// Valida o formato do email
  bool validarEmail(String email) {
    return email.isValidEmail();
  }
}
