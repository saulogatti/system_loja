import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lumen_kit/lumen_kit.dart';
import 'package:material_ui/material_ui.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_state.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/widgets/loaded_body.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/widgets/states.dart';

class SalesPurchaseAnalyticsView extends StatelessWidget {
  const SalesPurchaseAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocBuilder<SalesPurchaseAnalyticsBloc, SalesPurchaseAnalyticsState>(
      builder: (context, state) => switch (state) {
        SalesPurchaseAnalyticsInitial() ||
        SalesPurchaseAnalyticsLoading() => const Center(child: LumenCircularProgress()),
        SalesPurchaseAnalyticsError(:final message) => LumenBanner(message: message),
        SalesPurchaseAnalyticsEmpty(:final grouping) => EmptyStateView(grouping: grouping),
        SalesPurchaseAnalyticsLoaded() => LoadedBody(state: state),
      },
    ),
  );
}
