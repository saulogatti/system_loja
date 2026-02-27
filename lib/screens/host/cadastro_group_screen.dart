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
      routes: [CustomerRoute(), CompanyRoute(), ProductInfoRoute()],
      builder: (context, child) {
        final tabsRouter = AutoTabsRouter.of(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(tabsRouter.current.title(context)),
            // Aqui entra a mágica da TabBar no topo
            bottom: TabBar(
              controller: TabController(
                length: 3,
                vsync: Scaffold.of(context), // Ou use um Hook se preferir
                initialIndex: tabsRouter.activeIndex,
              ),
              onTap: tabsRouter.setActiveIndex,
              tabs: [
                Tab(icon: Icon(Icons.person), text: 'Cliente'),
                Tab(icon: Icon(Icons.business), text: 'Empresa'),
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

  // void _showCadastroBottomSheet() {
  //   if (!mounted || _sheetShown) return;
  //   _sheetShown = true;

  //   showModalBottomSheet<void>(
  //     context: context,
  //     useSafeArea: true,
  //     builder: (context) {
  //       return Material(
  //         color: Theme.of(context).colorScheme.surface,
  //         borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
  //         child: Padding(
  //           padding: const EdgeInsets.symmetric(vertical: 16),
  //           child: Column(
  //             mainAxisSize: MainAxisSize.min,
  //             children: [
  //               const Text(
  //                 'Selecione o cadastro',
  //                 style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
  //               ),
  //               const SizedBox(height: 16),
  //               ListTile(
  //                 leading: const Icon(Icons.person),
  //                 title: const Text('Cadastro de Cliente'),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   context.router.push(CustomerRoute());
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.business),
  //                 title: const Text('Cadastro de Empresa'),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   context.router.push(CompanyRoute());
  //                 },
  //               ),
  //               ListTile(
  //                 leading: const Icon(Icons.inventory),
  //                 title: const Text('Cadastro de Produto'),
  //                 onTap: () {
  //                   Navigator.pop(context);
  //                   context.router.push(ProductInfoRoute());
  //                 },
  //               ),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   ).whenComplete(() {
  //     _sheetShown = false;
  //   });
  // }
}
