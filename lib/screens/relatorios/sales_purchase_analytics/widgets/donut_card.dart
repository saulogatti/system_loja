import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

class SalesPurchaseDonutCard extends StatelessWidget {
  final double totalSales;
  final double totalPurchases;

  const SalesPurchaseDonutCard({
    required this.totalSales,
    required this.totalPurchases,
    super.key,
  });

  Future<void> _openZoom(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (context) => _DonutZoomDialog(
        totalSales: totalSales,
        totalPurchases: totalPurchases,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final total = totalSales + totalPurchases;
    final salesPct = total <= 0 ? 0.0 : totalSales / total;
    final purchasesPct = total <= 0 ? 0.0 : totalPurchases / total;

    return Card(
      clipBehavior: Clip.antiAlias,
      child: Semantics(
        hint: 'Ampliar gráfico de distribuição',
        child: Tooltip(
          message: 'Ampliar gráfico de distribuição',
          excludeFromSemantics: true,
          child: InkWell(
            onTap: () => _openZoom(context),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.donut_large,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 8),
                      const Expanded(
                        child: Text(
                          'Distribuição: Vendas x Compras',
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                      ),
                      Icon(
                        Icons.zoom_in,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
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
                            trackColor: Theme.of(
                              context,
                            ).colorScheme.outlineVariant,
                          ),
                          child: Center(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'R\$ ${total.toStringAsFixed(2)}',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                const SizedBox(height: 2),
                                Text(
                                  'Total',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.onSurfaceVariant,
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
                    const EmptyWidget(
                      message: 'Sem valores para exibir no gráfico.',
                      icon: Icons.pie_chart_outline,
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _DonutZoomDialog extends StatelessWidget {
  final double totalSales;
  final double totalPurchases;

  const _DonutZoomDialog({
    required this.totalSales,
    required this.totalPurchases,
  });

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
                      child: Text(
                        'Distribuição: Vendas x Compras',
                        style: TextStyle(fontWeight: FontWeight.w800),
                      ),
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
                        trackColor: Theme.of(
                          context,
                        ).colorScheme.outlineVariant,
                      ),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              'R\$ ${total.toStringAsFixed(2)}',
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(
                                  context,
                                ).colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12),
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
                if (total <= 0) ...[
                  const SizedBox(height: 12),
                  const EmptyWidget(
                    message: 'Sem valores para exibir no gráfico.',
                    icon: Icons.pie_chart_outline,
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
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(3),
          ),
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
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                  fontSize: 12,
                ),
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
    final sweepPurchases =
        (purchasesFraction / total).clamp(0.0, 1.0) * math.pi * 2;

    final arcRect = Rect.fromCircle(
      center: center,
      radius: radius - stroke / 2,
    );
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
      canvas.drawArc(
        arcRect,
        startAngle + sweepSales,
        sweepPurchases,
        false,
        purchasesPaint,
      );
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
