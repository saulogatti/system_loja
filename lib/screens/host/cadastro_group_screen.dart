import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Tela do grupo Cadastro.
///
/// Esta tela é um contêiner para as abas de cadastro de Cliente, Empresa e Produto.
/// Ela utiliza AutoTabsRouter para gerenciar as abas e exibir o conteúdo correspondente a cada uma.
/// A navegação entre as abas é feita através de uma TabBar no topo da tela, e o conteúdo de cada aba é renderizado no corpo do Scaffold.
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
      routes: [PersonRegistrationRoute(), ProductInfoRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(tabsRouter.current.title(context)),
            // Aqui entra a mágica da TabBar no topo
            bottom: TabBar(
              controller: TabController(
                length: 2,
                vsync: Scaffold.of(context), // Ou use um Hook se preferir
                initialIndex: tabsRouter.activeIndex,
              ),
              onTap: tabsRouter.setActiveIndex,
              tabs: [
                Tab(icon: Icon(Icons.person), text: 'Pessoa'),

                Tab(icon: Icon(Icons.inventory), text: 'Produto '),
              ],
            ),
          ),
          body: child, // O conteúdo da aba ativa
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
