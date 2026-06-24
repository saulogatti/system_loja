import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:system_loja/core/models/default/authorization_level.dart';
import 'package:system_loja/core/models/extensions/nivel_permissao_extension.dart';
import 'package:system_loja/core/models/user.dart';

/// Widget do dialog de detalhes do usuário
///
/// Exibe todas as informações do usuário em um dialog modal.
class UsuarioDetailsDialog extends StatelessWidget {
  final User usuario;

  const UsuarioDetailsDialog({required this.usuario, super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
      actions: [TextButton(onPressed: () => Navigator.pop(context), child: const Text('Fechar'))],
    );
  }

  Widget _buildDetailRow(BuildContext context, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
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
  }

  /// Mostra o dialog de detalhes do usuário
  static void show(BuildContext context, User usuario) {
    showDialog(
      context: context,
      builder: (context) => UsuarioDetailsDialog(usuario: usuario),
    );
  }
}
