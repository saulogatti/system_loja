import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/managers/log_atividade_manager.dart';
import 'package:system_loja/core/models/log_atividade.dart';
import 'package:system_loja/core/repository/default/base_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';

import '../models/usuario.dart';

/// Gerenciador de Usuários
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
/// Implementa funcionalidades de hash de senha para segurança.
class UserRepository extends BaseRepository with LoggerClassMixin {
  final LogAtividadeManager _logManager = LogAtividadeManager();

  /// Tamanho mínimo da senha

  UserRepository();

  /// Adiciona um novo usuário
  ///
  /// A senha será automaticamente convertida em hash antes de salvar.
  /// Retorna true se o usuário foi adicionado com sucesso.
  Future<ExecutionResult<bool, String>> adicionarUsuario(
    Usuario usuario,
  ) async {
    final PersistentDataStore persistentDataStore = PersistentDataStore(
      id: usuario.id,
      data: usuario.toJson(),
    );
    final result = await defaultDataStorage.save(persistentDataStore);
    await _logManager.criarERegistrarLog(
      tipoAcao: TipoAcao.criar,
      entidade: runtimeType.toString(),
      entidadeId: usuario.id,
      detalhes: 'Usuário ${usuario.nome} (ID: ${usuario.id}) criado.',
      usuarioId: usuario.id,
      usuarioNome: usuario.nome,
    );
    return ExecutionResult.success(result);
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  Future<ExecutionResult<bool, String>> atualizarUsuario(
    Usuario usuario,
  ) async {
    final exists = await defaultDataStorage.fetchById(usuario.id);
    switch (exists) {
      case ExecutionSucess(result: final data):
        Usuario userExisting = Usuario.fromJson(data.data);
        userExisting = usuario.copyWith(
          nome: usuario.nome,
          email: usuario.email,
          senhaHash: usuario.senhaHash,
          nivelPermissao: usuario.dadosUsuario.nivelPermissao,
          dataCadastro: userExisting.registrationDate,
          dataUltimaAtualizacao: DateTime.now(),
        );
        final PersistentDataStore persistentDataStore = PersistentDataStore(
          id: userExisting.id,
          data: userExisting.toJson(),
        );
        await _logManager.criarERegistrarLog(
          tipoAcao: TipoAcao.atualizar,
          entidade: runtimeType.toString(),
          usuarioId: usuario.id,
          usuarioNome: usuario.nome,
        );
        return ExecutionResult.success(
          await defaultDataStorage.save(persistentDataStore),
        );

      case ExecutionError(failure: final errorMessage):
        return ExecutionResult.error(errorMessage);
    }
  }

  /// Obtém todos os usuários
  Future<List<Usuario>> obterTodosUsuarios() async {
    final dados = await defaultDataStorage.loadAll();
    switch (dados) {
      case ExecutionSucess(result: final dataList):
        final usuariosCarregados = dataList
            .map((data) => Usuario.fromJson(data.data))
            .toList();
        return usuariosCarregados;
      case ExecutionError(failure: final errorMessage):
        logError(
          'Erro ao carregar usuários: $errorMessage',
          StackTrace.current,
        );
        return [];
    }
  }

  /// Obtém um usuário por email
  Future<Usuario?> obterUsuarioPorEmail(String email) async {
    final dados = await defaultDataStorage.loadAll();
    switch (dados) {
      case ExecutionSucess(result: final dataList):
        final usuariosCarregados = dataList
            .map((data) => Usuario.fromJson(data.data))
            .toList();
        return usuariosCarregados
            .where((u) => u.email.toLowerCase() == email.toLowerCase())
            .firstOrNull;
      case ExecutionError(failure: final errorMessage):
        logError(
          'Erro ao carregar usuários: $errorMessage',
          StackTrace.current,
        );
        return null;
    }
  }

  /// Obtém um usuário por ID
  Future<Usuario?> obterUsuarioPorId(int id) async {
    final dados = await defaultDataStorage.fetchById(id);
    switch (dados) {
      case ExecutionSucess(result: final data):
        final user = Usuario.fromJson(data.data);
        await _logManager.criarERegistrarLog(
          tipoAcao: TipoAcao.ler,
          entidade: runtimeType.toString(),
          usuarioId: id,
          usuarioNome: user.nome,
          detalhes: 'Usuário ${user.nome} (ID: ${user.id}) carregado.',
        );
        return user;
      case ExecutionError(failure: final errorMessage):
        logError(
          'Erro ao carregar usuário por ID $id: $errorMessage',
          StackTrace.current,
        );
        return null;
    }
  }

  /// Remove um usuário pelo ID
  ///
  /// Retorna true se o usuário foi removido com sucesso.
  Future<bool> removerUsuario(int id) async {
    final resultado = await defaultDataStorage.delete(id);
    switch (resultado) {
      case ExecutionSucess(result: final success):
        logInfo('Usuário removido com sucesso: ID $id');
        await _logManager.criarERegistrarLog(
          tipoAcao: TipoAcao.deletar,
          entidade: runtimeType.toString(),
          usuarioId: id,
          usuarioNome: '',
          detalhes: 'Usuário com ID $id removido.',
        );
        return success;
      case ExecutionError(failure: final errorMessage):
        logError(
          'Erro ao remover usuário por ID $id: $errorMessage',
          StackTrace.current,
        );
        return false;
    }
  }

  /// Valida o formato do email
  bool validarEmail(String email) {
    return email.isValidEmail();
  }

  /// Verifica se a senha corresponde ao hash armazenado
  bool verificarSenha(String senha, String senhaHash) {
    return senha.hashSenha() == senhaHash;
  }
}
