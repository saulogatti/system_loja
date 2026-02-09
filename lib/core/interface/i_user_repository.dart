import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class IUserRepository {
  Future<ResultStatus<bool, String>> adicionarUsuario(User usuario);
  Future<ResultStatus<bool, String>> atualizarUsuario(User usuario);
  Future<List<User>> obterTodosUsuarios();
  Future<User?> obterUsuarioPorEmail(String email);
  Future<User?> obterUsuarioPorId(int id);
  Future<bool> removerUsuario(int id);
  bool validarEmail(String email);
}
