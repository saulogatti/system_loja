import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_user_repository.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/configuracoes/bloc/user_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_delete_confirm_dialog.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_details_dialog.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_form.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_list.dart';
import 'package:system_loja/screens/widgets/overlay_app_widget.dart';

import '../../core/models/user.dart';

/// Tela de gestão de usuários com listagem, adição, edição e exclusão.
///
/// Esta tela foi refatorada em widgets menores para melhor manutenibilidade:
/// - UsuarioForm: formulário de criação/edição
/// - UsuarioList: lista de usuários cadastrados
/// - UsuarioListItem: item individual da lista
/// - UsuarioDetailsDialog: dialog com detalhes do usuário
/// - UsuarioDeleteConfirmDialog: dialog de confirmação de exclusão
///
@RoutePage()
class UsuarioScreen extends StatefulWidget implements AutoRouteWrapper {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<UserCubit>(
      create: (_) => UserCubit(appInjection.get<IUserRepository>()),
      child: this,
    );
  }
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  AuthorizationLevel _nivelPermissaoSelecionado = AuthorizationLevel.usuarioComum;
  User? _usuarioEditando;
  final OverlayApp _overlayLoader = OverlayApp();
  List<User> _usuarios = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Usuários'),
        backgroundColor: Theme.of(context).colorScheme.primaryContainer,
        leading: const AutoLeadingButton(),
      ),
      body: BlocListener<UserCubit, UsuarioState>(
        bloc: context.read<UserCubit>(),
        listener: (context, state) {
          state.when(
            loadFailure: (errorMessage) {
              _overlayLoader.removeHighlightOverlay();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar usuários: $errorMessage'),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            loading: () {
              _overlayLoader.createHighlightOverlay(
                label: 'Carregando...',
                color: Colors.black,
                context: context,
                widget: widget,
              );
            },
            loadSuccess: (usuarios) {
              _overlayLoader.removeHighlightOverlay();
              _usuarios = List.from(usuarios, growable: true);
              setState(() {});
            },
            initial: () {
              // Estado inicial, nada a fazer
            },
            senhaInvalida: (mensagem) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(mensagem),
                  backgroundColor: Theme.of(context).colorScheme.error,
                ),
              );
            },
            usuarioRemovido: (id) {
              final usuario = _usuarios.firstWhere((usuario) => usuario.id == id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Usuário "${usuario.name}" excluído com sucesso!'),
                  backgroundColor: Colors.orange,
                ),
              );
              _usuarios.removeWhere((usuario) => usuario.id == id);
              if (_usuarioEditando?.id == id) {
                _cancelarEdicao();
              } else {
                setState(() {});
              }
            },
            usuarioAdicionado: (User usuario, bool novoUsuario) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    novoUsuario
                        ? 'Usuário "${usuario.name}" adicionado com sucesso!'
                        : 'Usuário "${usuario.name}" atualizado com sucesso!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              if (!novoUsuario) {
                final index = _usuarios.indexWhere((u) => u.id == usuario.id);
                if (index != -1) {
                  setState(() {
                    _usuarios[index] = usuario;
                  });
                }
              } else {
                _usuarios.add(usuario);
                _limparFormulario();
                setState(() {
                  _usuarioEditando = null;
                });
              }
            },
          );
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(parent: BouncingScrollPhysics()),
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    UsuarioForm(
                      formKey: _formKey,
                      nomeController: _nomeController,
                      emailController: _emailController,
                      senhaController: _senhaController,
                      nivelPermissaoSelecionado: _nivelPermissaoSelecionado,
                      usuarioEditando: _usuarioEditando,
                      onSubmit: _salvarUsuario,
                      onCancel: _cancelarEdicao,
                      onPermissaoChanged: (value) {
                        setState(() {
                          _nivelPermissaoSelecionado = value;
                        });
                      },
                    ),
                    const SizedBox(height: 32),
                    UsuarioList(
                      usuarios: _usuarios,
                      onEdit: _editarUsuario,
                      onDelete: _confirmarExclusao,
                      onTap: _mostrarDetalhesUsuario,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nomeController.dispose();
    _emailController.dispose();
    _senhaController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    context.read<UserCubit>().loadUsuarios();
  }

  void _cancelarEdicao() {
    setState(() {
      _usuarioEditando = null;
      _limparFormulario();
    });
  }

  void _confirmarExclusao(User usuario) {
    UsuarioDeleteConfirmDialog.show(context, usuario, () => _excluirUsuario(usuario));
  }

  void _editarUsuario(User usuario) {
    setState(() {
      _usuarioEditando = usuario;
      _nomeController.text = usuario.name;
      _emailController.text = usuario.email ?? '';
      _senhaController.clear();
      _nivelPermissaoSelecionado = AuthorizationLevel.values.firstWhere(
        (level) => level.value == usuario.permission,
      );
    });

    // Scroll para o topo
    final context = _formKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _excluirUsuario(User usuario) async {
    await context.read<UserCubit>().removerUsuario(usuario.id);

    // Se estava editando o usuário excluído, cancela a edição
    if (_usuarioEditando?.id == usuario.id) {
      _cancelarEdicao();
    }
  }

  void _limparFormulario() {
    _formKey.currentState?.reset();
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _nivelPermissaoSelecionado = AuthorizationLevel.usuarioComum;
  }

  void _mostrarDetalhesUsuario(User usuario) {
    UsuarioDetailsDialog.show(context, usuario);
  }

  Future<void> _salvarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final senha = _senhaController.text;

      if (_usuarioEditando == null) {
        // Criar novo usuário

        await context.read<UserCubit>().adicionarUsuario(
          nome: _nomeController.text.trim(),
          email: email,
          senha: senha,
          nivelPermissao: _nivelPermissaoSelecionado,
        );
      } else {
        // Atualizar usuário existente
        final user = _usuarioEditando!.copyWith(
          name: _nomeController.text.trim(),
          email: email,
          passwordHash: senha.isNotEmpty ? senha.hashPassword() : null,

          permission: _nivelPermissaoSelecionado.value,
        );
        await context.read<UserCubit>().atualizarUsuario(usuarioAtualizado: user);
      }
    }
  }
}
