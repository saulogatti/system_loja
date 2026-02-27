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
              page: CustomerRoute.page,
              title: (context, data) => 'Cadastro de Cliente',
              maintainState: false,
              initial: true,
            ),
            AutoRoute(
              page: CompanyRoute.page,
              title: (context, data) => 'Cadastro de Empresa',
              maintainState: false,
            ),
            AutoRoute(
              page: ProductInfoRoute.page,
              title: (context, data) => 'Cadastro de Produto',
              maintainState: false,
            ),
          ],
        ),
        AutoRoute(page: SalesRoute.page, title: (context, data) => 'Vendas'),
        AutoRoute(page: UsuarioRoute.page, title: (context, data) => 'Usuários', maintainState: false),
        AutoRoute(page: SettingsRoute.page, title: (context, data) => 'Configurações'),
      ],
    ),
    AutoRoute(page: CustomerRoute.page, title: (context, data) => 'Cadastro de Cliente'),
    AutoRoute(page: CompanyRoute.page, title: (context, data) => 'Cadastro de Empresa'),
    AutoRoute(page: ProductInfoRoute.page, title: (context, data) => 'Cadastro de Produto'),
    AutoRoute(page: SalesInvoiceRoute.page, title: (context, data) => 'Sales Invoice'),
    AutoRoute(page: ProductDetailRoute.page, title: (context, data) => 'Product Detail'),
    AutoRoute(page: CategoryManagementRoute.page, title: (context, data) => 'Category Management'),
    AutoRoute(page: LogSystemRoute.page, title: (context, data) => 'System Logs'),
    AutoRoute(page: LogsAnalyticsRoute.page, title: (context, data) => 'Logs Analytics'),
    AutoRoute(page: CompanyEditRoute.page, title: (context, data) => 'Edit Company'),
    AutoRoute(page: PersonRegistrationRoute.page, title: (context, data) => 'Cadastro de Pessoa'),
    AutoRoute(page: SystemConfigRoute.page, title: (context, data) => 'System Config'),
  ];
}
