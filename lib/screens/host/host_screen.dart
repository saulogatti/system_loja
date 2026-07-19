import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

@RoutePage()
class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) => AutoTabsScaffold(
      appBarBuilder: (context, tabsRouter) => AppBar(
          title: Text(tabsRouter.topRoute.title(context)),
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          leading: const AutoLeadingButton(),
        ),
      routes: [
        const SalesPurchaseAnalyticsRoute(),
        const CadastroGroupRoute(),
        const SalesRoute(),
        RelatoriosRoute(),
        const SettingsRoute(),
      ],
      transitionBuilder: (context, child, animation) => FadeTransition(opacity: animation, child: child),

      bottomNavigationBuilder: (context, tabsRouter) => BottomNavigationBar(
          backgroundColor: Theme.of(context).colorScheme.primaryContainer,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          elevation: 4,
          useLegacyColorScheme: false,
          currentIndex: tabsRouter.activeIndex,
          onTap: (index) {
            tabsRouter.setActiveIndex(index);
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_add),
              label: 'Cadastro',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart),
              label: 'Vendas',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart),
              label: 'Relatórios',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Configurações',
            ),
          ],
        ),
    );
}
