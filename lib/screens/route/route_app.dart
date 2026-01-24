import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

@RoutePage()
class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) {
        return AppBar(
          title: Text(tabsRouter.topRoute.title(context)),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: AutoLeadingButton(),
        );
      },
      routes: const [
        HomeRoute(),
        CustomerRoute(),
        ProductInfoRoute(),
        SalesRoute(),
        UsuarioRoute(),
        SettingsRoute(),
      ],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },

      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          // selectedItemColor: Colors.white,
          elevation: 4,
          useLegacyColorScheme: false,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Customer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Product Info',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Sales',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle),
              label: 'Usuario',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Settings',
            ),
          ],
        );
      },
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
        AutoRoute(page: HomeRoute.page, title: (context, data) => 'Home'),
        AutoRoute(
          page: CustomerRoute.page,
          title: (context, data) => 'Customer',
        ),
        AutoRoute(
          page: ProductInfoRoute.page,
          title: (context, data) => 'Product Info',
        ),
        AutoRoute(page: SalesRoute.page, title: (context, data) => 'Sales'),

        AutoRoute(page: UsuarioRoute.page, title: (context, data) => 'Usuario'),
        AutoRoute(
          page: SettingsRoute.page,
          title: (context, data) => 'Settings',
        ),
      ],
    ),
    AutoRoute(
      page: SalesInvoiceRoute.page,
      title: (context, data) => 'Sales Invoice',
    ),
    AutoRoute(
      page: CustomerDetailRoute.page,
      title: (context, data) => 'Customer Detail',
    ),
    AutoRoute(
      page: ProductDetailRoute.page,
      title: (context, data) => 'Product Detail',
    ),
  ];
}
