import 'package:flutter/material.dart';

/// Widget que exibe botões de ação para cancelar ou salvar alterações do cliente.
class CustomerActionButtons extends StatelessWidget {
  final VoidCallback onCancel;
  final VoidCallback onSave;

  const CustomerActionButtons({
    super.key,
    required this.onCancel,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onCancel,
            child: const Text('Cancelar'),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: ElevatedButton(
            onPressed: onSave,
            child: const Text('Salvar Alterações'),
          ),
        ),
      ],
    );
  }
}
