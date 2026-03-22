import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/utils/string_extensions.dart';
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
    // Lógica para adicionar usuário
    try {
      // Exemplo de ID
      final usuario = User(
        name: nome,
        email: email,
        passwordHash: senha.hashPassword(),

        permission: nivelPermissao.value,
      );

      final ResultStatus<bool, String> executionResult = await _userRepository
          .adicionarUsuario(usuario);
      executionResult.when(
        onSuccess: (sucess) {
          emit(UsuarioState.usuarioAdicionado(usuario, true));
        },
        onError: (resultError) {
          emit(UsuarioState.loadFailure(errorMessage: resultError));
        },
      );
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao adicionar usuário: $e'),
      );
    }
  }

  Future<void> atualizarUsuario({required User usuarioAtualizado}) async {
    try {
      final ResultStatus<bool, String> resultAdd = await _userRepository
          .atualizarUsuario(usuarioAtualizado);
      switch (resultAdd) {
        case ResultSuccess(result: final sucesso):
          if (sucesso) {
            emit(UsuarioState.usuarioAdicionado(usuarioAtualizado, false));
          }
        case ResultError(:final resultError):
          emit(
            UsuarioState.loadFailure(
              errorMessage: 'Falha ao atualizar usuário: $resultError',
            ),
          );
      }
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao atualizar usuário: $e'),
      );
    }
  }

  Future<void> loadUsuarios() async {
    try {
      final usuarios = await _userRepository.obterTodosUsuarios();
      emit(UsuarioState.loadSuccess(usuarios: usuarios));
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao carregar usuários: $e'),
      );
    }
  }

  Future<void> removerUsuario(int id) async {
    try {
      final bool sucesso = await _userRepository.removerUsuario(id);
      if (sucesso) {
        emit(UsuarioState.usuarioRemovido(id));
      } else {
        emit(
          UsuarioState.loadFailure(errorMessage: 'Falha ao remover usuário.'),
        );
      }
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao remover usuário: $e'),
      );
    }
  }
}
