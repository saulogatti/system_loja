import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/usuario.dart';
import 'package:system_loja/core/repository/user_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  final UserRepository _userRepository;

  UsuarioCubit(this._userRepository) : super(UsuarioState.initial());

  Future<void> adicionarUsuario({
    required String nome,
    required String email,
    required String senha,
    required NivelPermissao nivelPermissao,
  }) async {
    // Lógica para adicionar usuário
    try {
      int usuarioId = await _userRepository.obtainNextId(); // Exemplo de ID
      final usuario = Usuario(
        id: usuarioId,
        nome: nome,
        email: email,
        senhaHash: senha.hashSenha(),

        nivelPermissao: nivelPermissao,
      );

      ExecutionResult<bool, String> executionResult = await _userRepository
          .adicionarUsuario(usuario);
      executionResult.when(
        onSuccess: (sucess) {
          emit(UsuarioState.usuarioAdicionado(usuario, true));
        },
        onError: (error) {
          emit(UsuarioState.loadFailure(errorMessage: error));
        },
      );
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao adicionar usuário: $e'),
      );
    }
  }

  Future<void> atualizarUsuario({required Usuario usuarioAtualizado}) async {
    try {
      ExecutionResult<bool, String> resultAdd = await _userRepository
          .atualizarUsuario(usuarioAtualizado);
      switch (resultAdd) {
        case ExecutionSucess(result: final sucesso):
          if (sucesso) {
            emit(UsuarioState.usuarioAdicionado(usuarioAtualizado, false));
          }
        case ExecutionError(failure: final errorMessage):
          emit(
            UsuarioState.loadFailure(
              errorMessage: 'Falha ao atualizar usuário: $errorMessage',
            ),
          );
      }
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao atualizar usuário: $e'),
      );
    }
  }

  void loadUsuarios() async {
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
      bool sucesso = await _userRepository.removerUsuario(id);
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
