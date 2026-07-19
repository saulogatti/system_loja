import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/extensions/nivel_permissao_extension.dart';
import 'package:system_loja/core/models/user.dart';

/// Widget do dialog de detalhes do usuário
///
/// Exibe todas as informações do usuário em um dialog modal.
class UsuarioDetailsDialog extends StatelessWidget {

  const UsuarioDetailsDialog({required this.usuario, super.key});
  final User usuario;

  @override
  Widget build(BuildContext context) => AlertDialog(
      title: Text(usuario.name),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow(context, 'ID', usuario.id.toString()),
            _buildDetailRow(context, 'Email', usuario.email ?? 'N/A'),
            _buildDetailRow(
              context,
              'Nível de Permissão',
              AuthorizationLevel.values
                  .firstWhere((level) => level.value == usuario.permission)
                  .toDisplayName(),
            ),
            _buildDetailRow(
              context,
              'Data de Cadastro',
              DateFormat('dd/MM/yyyy HH:mm:ss').format(usuario.registrationDate),
            ),
            _buildDetailRow(
              context,
              'Última Atualização',
              DateFormat('dd/MM/yyyy HH:mm:ss').format(usuario.lastUpdatedDate),
            ),
          ],
        ),
      ),
      actions: [TextButton(onPressed: () => context.router.maybePop(), child: const Text('Fechar'))],
    );

  Widget _buildDetailRow(BuildContext context, String label, String value) => Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.onSurfaceVariant,
              fontSize: 12,
            ),
          ),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );

  /// Mostra o dialog de detalhes do usuário
  static void show(BuildContext context, User usuario) {
    showDialog(
      context: context,
      builder: (context) => UsuarioDetailsDialog(usuario: usuario),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<User>('usuario', usuario));
  }
}
