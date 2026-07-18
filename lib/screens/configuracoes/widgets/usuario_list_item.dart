import 'package:flutter/material.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/extensions/nivel_permissao_extension.dart';
import 'package:system_loja/core/models/user.dart';

/// Widget do item individual da lista de usuários
///
/// Exibe as informações do usuário em formato de card com ações de editar e excluir.
class UsuarioListItem extends StatelessWidget {
  final User usuario;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onTap;

  const UsuarioListItem({
    required this.usuario,
    required this.onEdit,
    required this.onDelete,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final permissionName = AuthorizationLevel.values
        .firstWhere((level) => level.value == usuario.permission)
        .toDisplayName();
    final semanticLabel = usuario.email != null && usuario.email!.isNotEmpty
        ? '${usuario.name}, ${usuario.email}, $permissionName'
        : '${usuario.name}, $permissionName';

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: ListTile(
        minLeadingWidth: 0,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        minVerticalPadding: 0,
        titleAlignment: ListTileTitleAlignment.center,
        leading: ExcludeSemantics(
          child: CircleAvatar(
            backgroundColor: switch (usuario.permission) {
              _ when usuario.permission == AuthorizationLevel.administrador.value => Theme.of(
                context,
              ).colorScheme.secondary,
              _ => Theme.of(context).colorScheme.primary,
            },
            child: Icon(
              usuario.permission == AuthorizationLevel.administrador.value
                  ? Icons.admin_panel_settings
                  : Icons.person,
              color: Colors.white,
            ),
          ),
        ),
        title: Semantics(
          label: semanticLabel,
          child: Text(usuario.name, style: const TextStyle(fontWeight: FontWeight.bold)),
        ),
        subtitle: ExcludeSemantics(child: Text('${usuario.email ?? ''}\n$permissionName'.trim())),
        isThreeLine: true,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(Icons.edit, color: Theme.of(context).colorScheme.primary),
              onPressed: onEdit,
              tooltip: 'Editar ${usuario.name}',
            ),
            IconButton(
              icon: Icon(Icons.delete, color: Theme.of(context).colorScheme.error),
              onPressed: onDelete,
              tooltip: 'Excluir ${usuario.name}',
            ),
          ],
        ),
        onTap: onTap,
      ),
    );
  }
}
