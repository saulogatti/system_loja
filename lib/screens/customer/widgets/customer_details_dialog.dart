import 'package:flutter/material.dart';
import 'package:system_loja/core/models/customer.dart';

/// Exibe um dialog com os detalhes completos do cliente
///
/// Mostra todas as informações do cliente formatadas em um dialog modal.
///
///
//TODO: Detalhes do cliente e buscar cliente podem ser a mesma tela, refatorar depois
void showCustomerDetailsDialog(BuildContext context, Customer customer) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(customer.name),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildDetailRow('ID', customer.id.toString()),
            _buildDetailRow('CPF', customer.cpf),
            _buildDetailRow('Email', customer.email),
            _buildDetailRow('Telefone', customer.phone),
            _buildDetailRow('Endereço', customer.address),
            _buildDetailRow(
              'Data de Cadastro',
              customer.registrationDate.toString().split('.')[0],
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
    ),
  );
}

/// Constrói uma linha de detalhe com label e valor
///
/// Exibe um label em negrito cinza e o valor abaixo.
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
