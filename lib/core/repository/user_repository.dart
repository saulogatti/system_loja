import 'package:log_custom_printer/log_custom_printer.dart';
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
  /// Tamanho mínimo da senha

  UserRepository();

  /// Adiciona um novo usuário
  ///
  /// A senha será automaticamente convertida em hash antes de salvar.
  /// Retorna true se o usuário foi adicionado com sucesso.
  Future<bool> adicionarUsuario(Usuario usuario) async {
    PersistentDataStore persistentDataStore = PersistentDataStore(
      id: usuario.id,
      data: usuario.toJson(),
    );
    return await defaultDataStorage.save(persistentDataStore);
  }

  /// Atualiza um usuário existente
  ///
  /// Retorna true se o usuário foi atualizado com sucesso.
  Future<bool> atualizarUsuario(Usuario usuario) async {
    final exists = await defaultDataStorage.fetchById(usuario.id);
    switch (exists) {
      case OperationSuccess(result: final data):
        Usuario userExisting = Usuario.fromJson(data.data);
        userExisting = usuario.copyWith(
          nome: usuario.nome,
          email: usuario.email,
          senhaHash: usuario.senhaHash,
          nivelPermissao: usuario.dadosUsuario.nivelPermissao,
          dataCadastro: userExisting.registrationDate,
          dataUltimaAtualizacao: DateTime.now(),
        );
        PersistentDataStore persistentDataStore = PersistentDataStore(
          id: userExisting.id,
          data: userExisting.toJson(),
        );
        return await defaultDataStorage.save(persistentDataStore);

      case OperationError(error: final errorMessage):
        logError(
          'Erro ao buscar usuário para atualização: $errorMessage',
          StackTrace.current,
        );
        return false;
    }
  }

  /// Gera o próximo ID disponível
  Future<int> gerarProximoId() async {
    return obtainNextId();
  }

  /// Obtém todos os usuários
  Future<List<Usuario>> obterTodosUsuarios() async {
    final dados = await defaultDataStorage.loadAll();
    switch (dados) {
      case OperationSuccess(result: final dataList):
        final usuariosCarregados = dataList
            .map((data) => Usuario.fromJson(data.data))
            .toList();
        return usuariosCarregados;
      case OperationError(error: final errorMessage):
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
      case OperationSuccess(result: final dataList):
        final usuariosCarregados = dataList
            .map((data) => Usuario.fromJson(data.data))
            .toList();
        return usuariosCarregados
            .where((u) => u.email.toLowerCase() == email.toLowerCase())
            .firstOrNull;
      case OperationError(error: final errorMessage):
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
      case OperationSuccess(result: final data):
        return Usuario.fromJson(data.data);
      case OperationError(error: final errorMessage):
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
      case OperationSuccess(result: final success):
        logInfo('Usuário removido com sucesso: ID $id');
        return success;
      case OperationError(error: final errorMessage):
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
