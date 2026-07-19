import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_event.dart';

class GroupingSegmentedControl extends StatelessWidget {
  const GroupingSegmentedControl({required this.current, super.key});
  final SalesPurchaseGrouping current;

  @override
  Widget build(BuildContext context) => SegmentedButton<SalesPurchaseGrouping>(
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

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(EnumProperty<SalesPurchaseGrouping>('current', current));
  }
}
