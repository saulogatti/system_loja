import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';

class UserCubit extends Cubit<UsuarioState> {
  final IUserRepository _userRepository;

  UserCubit(this._userRepository) : super(UsuarioState.initial());

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

    final ResultStatus<bool, String> executionResult = await _userRepository
        .adicionarUsuario(usuario);
    executionResult.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioAdicionado(usuario, true));
        } else {
          emit(
            UsuarioState.loadFailure(
              errorMessage: 'Não foi possível adicionar o usuário.',
            ),
          );
        }
      },
      onError: (resultError) {
        emit(UsuarioState.loadFailure(errorMessage: resultError));
      },
    );
  }

  Future<void> atualizarUsuario({required User usuarioAtualizado}) async {
    final ResultStatus<bool, String> resultAdd = await _userRepository
        .atualizarUsuario(usuarioAtualizado);
    resultAdd.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioAdicionado(usuarioAtualizado, false));
        } else {
          emit(
            UsuarioState.loadFailure(
              errorMessage: 'Falha ao atualizar usuário.',
            ),
          );
        }
      },
      onError: (resultError) {
        emit(
          UsuarioState.loadFailure(
            errorMessage: 'Falha ao atualizar usuário: $resultError',
          ),
        );
      },
    );
  }

  Future<void> loadUsuarios() async {
    final result = await _userRepository.obterTodosUsuarios();
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
    final result = await _userRepository.removerUsuario(id);
    result.when(
      onSuccess: (sucesso) {
        if (sucesso) {
          emit(UsuarioState.usuarioRemovido(id));
        } else {
          emit(
            UsuarioState.loadFailure(errorMessage: 'Falha ao remover usuário.'),
          );
        }
      },
      onError: (message) {
        emit(UsuarioState.loadFailure(errorMessage: message));
      },
    );
  }
}
