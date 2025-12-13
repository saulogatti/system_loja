import 'package:flutter/material.dart';
import 'package:system_loja/core/models/extensions/nivel_permissao_extension.dart';
import 'package:system_loja/core/models/usuario.dart';

/// Widget do dialog de detalhes do usuário
///
/// Exibe todas as informações do usuário em um dialog modal.
class UsuarioDetailsDialog extends StatelessWidget {
  final Usuario usuario;

  const UsuarioDetailsDialog({
    super.key,
    required this.usuario,
  });

  /// Mostra o dialog de detalhes do usuário
  static void show(BuildContext context, Usuario usuario) {
    showDialog(
      context: context,
      builder: (context) => UsuarioDetailsDialog(usuario: usuario),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
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
              usuario.nivelPermissao.toDisplayName(),
            ),
            _buildDetailRow(
              'Data de Cadastro',
              usuario.registrationDate.toString().split('.')[0],
            ),
            _buildDetailRow(
              'Última Atualização',
              usuario.lastUpdatedDate.toString().split('.')[0],
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
    );
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
}
