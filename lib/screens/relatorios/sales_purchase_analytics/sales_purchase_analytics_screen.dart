import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';
import 'dart:math' as math;

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

class _VerticalValueBar extends StatelessWidget {
  final String title;
  final double value;
  final double factor;
  final Color color;

  const _VerticalValueBar({
    required this.title,
    required this.value,
    required this.factor,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final safeFactor = factor.clamp(0.0, 1.0);
    final barColor = color.withValues(alpha: 0.9);

    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 12)),
        const SizedBox(height: 6),
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: 26,
              height: math.max(6.0, 140.0 * safeFactor),
              decoration: BoxDecoration(
                color: barColor,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'R\$ ${value.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.w700, color: color, fontSize: 12),
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
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
      margin: EdgeInsets.zero,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    point.label,
                    style: const TextStyle(fontWeight: FontWeight.w700),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.bar_chart, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 190,
              child: Row(
                children: [
                  Expanded(
                    child: _VerticalValueBar(
                      title: 'Venda',
                      value: point.salesValue,
                      factor: salesFactor,
                      color: Colors.green,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: _VerticalValueBar(
                      title: 'Compra',
                      value: point.purchaseValue,
                      factor: purchaseFactor,
                      color: Colors.orange,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
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

enum _GridSortOrder { recentes, antigos }

class _GridSortSegmentedControl extends StatelessWidget {
  final _GridSortOrder current;
  final ValueChanged<_GridSortOrder> onChanged;

  const _GridSortSegmentedControl({required this.current, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return SegmentedButton<_GridSortOrder>(
      segments: const [
        ButtonSegment(
          value: _GridSortOrder.recentes,
          label: Text('Recentes'),
          icon: Icon(Icons.schedule),
        ),
        ButtonSegment(
          value: _GridSortOrder.antigos,
          label: Text('Antigos'),
          icon: Icon(Icons.history),
        ),
      ],
      selected: {current},
      onSelectionChanged: (selection) => onChanged(selection.first),
    );
  }
}

class _LoadedState extends StatefulWidget {
  final SalesPurchaseAnalyticsLoaded state;

  const _LoadedState({required this.state});

  @override
  State<_LoadedState> createState() => _LoadedStateState();
}

class _LoadedStateState extends State<_LoadedState> {
  _GridSortOrder _sortOrder = _GridSortOrder.recentes;

  List<AnalyticsPoint> _sortedPoints() {
    final points = widget.state.points.toList();

    if (widget.state.grouping == SalesPurchaseGrouping.byDate) {
      points.sort((a, b) {
        final ak = _dateSortKey(a.label);
        final bk = _dateSortKey(b.label);
        if (ak == null && bk == null) return 0;
        if (ak == null) return 1;
        if (bk == null) return -1;
        return ak.compareTo(bk);
      });
    } else {
      points.sort((a, b) => a.label.toLowerCase().compareTo(b.label.toLowerCase()));
    }

    if (_sortOrder == _GridSortOrder.recentes) {
      return points.reversed.toList();
    }
    return points;
  }

  int? _dateSortKey(String label) {
    // Esperado: DD/MM. Fallback: null (vai pro fim sem crash).
    final parts = label.split('/');
    if (parts.length != 2) return null;
    final dd = int.tryParse(parts[0]);
    final mm = int.tryParse(parts[1]);
    if (dd == null || mm == null) return null;
    if (dd < 1 || dd > 31 || mm < 1 || mm > 12) return null;
    return mm * 100 + dd;
  }

  @override
  Widget build(BuildContext context) {
    final state = widget.state;
    final sortedPoints = _sortedPoints();

    return RefreshIndicator(
      onRefresh: () async {
        context.read<SalesPurchaseAnalyticsBloc>().add(ChangeSalesPurchaseGrouping(state.grouping));
      },
      child: CustomScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        slivers: [
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: _GroupingSegmentedControl(current: state.grouping)),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: _SummaryCards(state: state)),
                  const SizedBox(width: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: _GridSortSegmentedControl(
                      current: _sortOrder,
                      onChanged: (value) => setState(() => _sortOrder = value),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isWide = constraints.maxWidth >= 760;
                  final tiles = <Widget>[
                    _SalesPurchaseDonutCard(
                      totalSales: state.totalSales,
                      totalPurchases: state.totalPurchases,
                    ),
                    if (state.grouping == SalesPurchaseGrouping.byDate)
                      _ProductsCountChartCard(points: state.points),
                  ];

                  if (tiles.isEmpty) {
                    return const SizedBox.shrink();
                  }

                  if (isWide && tiles.length == 2) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(child: tiles[0]),
                        const SizedBox(width: 12),
                        Expanded(child: tiles[1]),
                      ],
                    );
                  }

                  return Column(
                    children: [
                      for (final tile in tiles) ...[tile, const SizedBox(height: 12)],
                    ],
                  );
                },
              ),
            ),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 8)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: _ChartLegend()),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 420,
                mainAxisExtent: 290,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final point = sortedPoints[index];
                  return _ComparisonBarTile(point: point, maxValue: state.maxValue);
                },
                childCount: sortedPoints.length,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SalesPurchaseDonutCard extends StatelessWidget {
  final double totalSales;
  final double totalPurchases;

  const _SalesPurchaseDonutCard({required this.totalSales, required this.totalPurchases});

  Future<void> _openZoom(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _DonutZoomDialog(totalSales: totalSales, totalPurchases: totalPurchases),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = totalSales + totalPurchases;
    final salesPct = total <= 0 ? 0.0 : totalSales / total;
    final purchasesPct = total <= 0 ? 0.0 : totalPurchases / total;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => _openZoom(context),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(Icons.donut_large, color: Theme.of(context).colorScheme.primary),
                  const SizedBox(width: 8),
                  const Expanded(
                    child: Text('Distribuição: Vendas x Compras', style: TextStyle(fontWeight: FontWeight.w700)),
                  ),
                  Icon(Icons.zoom_in, color: Theme.of(context).colorScheme.onSurfaceVariant),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  SizedBox(
                    width: 140,
                    height: 140,
                    child: CustomPaint(
                      painter: _DonutPainter(
                        salesFraction: salesPct,
                        purchasesFraction: purchasesPct,
                        salesColor: Colors.green,
                        purchasesColor: Colors.orange,
                        trackColor: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'R\$ ${total.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      children: [
                        _DonutLegendLine(
                          color: Colors.green,
                          title: 'Vendas',
                          value: totalSales,
                          percent: salesPct,
                        ),
                        const SizedBox(height: 10),
                        _DonutLegendLine(
                          color: Colors.orange,
                          title: 'Compras',
                          value: totalPurchases,
                          percent: purchasesPct,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              if (total <= 0) ...[
                const SizedBox(height: 10),
                Text(
                  'Sem valores para exibir no gráfico.',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _DonutZoomDialog extends StatelessWidget {
  final double totalSales;
  final double totalPurchases;

  const _DonutZoomDialog({required this.totalSales, required this.totalPurchases});

  @override
  Widget build(BuildContext context) {
    final total = totalSales + totalPurchases;
    final salesPct = total <= 0 ? 0.0 : totalSales / total;
    final purchasesPct = total <= 0 ? 0.0 : totalPurchases / total;

    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.94, end: 1.0),
      duration: const Duration(milliseconds: 180),
      curve: Curves.easeOutCubic,
      builder: (context, scale, child) {
        return Transform.scale(
          scale: scale,
          child: AnimatedOpacity(
            opacity: scale,
            duration: const Duration(milliseconds: 180),
            curve: Curves.easeOut,
            child: child,
          ),
        );
      },
      child: Dialog(
        insetPadding: const EdgeInsets.all(16),
        clipBehavior: Clip.antiAlias,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    const Expanded(
                      child: Text('Distribuição: Vendas x Compras', style: TextStyle(fontWeight: FontWeight.w800)),
                    ),
                    IconButton(
                      onPressed: () => Navigator.of(context).pop(),
                      icon: const Icon(Icons.close),
                      tooltip: 'Fechar',
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Center(
                  child: SizedBox(
                    width: 320,
                    height: 320,
                    child: CustomPaint(
                      painter: _DonutPainter(
                        salesFraction: salesPct,
                        purchasesFraction: purchasesPct,
                        salesColor: Colors.green,
                        purchasesColor: Colors.orange,
                        trackColor: Theme.of(context).colorScheme.outlineVariant,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'R\$ ${total.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.w900, fontSize: 18),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                _DonutLegendLine(color: Colors.green, title: 'Vendas', value: totalSales, percent: salesPct),
                const SizedBox(height: 10),
                _DonutLegendLine(
                  color: Colors.orange,
                  title: 'Compras',
                  value: totalPurchases,
                  percent: purchasesPct,
                ),
                if (total <= 0) ...[
                  const SizedBox(height: 12),
                  Text(
                    'Sem valores para exibir no gráfico.',
                    style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DonutLegendLine extends StatelessWidget {
  final Color color;
  final String title;
  final double value;
  final double percent;

  const _DonutLegendLine({
    required this.color,
    required this.title,
    required this.value,
    required this.percent,
  });

  @override
  Widget build(BuildContext context) {
    final pctText = (percent * 100).clamp(0, 100).toStringAsFixed(0);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          margin: const EdgeInsets.only(top: 4),
          decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(3)),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
              const SizedBox(height: 2),
              Text(
                'R\$ ${value.toStringAsFixed(2)} • $pctText%',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontSize: 12),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _DonutPainter extends CustomPainter {
  final double salesFraction;
  final double purchasesFraction;
  final Color salesColor;
  final Color purchasesColor;
  final Color trackColor;

  const _DonutPainter({
    required this.salesFraction,
    required this.purchasesFraction,
    required this.salesColor,
    required this.purchasesColor,
    required this.trackColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final center = rect.center;
    final radius = math.min(size.width, size.height) / 2;

    final stroke = math.max(10.0, radius * 0.18);
    final basePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = trackColor.withValues(alpha: 0.35);

    canvas.drawCircle(center, radius - stroke / 2, basePaint);

    final total = salesFraction + purchasesFraction;
    if (total <= 0) {
      return;
    }

    final startAngle = -math.pi / 2;
    final sweepSales = (salesFraction / total).clamp(0.0, 1.0) * math.pi * 2;
    final sweepPurchases = (purchasesFraction / total).clamp(0.0, 1.0) * math.pi * 2;

    final arcRect = Rect.fromCircle(center: center, radius: radius - stroke / 2);
    final salesPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = salesColor;
    final purchasesPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke
      ..strokeCap = StrokeCap.round
      ..color = purchasesColor;

    if (sweepSales > 0) {
      canvas.drawArc(arcRect, startAngle, sweepSales, false, salesPaint);
    }

    if (sweepPurchases > 0) {
      canvas.drawArc(arcRect, startAngle + sweepSales, sweepPurchases, false, purchasesPaint);
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) {
    return oldDelegate.salesFraction != salesFraction ||
        oldDelegate.purchasesFraction != purchasesFraction ||
        oldDelegate.salesColor != salesColor ||
        oldDelegate.purchasesColor != purchasesColor ||
        oldDelegate.trackColor != trackColor;
  }
}

class _ProductsCountChartCard extends StatelessWidget {
  final List<AnalyticsPoint> points;

  const _ProductsCountChartCard({required this.points});

  @override
  Widget build(BuildContext context) {
    final maxCount = points.fold<int>(0, (m, p) => p.productsCount > m ? p.productsCount : m);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.stacked_bar_chart, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Expanded(
                  child: Text('Itens movimentados por data', style: TextStyle(fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (points.isEmpty || maxCount <= 0)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Sem dados para exibir.',
                  style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
              )
            else
              SizedBox(
                height: 170,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      for (final p in points)
                        _MiniBar(
                          label: p.label,
                          value: p.productsCount,
                          max: maxCount,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _MiniBar extends StatelessWidget {
  final String label;
  final int value;
  final int max;
  final Color color;

  const _MiniBar({required this.label, required this.value, required this.max, required this.color});

  @override
  Widget build(BuildContext context) {
    final factor = max <= 0 ? 0.0 : (value / max).clamp(0.0, 1.0);
    final barHeight = 110 * factor;
    final labelText = label.length > 6 ? '${label.substring(0, 6)}…' : label;

    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(
            '$value',
            style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 6),
          Container(
            width: 18,
            height: barHeight < 2 ? 2 : barHeight,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.85),
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: 34,
            child: Text(
              labelText,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
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
