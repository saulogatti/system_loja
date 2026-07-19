import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_event.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

class EmptyStateView extends StatelessWidget {

  const EmptyStateView({required this.grouping, super.key});
  final SalesPurchaseGrouping grouping;

  @override
  Widget build(BuildContext context) {
    final groupingText = switch (grouping) {
      SalesPurchaseGrouping.byDate => 'por data',
      SalesPurchaseGrouping.byProduct => 'por produto',
    };

    return EmptyWidget(
      message: 'Nenhum dado encontrado $groupingText.',
      icon: Icons.bar_chart,
      action: OutlinedButton.icon(
        onPressed: () => context.read<SalesPurchaseAnalyticsBloc>().add(
          const LoadSalesPurchaseAnalytics(),
        ),
        icon: const Icon(Icons.refresh),
        label: const Text('Recarregar'),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<SalesPurchaseGrouping>('grouping', grouping));
  }
}

class ErrorStateView extends StatelessWidget {

  const ErrorStateView({required this.message, super.key});
  final String message;

  @override
  Widget build(BuildContext context) => Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
              size: 48,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => context.read<SalesPurchaseAnalyticsBloc>().add(
                const LoadSalesPurchaseAnalytics(),
              ),
              icon: const Icon(Icons.refresh),
              label: const Text('Tentar novamente'),
            ),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('message', message));
  }
}
