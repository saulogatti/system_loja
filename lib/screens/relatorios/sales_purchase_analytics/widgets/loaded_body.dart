import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sales_purchase_analytics_bloc.dart';
import '../bloc/sales_purchase_analytics_event.dart';
import '../bloc/sales_purchase_analytics_state.dart';
import 'chart_legend.dart';
import 'comparison_bar_tile.dart';
import 'donut_card.dart';
import 'grid_sort_segmented_control.dart';
import 'grouping_segmented_control.dart';
import 'products_count_chart_card.dart';
import 'summary_cards.dart';

class LoadedBody extends StatefulWidget {
  final SalesPurchaseAnalyticsLoaded state;

  const LoadedBody({required this.state, super.key});

  @override
  State<LoadedBody> createState() => _LoadedBodyState();
}

class _LoadedBodyState extends State<LoadedBody> {
  GridSortOrder _sortOrder = GridSortOrder.recentes;

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

    if (_sortOrder == GridSortOrder.recentes) {
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
            sliver: SliverToBoxAdapter(child: GroupingSegmentedControl(current: state.grouping)),
          ),
          const SliverToBoxAdapter(child: SizedBox(height: 16)),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: SummaryCards(state: state)),
                  const SizedBox(width: 12),
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxWidth: 260),
                    child: GridSortSegmentedControl(
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
                    SalesPurchaseDonutCard(totalSales: state.totalSales, totalPurchases: state.totalPurchases),
                    if (state.grouping == SalesPurchaseGrouping.byDate) ProductsCountChartCard(points: state.points),
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
          const SliverPadding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverToBoxAdapter(child: ChartLegend()),
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
                  return ComparisonBarTile(point: point, maxValue: state.maxValue);
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

