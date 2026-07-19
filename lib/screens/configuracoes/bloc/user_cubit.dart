import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';

class UserCubit extends Cubit<UsuarioState> {
  UserCubit(this._userRepository) : super(UsuarioState.initial());
  final IUserRepository _userRepository;

  Future<void> adicionarUsuario({
    required String nome,
    required String email,
    required String senha,
    required AuthorizationLevel nivelPermissao,
  }) async {
    final usuario = User(
      name: nome,
      email: email,
      passwordHash: senha.hashPassword(),
      permission: nivelPermissao.value,
    );

    final executionResult = await _userRepository.createUser(usuario);
    executionResult.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioAdicionado(usuario, novoUsuario: true));
        } else {
          emit(
            const UsuarioState.loadFailure(errorMessage: 'Não foi possível adicionar o usuário.'),
          );
        }
      },
      onError: (resultError) {
        emit(UsuarioState.loadFailure(errorMessage: resultError));
      },
    );
  }

  Future<void> atualizarUsuario({required User usuarioAtualizado}) async {
    final resultAdd = await _userRepository.updateUser(usuarioAtualizado);
    resultAdd.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioAdicionado(usuarioAtualizado, novoUsuario: false));
        } else {
          emit(const UsuarioState.loadFailure(errorMessage: 'Falha ao atualizar usuário.'));
        }
      },
      onError: (resultError) {
        emit(UsuarioState.loadFailure(errorMessage: 'Falha ao atualizar usuário: $resultError'));
      },
    );
  }

  Future<void> loadUsuarios() async {
    final result = await _userRepository.fetchAllUsers();
    result.when(
      onSuccess: (usuarios) {
        emit(UsuarioState.loadSuccess(usuarios: usuarios));
      },
      onError: (message) {
        emit(UsuarioState.loadFailure(errorMessage: message));
      },
    );
  }

  Future<void> removerUsuario(int id) async {
    final result = await _userRepository.deleteUser(id);
    result.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioRemovido(id));
        } else {
          emit(const UsuarioState.loadFailure(errorMessage: 'Falha ao remover usuário.'));
        }
      },
      onError: (message) {
        emit(UsuarioState.loadFailure(errorMessage: message));
      },
    );
  }
}
