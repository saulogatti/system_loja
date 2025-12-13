import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/usuario.dart';

part 'usuario_state.freezed.dart';

@freezed
sealed class UsuarioState with _$UsuarioState {
  factory UsuarioState.initial() = UsuarioStateInitial;

  const factory UsuarioState.loadFailure({required String errorMessage}) =
      UsuarioStateLoadFailure;

  const factory UsuarioState.loading() = UsuarioStateLoading;

  const factory UsuarioState.loadSuccess({required List<Usuario> usuarios}) =
      UsuarioStateLoadSuccess;
  const factory UsuarioState.senhaInvalida(String mensagem) = UsuarioStateSenhaInvalida;
  const factory UsuarioState.usuarioRemovido(int id) = UsuarioStateUsuarioRemovido;
  const factory UsuarioState.usuarioAdicionado(Usuario usuario, bool novoUsuario) = UsuarioStateUsuarioAdicionado;
}
