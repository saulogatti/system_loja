import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/sales_purchase_analytics_bloc.dart';
import '../bloc/sales_purchase_analytics_state.dart';
import 'loaded_body.dart';
import 'states.dart';

class SalesPurchaseAnalyticsView extends StatelessWidget {
  const SalesPurchaseAnalyticsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gráficos de Vendas e Compras')),
      body:
          BlocBuilder<SalesPurchaseAnalyticsBloc, SalesPurchaseAnalyticsState>(
            builder: (context, state) {
              return switch (state) {
                SalesPurchaseAnalyticsInitial() ||
                SalesPurchaseAnalyticsLoading() => const Center(
                  child: CircularProgressIndicator(),
                ),
                SalesPurchaseAnalyticsError(:final message) => ErrorStateView(
                  message: message,
                ),
                SalesPurchaseAnalyticsEmpty(:final grouping) => EmptyStateView(
                  grouping: grouping,
                ),
                SalesPurchaseAnalyticsLoaded() => LoadedBody(state: state),
              };
            },
          ),
    );
  }
}
