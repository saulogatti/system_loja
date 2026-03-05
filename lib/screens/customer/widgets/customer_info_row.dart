import 'package:flutter/material.dart';

/// Linha reutilizável para exibir um rótulo, ícone e valor de informação do cliente.
///
/// Este widget é utilizado para apresentar informações do cliente de forma padronizada,
/// exibindo um ícone, um rótulo descritivo e o valor correspondente.
class CustomerInfoRow extends StatelessWidget {
  final String label;
  final IconData icon;
  final String value;
  const CustomerInfoRow({
    required this.label, required this.icon, required this.value, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey[600]),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
