import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sales_purchase_analytics_bloc.dart';
import '../bloc/sales_purchase_analytics_event.dart';

class EmptyStateView extends StatelessWidget {
  final SalesPurchaseGrouping grouping;

  const EmptyStateView({required this.grouping, super.key});

  @override
  Widget build(BuildContext context) {
    final groupingText = switch (grouping) {
      SalesPurchaseGrouping.byDate => 'por data',
      SalesPurchaseGrouping.byProduct => 'por produto',
    };

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.outline, size: 52),
            const SizedBox(height: 12),
            Text('Nenhum dado encontrado $groupingText.'),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: () =>
                  context.read<SalesPurchaseAnalyticsBloc>().add(const LoadSalesPurchaseAnalytics()),
              icon: const Icon(Icons.refresh),
              label: const Text('Recarregar'),
            ),
          ],
        ),
      ),
    );
  }
}

class ErrorStateView extends StatelessWidget {
  final String message;

  const ErrorStateView({required this.message, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Theme.of(context).colorScheme.error, size: 48),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () =>
                  context.read<SalesPurchaseAnalyticsBloc>().add(const LoadSalesPurchaseAnalytics()),
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );
  }
}
