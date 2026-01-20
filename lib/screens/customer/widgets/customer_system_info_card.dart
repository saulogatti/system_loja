import 'package:flutter/material.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/screens/customer/widgets/customer_info_row.dart';

/// Exibe informações do sistema do cliente, como o ID e a data de cadastro.
class CustomerSystemInfoCard extends StatelessWidget {
  final Customer customer;
  final String Function(DateTime) formatDate;

  const CustomerSystemInfoCard({
    super.key,
    required this.customer,
    required this.formatDate,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Informações do Sistema',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            CustomerInfoRow(
              label: 'ID',
              icon: Icons.numbers,
              value: customer.id.toString(),
            ),
            const Divider(),
            CustomerInfoRow(
              label: 'Data de Cadastro',
              icon: Icons.calendar_today,
              value: formatDate(customer.registrationDate),
            ),
            const Divider(),
            CustomerInfoRow(
              label: 'Data de Atualização',
              icon: Icons.calendar_month_outlined,
              value: formatDate(customer.lastUpdatedDate),
            ),
          ],
        ),
      ),
    );
  }
}
