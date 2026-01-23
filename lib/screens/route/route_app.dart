import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

@RoutePage()
class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.topRoute.title(context)),

        /// This will automatically display a back button if the nested router can pop
        leading: AutoLeadingButton(),
      ),
      body: const AutoRouter(),
    );
  }
}

@AutoRouterConfig(replaceInRouteName: 'View|Screen,Route')
class RouteApp extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HostRoute.page,
      initial: true,
      children: [
        AutoRoute(
          page: HomeRoute.page,
          title: (context, data) => 'Home',
          initial: true,
        ),
        AutoRoute(
          page: CustomerRoute.page,
          title: (context, data) => 'Customer Detail',
        ),
        AutoRoute(
          page: ProductInfoRoute.page,
          title: (context, data) => 'Product Info',
        ),
        AutoRoute(page: SalesRoute.page, title: (context, data) => 'Sales'),
        AutoRoute(page: UsuarioRoute.page, title: (context, data) => 'Usuario'),
        AutoRoute(
          page: ConfiguracoesRoute.page,
          title: (context, data) => 'Configuracoes',
        ),
        AutoRoute(page: CustomerDetailRoute.page),
      ],
    ),
  ];
}
