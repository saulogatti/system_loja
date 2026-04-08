import 'package:flutter/material.dart';
import 'package:system_loja/core/models/user.dart';
import 'package:system_loja/screens/configuracoes/widgets/usuario_list_item.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Widget da lista de usuários cadastrados
///
/// Exibe os usuários em formato de lista com cards ou mensagem quando vazio.
class UsuarioList extends StatelessWidget {
  final List<User> usuarios;
  final Function(User) onEdit;
  final Function(User) onDelete;
  final Function(User) onTap;

  const UsuarioList({
    required this.usuarios,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Usuários Cadastrados',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        if (usuarios.isEmpty)
          const EmptyWidget(message: 'Nenhum usuário cadastrado')
        else
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: usuarios.length,
            itemBuilder: (context, index) {
              final usuario = usuarios[index];
              return UsuarioListItem(
                usuario: usuario,
                onEdit: () => onEdit(usuario),
                onDelete: () => onDelete(usuario),
                onTap: () => onTap(usuario),
              );
            },
          ),
      ],
    );
  }
}
