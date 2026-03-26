import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';

import 'bloc/sales_purchase_analytics_bloc.dart';
import 'bloc/sales_purchase_analytics_event.dart';
import 'widgets/sales_purchase_analytics_view.dart';

/// Tela de analytics com comparativo de vendas e compras.
@RoutePage()
class SalesPurchaseAnalyticsScreen extends StatelessWidget {
  const SalesPurchaseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          SalesPurchaseAnalyticsBloc(analyticsRepository: appInjection.get<IAnalyticsRepository>())
            ..add(const LoadSalesPurchaseAnalytics()),
      child: const SalesPurchaseAnalyticsView(),
    );
  }
}
