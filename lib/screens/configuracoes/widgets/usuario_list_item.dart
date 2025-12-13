import 'package:flutter/material.dart';
import 'package:system_loja/core/models/extensions/nivel_permissao_extension.dart';
import 'package:system_loja/core/models/usuario.dart';

/// Widget do item individual da lista de usuários
///
/// Exibe as informações do usuário em formato de card com ações de editar e excluir.
class UsuarioListItem extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const UsuarioListItem({
    super.key,
    required this.usuario,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 0,
        titleAlignment: ListTileTitleAlignment.center,
        leading: CircleAvatar(
          backgroundColor: usuario.nivelPermissao == NivelPermissao.administrador
              ? Colors.purple
              : Colors.blue,
          child: Icon(
            usuario.nivelPermissao == NivelPermissao.administrador
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
          '${usuario.email}\n${usuario.nivelPermissao.toDisplayName()}',
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
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: onDelete,
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
