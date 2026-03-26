import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/person_registration/person_list_screen.dart';
import 'package:system_loja/screens/products/product_list_screen.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Tela do grupo Cadastro.
///
/// Esta tela é um contêiner para as abas de listagem de pessoa e produto.
/// Ela utiliza AutoTabsRouter para gerenciar as abas e exibir o conteúdo correspondente a cada uma.
/// A navegação entre as abas é feita através de uma TabBar no topo da tela.
/// Os cadastros são abertos via FloatingActionButton em tela separada.
@RoutePage()
class CadastroGroupScreen extends StatefulWidget {
  const CadastroGroupScreen({super.key});

  @override
  State<CadastroGroupScreen> createState() => _CadastroGroupScreenState();
}

class _CadastroGroupScreenState extends State<CadastroGroupScreen> {
  @override
  Widget build(BuildContext context) {
    return AutoTabsRouter(
      routes: [PersonListRoute(), ProductListRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        final isPersonTab = tabsRouter.activeIndex == 0;

        return DefaultTabController(
          length: 2,
          initialIndex: tabsRouter.activeIndex,
          child: Scaffold(
            appBar: TabBar(
              onTap: tabsRouter.setActiveIndex,
              tabs: const [
                Tab(icon: Icon(Icons.people), text: 'Pessoas'),
                Tab(icon: Icon(Icons.inventory), text: 'Produtos'),
              ],
            ),
            body: child,
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () => _handleFabAction(isPersonTab: isPersonTab),
              icon: Icon(isPersonTab ? Icons.person_add : Icons.add_box),
              label: Text(isPersonTab ? 'Cadastrar Pessoa' : 'Cadastrar Produto'),
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleFabAction({required bool isPersonTab}) async {
    final rootRouter = context.router.root;
    final result = isPersonTab
        ? await rootRouter.push<bool>(const PersonRegistrationRoute())
        : await rootRouter.push<bool>(const ProductInfoRoute());

    if (result != true || !mounted) {
      return;
    }

    if (isPersonTab) {
      PersonListScreen.requestReload();
    } else {
      ProductListScreen.requestReload();
    }
  }
}
