import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/app_injection.dart';
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
      routes: [HomeRoute(), CadastroGroupRoute(), SalesRoute(), UsuarioRoute(), SettingsRoute()],
      transitionBuilder: (context, child, animation) {
        return FadeTransition(opacity: animation, child: child);
      },

      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
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
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.person_add), label: 'Cadastro'),
            BottomNavigationBarItem(icon: Icon(Icons.shopping_cart), label: 'Vendas'),
            BottomNavigationBarItem(icon: Icon(Icons.people), label: 'Usuários'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
          ],
        );
      },
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.router.push(const CadastroGroupRoute());
          printerLog.getAllLogs().then(print);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
