import 'package:auto_route/auto_route.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen,Route')
class RouteApp extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HostRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, title: (context, data) => 'Home'),
        AutoRoute(
          page: CadastroGroupRoute.page,
          title: (context, data) => 'Cadastro',
          maintainState: false,
          children: [
            AutoRoute(
              page: PersonRegistrationRoute.page,
              title: (context, data) => 'Cadastro de Pessoa',
              initial: true,
              maintainState: false,
            ),

            AutoRoute(
              page: ProductInfoRoute.page,
              title: (context, data) => 'Cadastro de Produto',
              maintainState: false,
            ),
          ],
        ),
        AutoRoute(page: SalesRoute.page, title: (context, data) => 'Vendas', maintainState: false),
        AutoRoute(page: RelatoriosRoute.page, title: (context, data) => 'Relatórios', maintainState: false),
        AutoRoute(page: SettingsRoute.page, title: (context, data) => 'Configurações', maintainState: false),
      ],
    ),

    AutoRoute(page: SalesInvoiceRoute.page, title: (context, data) => 'Sales Invoice'),
    AutoRoute(page: ProductDetailRoute.page, title: (context, data) => 'Product Detail'),
    AutoRoute(page: CategoryManagementRoute.page, title: (context, data) => 'Category Management'),
    AutoRoute(page: LogSystemRoute.page, title: (context, data) => 'System Logs'),
    AutoRoute(page: LogsAnalyticsRoute.page, title: (context, data) => 'Logs Analytics'),
    AutoRoute(page: CompanyEditRoute.page, title: (context, data) => 'Edit Company'),

    AutoRoute(page: SystemConfigRoute.page, title: (context, data) => 'System Config'),
    AutoRoute(page: UsuarioRoute.page, title: (context, data) => 'Usuários', maintainState: false),
  ];
}
