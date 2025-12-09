import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/validators.dart';

import '../core/managers/log_atividade_manager.dart';
import '../core/managers/usuario_manager.dart';
import '../core/models/extensions/nivel_permissao_extension.dart';
import '../core/models/log_atividade.dart';
import '../core/models/usuario.dart';

class UsuarioScreen extends StatefulWidget {
  const UsuarioScreen({super.key});

  @override
  State<UsuarioScreen> createState() => _UsuarioScreenState();
}

class _UsuarioScreenState extends State<UsuarioScreen> {
  final UsuarioManager _manager = UsuarioManager();
  final LogAtividadeManager _logManager = LogAtividadeManager();
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _senhaController = TextEditingController();
  NivelPermissao _nivelPermissaoSelecionado = NivelPermissao.usuarioComum;
  Usuario? _usuarioEditando;
  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestão de Usuários'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      _usuarioEditando == null
                          ? 'Novo Usuário'
                          : 'Editar Usuário',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: _nomeController,
                      decoration: const InputDecoration(
                        labelText: 'Nome *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person),
                      ),
                      validator: (value) => combineValidators([
                        (v) => validateRequired(v, 'Nome'),
                        (v) => validateMinLength(v, 3, 'Nome'),
                      ])(value),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.trim().isEmpty) {
                          return 'Email é obrigatório';
                        }
                        if (!_manager.validarEmail(value.trim())) {
                          return 'Email inválido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _senhaController,
                      decoration: InputDecoration(
                        labelText: _usuarioEditando == null
                            ? 'Senha *'
                            : 'Nova Senha (deixe vazio para manter)',
                        border: const OutlineInputBorder(),
                        prefixIcon: const Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _senhaVisivel
                                ? Icons.visibility_off
                                : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              _senhaVisivel = !_senhaVisivel;
                            });
                          },
                        ),
                        helperText:
                            'Mínimo 8 caracteres, com maiúscula, minúscula e número',
                        helperMaxLines: 2,
                      ),
                      obscureText: !_senhaVisivel,
                      validator: (value) {
                        // Se está editando e senha está vazia, não valida
                        if (_usuarioEditando != null &&
                            (value == null || value.isEmpty)) {
                          return null;
                        }
                        // Se está criando novo usuário, senha é obrigatória
                        if (_usuarioEditando == null &&
                            (value == null || value.isEmpty)) {
                          return 'Senha é obrigatória';
                        }
                        // Valida força da senha
                        if (value != null && value.isNotEmpty) {
                          final erroSenha = _manager.validarSenha(value);
                          if (erroSenha != null) {
                            return erroSenha;
                          }
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<NivelPermissao>(
                      initialValue: _nivelPermissaoSelecionado,
                      decoration: const InputDecoration(
                        labelText: 'Nível de Permissão *',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.security),
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: NivelPermissao.usuarioComum,
                          child: Text('Usuário Comum'),
                        ),
                        DropdownMenuItem(
                          value: NivelPermissao.administrador,
                          child: Text('Administrador'),
                        ),
                      ],
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _nivelPermissaoSelecionado = value;
                          });
                        }
                      },
                    ),
                    const SizedBox(height: 24),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton.icon(
                            onPressed: _salvarUsuario,
                            icon: Icon(
                              _usuarioEditando == null ? Icons.add : Icons.save,
                            ),
                            label: Text(
                              _usuarioEditando == null
                                  ? 'Adicionar Usuário'
                                  : 'Salvar Alterações',
                            ),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              textStyle: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                        if (_usuarioEditando != null) ...[
                          const SizedBox(width: 8),
                          ElevatedButton.icon(
                            onPressed: _cancelarEdicao,
                            icon: const Icon(Icons.cancel),
                            label: const Text('Cancelar'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: Colors.grey,
                            ),
                          ),
                        ],
                      ],
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Usuários Cadastrados',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (_manager.usuarios.isEmpty)
                      const Center(
                        child: Padding(
                          padding: EdgeInsets.all(32.0),
                          child: Text(
                            'Nenhum usuário cadastrado',
                            style: TextStyle(fontSize: 16, color: Colors.grey),
                          ),
                        ),
                      )
                    else
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: _manager.usuarios.length,
                        itemBuilder: (context, index) {
                          final usuario = _manager.usuarios[index];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              minLeadingWidth: 0,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              minVerticalPadding: 0,
                              titleAlignment: ListTileTitleAlignment.center,

                              leading: CircleAvatar(
                                backgroundColor:
                                    usuario.nivelPermissao ==
                                        NivelPermissao.administrador
                                    ? Colors.purple
                                    : Colors.blue,
                                child: Icon(
                                  usuario.nivelPermissao ==
                                          NivelPermissao.administrador
                                      ? Icons.admin_panel_settings
                                      : Icons.person,
                                  color: Colors.white,
                                ),
                              ),
                              title: Text(
                                usuario.nome,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              subtitle: Text(
                                '${usuario.email}\n${_getNivelPermissaoTexto(usuario.nivelPermissao)}',
                              ),
                              isThreeLine: true,
                              trailing: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.edit,
                                      color: Colors.blue,
                                    ),
                                    onPressed: () => _editarUsuario(usuario),
                                  ),
                                  IconButton(
                                    icon: const Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                    ),
                                    onPressed: () =>
                                        _confirmarExclusao(usuario),
                                  ),
                                ],
                              ),
                              onTap: () {
                                _mostrarDetalhesUsuario(usuario);
                              },
                            ),
                          );
                        },
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
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

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  void _cancelarEdicao() {
    setState(() {
      _usuarioEditando = null;
      _limparFormulario();
    });
  }

  void _confirmarExclusao(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmar Exclusão'),
        content: Text('Deseja realmente excluir o usuário "${usuario.nome}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await _excluirUsuario(usuario);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text('Excluir'),
          ),
        ],
      ),
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
    final sucesso = await _manager.removerUsuario(usuario.id);

    if (sucesso) {
      // Registra log de atividade
      await _logManager.criarERegistrarLog(
        tipoAcao: TipoAcao.deletar,
        entidade: 'Usuario',
        entidadeId: usuario.id,
        usuarioId: usuario.id,
        usuarioNome: usuario.nome,
        detalhes: 'Usuário ${usuario.nome} (${usuario.email}) excluído',
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Usuário "${usuario.nome}" excluído com sucesso!'),
          backgroundColor: Colors.orange,
        ),
      );

      // Se estava editando o usuário excluído, cancela a edição
      if (_usuarioEditando?.id == usuario.id) {
        _cancelarEdicao();
      }

      setState(() {});
    }
  }

  String _getNivelPermissaoTexto(NivelPermissao nivel) {
    return nivel.toDisplayName();
  }

  void _limparFormulario() {
    _formKey.currentState?.reset();
    _nomeController.clear();
    _emailController.clear();
    _senhaController.clear();
    _nivelPermissaoSelecionado = NivelPermissao.usuarioComum;
    _senhaVisivel = false;
  }

  void _mostrarDetalhesUsuario(Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(usuario.nome),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildDetailRow('ID', usuario.id.toString()),
              _buildDetailRow('Email', usuario.email),
              _buildDetailRow(
                'Nível de Permissão',
                _getNivelPermissaoTexto(usuario.nivelPermissao),
              ),
              _buildDetailRow(
                'Data de Cadastro',
                usuario.dataCadastro.toString().split('.')[0],
              ),
              _buildDetailRow(
                'Última Atualização',
                usuario.dataUltimaAtualizacao.toString().split('.')[0],
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }

  void _salvarUsuario() async {
    if (_formKey.currentState!.validate()) {
      final email = _emailController.text.trim();
      final senha = _senhaController.text;

      if (_usuarioEditando == null) {
        // Criar novo usuário
        // Verifica se email já existe
        if (_manager.emailJaExiste(email)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro: Email já cadastrado!'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final senhaHash = _manager.hashSenha(senha);

        final usuario = Usuario(
          id: _manager.gerarProximoId(),
          nome: _nomeController.text.trim(),
          email: email,
          senhaHash: senhaHash,
          nivelPermissao: _nivelPermissaoSelecionado,
        );

        final sucesso = await _manager.adicionarUsuario(usuario);

        if (sucesso) {
          // Registra log de atividade
          await _logManager.criarERegistrarLog(
            tipoAcao: TipoAcao.criar,
            entidade: 'Usuario',
            entidadeId: usuario.id,
            usuarioId: usuario.id,
            usuarioNome: usuario.nome,
            detalhes:
                'Usuário ${usuario.nome} (${usuario.email}) criado com nível ${_getNivelPermissaoTexto(usuario.nivelPermissao)}',
          );

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Usuário "${usuario.nome}" cadastrado com sucesso!',
              ),
              backgroundColor: Colors.green,
            ),
          );

          _limparFormulario();
          setState(() {});
        }
      } else {
        // Atualizar usuário existente
        // Verifica se email já existe (excluindo o próprio usuário)
        if (_manager.emailJaExiste(email, ignorarId: _usuarioEditando!.id)) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Erro: Email já cadastrado!'),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        // Se a senha foi alterada, gera novo hash
        String senhaHash = _usuarioEditando!.senhaHash;
        if (senha.isNotEmpty) {
          senhaHash = _manager.hashSenha(senha);
        }

        final usuarioAtualizado = Usuario(
          id: _usuarioEditando!.id,
          nome: _nomeController.text.trim(),
          email: email,
          senhaHash: senhaHash,
          nivelPermissao: _nivelPermissaoSelecionado,
          dataCadastro: _usuarioEditando!.dataCadastro,
        );

        final sucesso = await _manager.atualizarUsuario(usuarioAtualizado);

        if (sucesso) {
          // Registra log de atividade
          await _logManager.criarERegistrarLog(
            tipoAcao: TipoAcao.atualizar,
            entidade: 'Usuario',
            entidadeId: usuarioAtualizado.id,
            usuarioId: usuarioAtualizado.id,
            usuarioNome: usuarioAtualizado.nome,
            detalhes: 'Usuário ${usuarioAtualizado.nome} atualizado',
          );

          if (!mounted) return;

          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                'Usuário "${usuarioAtualizado.nome}" atualizado com sucesso!',
              ),
              backgroundColor: Colors.green,
            ),
          );

          _limparFormulario();
          setState(() {
            _usuarioEditando = null;
          });
        }
      }
    }
  }
}
