import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sales_purchase_analytics_bloc.dart';
import '../bloc/sales_purchase_analytics_event.dart';

class GroupingSegmentedControl extends StatelessWidget {
  final SalesPurchaseGrouping current;

  const GroupingSegmentedControl({required this.current, super.key});

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
        context.read<SalesPurchaseAnalyticsBloc>().add(
          ChangeSalesPurchaseGrouping(selected),
        );
      },
    );
  }
}
