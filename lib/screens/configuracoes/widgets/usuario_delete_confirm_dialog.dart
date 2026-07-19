import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/user.dart';

/// Widget do dialog de confirmação de exclusão de usuário
///
/// Exibe um dialog de confirmação antes de excluir um usuário.
class UsuarioDeleteConfirmDialog extends StatelessWidget {

  const UsuarioDeleteConfirmDialog({required this.usuario, required this.onConfirm, super.key});
  final User usuario;
  final VoidCallback onConfirm;

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: const Text('Confirmar Exclusão'),
      content: Text('Deseja realmente excluir o usuário "${usuario.name}"?'),
      actions: [
        SizedBox(
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => context.router.maybePop(),
                  child: const Text('Cancelar'),
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                    onConfirm();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.error,
                    foregroundColor: Theme.of(context).colorScheme.onError,
                  ),
                  child: const Text('Excluir'),
                ),
              ),
            ],
          ),
        ),
      ],
    );

  /// Mostra o dialog de confirmação de exclusão
  static void show(BuildContext context, User usuario, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (context) => UsuarioDeleteConfirmDialog(usuario: usuario, onConfirm: onConfirm),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('usuario', usuario));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onConfirm', onConfirm));
  }
}
