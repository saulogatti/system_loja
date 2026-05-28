import 'package:flutter/material.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/screens/utils/validators.dart';

/// Widget do formulário de cadastro e edição de usuário
///
/// Encapsula os campos de entrada e validações para criação e edição de usuários.
class UsuarioForm extends StatefulWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController nomeController;
  final TextEditingController emailController;
  final TextEditingController senhaController;
  final AuthorizationLevel nivelPermissaoSelecionado;
  final User? usuarioEditando;
  final VoidCallback onSubmit;
  final VoidCallback? onCancel;
  final ValueChanged<AuthorizationLevel> onPermissaoChanged;

  const UsuarioForm({
    required this.formKey,
    required this.nomeController,
    required this.emailController,
    required this.senhaController,
    required this.nivelPermissaoSelecionado,
    required this.usuarioEditando,
    required this.onSubmit,
    required this.onPermissaoChanged,
    super.key,
    this.onCancel,
  });

  @override
  State<UsuarioForm> createState() => _UsuarioFormState();
}

class _UsuarioFormState extends State<UsuarioForm> {
  bool _senhaVisivel = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            widget.usuarioEditando == null ? 'Novo Usuário' : 'Editar Usuário',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.nomeController,
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.name],
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
            controller: widget.emailController,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            autofillHints: const [AutofillHints.email],
            decoration: const InputDecoration(
              labelText: 'Email *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.email),
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email é obrigatório';
              }
              if (value.trim().isValidEmail() == false) {
                return 'Email inválido';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          TextFormField(
            controller: widget.senhaController,
            keyboardType: TextInputType.visiblePassword,
            textInputAction: TextInputAction.done,
            autofillHints: const [AutofillHints.newPassword],
            decoration: InputDecoration(
              labelText: widget.usuarioEditando == null
                  ? 'Senha *'
                  : 'Nova Senha (deixe vazio para manter)',
              border: const OutlineInputBorder(),
              prefixIcon: const Icon(Icons.lock),
              suffixIcon: IconButton(
                tooltip: _senhaVisivel ? 'Ocultar senha' : 'Mostrar senha',
                icon: Icon(
                  _senhaVisivel ? Icons.visibility_off : Icons.visibility,
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
            onFieldSubmitted: (_) => widget.onSubmit(),
            validator: (value) {
              // Se está editando e senha está vazia, não valida
              if (widget.usuarioEditando != null &&
                  (value == null || value.isEmpty)) {
                return null;
              }
              // Se está criando novo usuário, senha é obrigatória
              if (widget.usuarioEditando == null &&
                  (value == null || value.isEmpty)) {
                return 'Senha é obrigatória';
              }
              // Valida força da senha
              if (value != null &&
                  value.isNotEmpty &&
                  value.validatePassword() != null) {
                return value.validatePassword();
              }
              return null;
            },
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<AuthorizationLevel>(
            initialValue: widget.nivelPermissaoSelecionado,
            decoration: const InputDecoration(
              labelText: 'Nível de Permissão *',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.security),
            ),
            items: const [
              DropdownMenuItem(
                value: AuthorizationLevel.usuarioComum,
                child: Text('Usuário Comum'),
              ),
              DropdownMenuItem(
                value: AuthorizationLevel.administrador,
                child: Text('Administrador'),
              ),
            ],
            onChanged: (value) {
              if (value != null) {
                widget.onPermissaoChanged(value);
              }
            },
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  onPressed: widget.onSubmit,
                  icon: Icon(
                    widget.usuarioEditando == null ? Icons.add : Icons.save,
                  ),
                  label: Text(
                    widget.usuarioEditando == null
                        ? 'Adicionar Usuário'
                        : 'Salvar Alterações',
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.all(16),
                    textStyle: const TextStyle(fontSize: 16),
                  ),
                ),
              ),
              if (widget.usuarioEditando != null &&
                  widget.onCancel != null) ...[
                const SizedBox(width: 8),
                ElevatedButton.icon(
                  onPressed: widget.onCancel,
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
        ],
      ),
    );
  }
}
