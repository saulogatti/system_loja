import 'package:flutter/material.dart';
import 'package:system_loja/core/models/usuario.dart';

/// Widget do dialog de confirmação de exclusão de usuário
///
/// Exibe um dialog de confirmação antes de excluir um usuário.
class UsuarioDeleteConfirmDialog extends StatelessWidget {
  final Usuario usuario;
  final VoidCallback onConfirm;

  const UsuarioDeleteConfirmDialog({
    super.key,
    required this.usuario,
    required this.onConfirm,
  });

  /// Mostra o dialog de confirmação de exclusão
  static void show(
    BuildContext context,
    Usuario usuario,
    VoidCallback onConfirm,
  ) {
    showDialog(
      context: context,
      builder: (context) => UsuarioDeleteConfirmDialog(
        usuario: usuario,
        onConfirm: onConfirm,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Confirmar Exclusão'),
      content: Text('Deseja realmente excluir o usuário "${usuario.nome}"?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context);
            onConfirm();
          },
          style: TextButton.styleFrom(foregroundColor: Colors.red),
          child: const Text('Excluir'),
        ),
      ],
    );
  }
}
