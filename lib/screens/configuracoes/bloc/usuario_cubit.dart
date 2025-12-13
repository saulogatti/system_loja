import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/models/usuario.dart';
import 'package:system_loja/core/repository/user_repository.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';

class UsuarioCubit extends Cubit<UsuarioState> {
  final UserRepository _manager = UserRepository();

  UsuarioCubit() : super(UsuarioState.initial());

  Future<void> adicionarUsuario({
    required String nome,
    required String email,
    required String senha,
    required NivelPermissao nivelPermissao,
  }) async {
    try {
      // Lógica para adicionar usuário
      int usuarioId = await _manager.gerarProximoId(); // Exemplo de ID
      final usuario = Usuario(
        id: usuarioId,
        nome: nome,
        email: email,
        senhaHash: senha.hashSenha(),

        nivelPermissao: nivelPermissao,
      );

      bool sucesso = await _manager.adicionarUsuario(usuario);
      if (sucesso) {
        emit(UsuarioState.usuarioAdicionado(usuario, true));
      } else {
        emit(
          UsuarioState.loadFailure(errorMessage: 'Falha ao adicionar usuário.'),
        );
      }
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao adicionar usuário: $e'),
      );
    }
  }

  Future<void> atualizarUsuario({required Usuario usuarioAtualizado}) async {
    try {
      bool sucesso = await _manager.atualizarUsuario(usuarioAtualizado);
      if (sucesso) {
        emit(UsuarioState.usuarioAdicionado(usuarioAtualizado, false));
      } else {
        emit(
          UsuarioState.loadFailure(errorMessage: 'Falha ao atualizar usuário.'),
        );
      }
    } catch (e) {
      emit(
        UsuarioState.loadFailure(errorMessage: 'Erro ao atualizar usuário: $e'),
      );
    }
  }

  Future<void> removerUsuario(int id) async {
    try {
      bool sucesso = await _manager.removerUsuario(id);
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

  void validarSenha(String value) {}
}
