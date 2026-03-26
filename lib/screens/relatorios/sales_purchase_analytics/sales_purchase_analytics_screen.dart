import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';

import 'bloc/sales_purchase_analytics_bloc.dart';
import 'bloc/sales_purchase_analytics_event.dart';
import 'bloc/sales_purchase_analytics_state.dart';

/// Tela de analytics com comparativo de vendas e compras.
@RoutePage()
class SalesPurchaseAnalyticsScreen extends StatelessWidget {
  const SalesPurchaseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => SalesPurchaseAnalyticsBloc(
        analyticsRepository: appInjection.get<IAnalyticsRepository>(),
      )..add(const LoadSalesPurchaseAnalytics()),
      child: const _SalesPurchaseAnalyticsView(),
    );
  }
}

class _BarLine extends StatelessWidget {
  final double value;
  final double factor;
  final Color color;

  const _BarLine({required this.value, required this.factor, required this.color});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: LinearProgressIndicator(
              minHeight: 14,
              value: factor.clamp(0, 1),
              backgroundColor: color.withValues(alpha: 0.15),
              valueColor: AlwaysStoppedAnimation<Color>(color),
            ),
          ),
        ),
        const SizedBox(width: 10),
        SizedBox(
          width: 90,
          child: Text(
            'R\$ ${value.toStringAsFixed(2)}',
            textAlign: TextAlign.right,
            style: TextStyle(fontWeight: FontWeight.w600, color: color),
          ),
        ),
      ],
    );
  }
}

class _ChartLegend extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        _LegendItem(color: Colors.green, label: 'Venda'),
        SizedBox(width: 16),
        _LegendItem(color: Colors.orange, label: 'Compra'),
      ],
    );
  }
}

class _ComparisonBarTile extends StatelessWidget {
  final AnalyticsPoint point;
  final double maxValue;

  const _ComparisonBarTile({required this.point, required this.maxValue});

  @override
  Widget build(BuildContext context) {
    final safeMax = maxValue <= 0 ? 1.0 : maxValue;
    final salesFactor = point.salesValue / safeMax;
    final purchaseFactor = point.purchaseValue / safeMax;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(point.label, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            _BarLine(value: point.salesValue, factor: salesFactor, color: Colors.green),
            const SizedBox(height: 6),
            _BarLine(value: point.purchaseValue, factor: purchaseFactor, color: Colors.orange),
            const SizedBox(height: 8),
            Text(
              'Produtos movimentados: ${point.productsCount}',
              style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  final SalesPurchaseGrouping grouping;

  const _EmptyState({required this.grouping});

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

class _ErrorState extends StatelessWidget {
  final String message;

  const _ErrorState({required this.message});

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

class _GroupingSegmentedControl extends StatelessWidget {
  final SalesPurchaseGrouping current;

  const _GroupingSegmentedControl({required this.current});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<SalesPurchaseGrouping>(
      segments: const [
        ButtonSegment(
          value: SalesPurchaseGrouping.byDate,
          label: Text('Por Data'),
          icon: Icon(Icons.calendar_today),
        ),
        ButtonSegment(
          value: SalesPurchaseGrouping.byProduct,
          label: Text('Por Produto'),
          icon: Icon(Icons.inventory_2),
        ),
      ],
      selected: {current},
      onSelectionChanged: (selection) {
        final selected = selection.first;
        context.read<SalesPurchaseAnalyticsBloc>().add(ChangeSalesPurchaseGrouping(selected));
      },
    );
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 14,
          height: 14,
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 6),
        Text(label),
      ],
    );
  }
}

class _LoadedState extends StatelessWidget {
  final SalesPurchaseAnalyticsLoaded state;

  const _LoadedState({required this.state});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<SalesPurchaseAnalyticsBloc>().add(ChangeSalesPurchaseGrouping(state.grouping));
      },
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _GroupingSegmentedControl(current: state.grouping),
          const SizedBox(height: 16),
          _SummaryCards(state: state),
          const SizedBox(height: 20),
          _ChartLegend(),
          const SizedBox(height: 12),
          ...state.points.map((point) => _ComparisonBarTile(point: point, maxValue: state.maxValue)),
        ],
      ),
    );
  }
}

class _SalesPurchaseAnalyticsView extends StatelessWidget {
  const _SalesPurchaseAnalyticsView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gráficos de Vendas e Compras')),
      body: BlocBuilder<SalesPurchaseAnalyticsBloc, SalesPurchaseAnalyticsState>(
        builder: (context, state) {
          return switch (state) {
            SalesPurchaseAnalyticsInitial() ||
            SalesPurchaseAnalyticsLoading() => const Center(child: CircularProgressIndicator()),
            SalesPurchaseAnalyticsError(:final message) => _ErrorState(message: message),
            SalesPurchaseAnalyticsEmpty(:final grouping) => _EmptyState(grouping: grouping),
            SalesPurchaseAnalyticsLoaded() => _LoadedState(state: state),
          };
        },
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final double value;
  final Color color;
  final IconData icon;
  final String suffix;

  const _SummaryCard({
    required this.title,
    required this.value,
    required this.color,
    required this.icon,
    required this.suffix,
  });

  @override
  Widget build(BuildContext context) {
    final textValue = suffix.isNotEmpty ? '$suffix ${value.toStringAsFixed(2)}' : value.toStringAsFixed(0);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color),
            const SizedBox(height: 8),
            Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height: 4),
            Text(
              textValue,
              style: TextStyle(fontWeight: FontWeight.bold, color: color),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  final SalesPurchaseAnalyticsLoaded state;

  const _SummaryCards({required this.state});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: _SummaryCard(
            title: 'Vendas',
            value: state.totalSales,
            color: Colors.green,
            icon: Icons.trending_up,
            suffix: 'R\$',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Compras',
            value: state.totalPurchases,
            color: Colors.orange,
            icon: Icons.shopping_cart,
            suffix: 'R\$',
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _SummaryCard(
            title: 'Produtos',
            value: state.totalProducts.toDouble(),
            color: Theme.of(context).colorScheme.primary,
            icon: Icons.inventory,
            suffix: '',
          ),
        ),
      ],
    );
  }
}
