import 'package:flutter/material.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

/// Exibe um bottom sheet com visão geral dos dados da nota fiscal.
///
/// Substitui o diálogo de detalhes, apresentando as informações da nota
/// num painel deslizante com lista de itens e dados de pagamento.
class InvoiceOverviewBottomSheet extends StatelessWidget {
  /// Nota fiscal cujas informações serão exibidas.
  final Invoice invoice;

  /// Cria uma instância de [InvoiceOverviewBottomSheet].
  const InvoiceOverviewBottomSheet({required this.invoice, super.key});

  /// Exibe o bottom sheet de visão geral da nota fiscal.
  static Future<void> show(BuildContext context, Invoice invoice) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => InvoiceOverviewBottomSheet(invoice: invoice),
    );
  }

  @override
  Widget build(BuildContext context) {
    final data = invoice.data;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.9,
      builder: (_, scrollController) {
        return Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.secondaryContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      Icons.receipt_long,
                      size: 28,
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'NF ${data.invoiceNumber}',
                          style: Theme.of(
                            context,
                          ).textTheme.titleLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          'ID: ${invoice.id}',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(
                            color:
                                Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const Divider(height: 32),
              Expanded(
                child: ListView(
                  controller: scrollController,
                  children: [
                    _InfoRow(
                      icon: Icons.person_outline,
                      label: 'Cliente',
                      value: data.customerName ?? '',
                    ),
                    _InfoRow(
                      icon: Icons.badge_outlined,
                      label: 'CPF',
                      value: data.customerCpf ?? '',
                    ),
                    _InfoRow(
                      icon: Icons.payment_outlined,
                      label: 'Forma de Pagamento',
                      value: data.paymentMethod,
                    ),
                    _InfoRow(
                      icon: Icons.calendar_today_outlined,
                      label: 'Data de Emissão',
                      value: data.issueDate.toFormattedDate(),
                    ),
                    _InfoRow(
                      icon: Icons.attach_money,
                      label: 'Valor Total',
                      value: 'R\$ ${data.totalValue.toStringAsFixed(2)}',
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Itens (${data.items.length})',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    ...data.items.map(
                      (item) => Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                '${item.quantity}× ${item.productName}',
                                style: Theme.of(context).textTheme.bodyMedium,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Text(
                              'R\$ ${item.totalValue.toStringAsFixed(2)}',
                              style: Theme.of(
                                context,
                              ).textTheme.bodyMedium?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Fechar'),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Linha de informação com ícone, rótulo e valor.
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelSmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                Text(value, style: Theme.of(context).textTheme.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
