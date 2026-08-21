import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_bloc.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_event.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/widgets/sales_purchase_analytics_view.dart';

/// Tela de analytics com comparativo de vendas e compras.
///
/// {@category apresentacao}
/// {@subCategory Relatórios}
@RoutePage()
class SalesPurchaseAnalyticsScreen extends StatelessWidget {
  const SalesPurchaseAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
      create: (_) => SalesPurchaseAnalyticsBloc(
        analyticsRepository: appInjection.get<IAnalyticsRepository>(),
      )..add(const LoadSalesPurchaseAnalytics()),
      child: const SalesPurchaseAnalyticsView(),
    );
}
