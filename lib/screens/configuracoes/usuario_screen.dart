import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/repository/user_repository.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/usuario_state.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_delete_confirm_dialog.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_details_dialog.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_form.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_list.dart';
import 'package:system_loja/screens/widgets/overlay_app_widget.dart';

import '../../core/managers/log_atividade_manager.dart';
import '../../core/models/log_atividade.dart';
import '../../core/models/usuario.dart';

/// Tela de gestão de usuários com listagem, adição, edição e exclusão.
///
/// Esta tela foi refatorada em widgets menores para melhor manutenibilidade:
/// - UsuarioForm: formulário de criação/edição
/// - UsuarioList: lista de usuários cadastrados
/// - UsuarioListItem: item individual da lista
/// - UsuarioDetailsDialog: dialog com detalhes do usuário
/// - UsuarioDeleteConfirmDialog: dialog de confirmação de exclusão
class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  late final UsuarioCubit _bloc = UsuarioCubit(UserRepository());
  final LogAtividadeManager _logManager = LogAtividadeManager();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  NivelPermissao _nivelPermissaoSelecionado = NivelPermissao.usuarioComum;
  Usuario? _usuarioEditando;
  final OverlayApp _overlayLoader = OverlayApp();
  List<Usuario> _usuarios = List.empty(growable: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Usuários'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocListener<UsuarioCubit, UsuarioState>(
        bloc: _bloc,
        listener: (context, state) {
          state.when(
            loadFailure: (errorMessage) {
              _overlayLoader.removeHighlightOverlay();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Erro ao carregar usuários: $errorMessage'),
                  backgroundColor: Colors.red,
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
              _usuarios = usuarios;
              setState(() {});
            },
            initial: () {
              // Estado inicial, nada a fazer
            },
            senhaInvalida: (mensagem) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(mensagem), backgroundColor: Colors.red),
              );
            },
            usuarioRemovido: (id) {
              final usuario = _usuarios.firstWhere(
                (usuario) => usuario.id == id,
              );
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'Usuário "${usuario.nome}" excluído com sucesso!',
                  ),
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
            usuarioAdicionado: (Usuario usuario, bool novoUsuario) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    novoUsuario
                        ? 'Usuário "${usuario.nome}" adicionado com sucesso!'
                        : 'Usuário "${usuario.nome}" atualizado com sucesso!',
                  ),
                  backgroundColor: Colors.green,
                ),
              );
              _usuarios.add(usuario);
              _limparFormulario();
              setState(() {
                _usuarioEditando = null;
              });
            },
          );
        },
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(
                  parent: BouncingScrollPhysics(),
                ),
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
    _bloc.loadUsuarios();
  }

  void _cancelarEdicao() {
    setState(() {
      _usuarioEditando = null;
      _limparFormulario();
    });
  }

  void _confirmarExclusao(Usuario usuario) {
    UsuarioDeleteConfirmDialog.show(
      context,
      usuario,
      () => _excluirUsuario(usuario),
    );
  }

  void _editarUsuario(Usuario usuario) {
    setState(() {
      _usuarioEditando = usuario;
      _nomeController.text = usuario.nome;
      _emailController.text = usuario.email;
      _senhaController.clear();
      _nivelPermissaoSelecionado = usuario.nivelPermissao;
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

  Future<void> _excluirUsuario(Usuario usuario) async {
    _bloc.removerUsuario(usuario.id);

    // Registra log de atividade
    await _logManager.criarERegistrarLog(
      tipoAcao: TipoAcao.deletar,
      entidade: 'Usuario',
      entidadeId: usuario.id,
      usuarioId: usuario.id,
      usuarioNome: usuario.nome,
      detalhes: 'Usuário ${usuario.nome} (${usuario.email}) excluído',
    );

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
    _nivelPermissaoSelecionado = NivelPermissao.usuarioComum;
  }

  void _mostrarDetalhesUsuario(Usuario usuario) {
    UsuarioDetailsDialog.show(context, usuario);
  }

  void _salvarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final senha = _senhaController.text;

      if (_usuarioEditando == null) {
        // Criar novo usuário

        await _bloc.adicionarUsuario(
          nome: _nomeController.text.trim(),
          email: email,
          senha: senha,
          nivelPermissao: _nivelPermissaoSelecionado,
        );

        // Registra log de atividade
        // await _logManager.criarERegistrarLog(
        //   tipoAcao: TipoAcao.criar,
        //   entidade: 'Usuario',
        //   entidadeId: usuario.id,
        //   usuarioId: usuario.id,
        //   usuarioNome: usuario.nome,
        //   detalhes:
        //       'Usuário ${usuario.nome} (${usuario.email}) criado com nível ${_getNivelPermissaoTexto(usuario.nivelPermissao)}',
        // );
      } else {
        // Atualizar usuário existente
        final user = _usuarioEditando!.copyWith(
          nome: _nomeController.text.trim(),
          email: email,
          senhaHash: senha,

          nivelPermissao: _nivelPermissaoSelecionado,
          dataUltimaAtualizacao: DateTime.now(),
        );
        await _bloc.atualizarUsuario(usuarioAtualizado: user);

        // // Registra log de atividade
        // await _logManager.criarERegistrarLog(
        //   tipoAcao: TipoAcao.atualizar,
        //   entidade: 'Usuario',
        //   entidadeId: usuarioAtualizado.id,
        //   usuarioId: usuarioAtualizado.id,
        //   usuarioNome: usuarioAtualizado.nome,
        //   detalhes: 'Usuário ${usuarioAtualizado.nome} atualizado',
        // );
      }
    }
  }
}
