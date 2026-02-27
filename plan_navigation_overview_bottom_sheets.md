# Plano de Navegação: Dashboard + Bottom Sheets

## Objetivo
Reestruturar a navegação do sistema migrando de `lib/screens/route/route_app.dart` para o padrão Clean Architecture em `lib/presentation/routes/`. A barra inferior terá 5 itens, introduzindo uma tela de Visão Geral (Dashboard) e utilizando *Bottom Sheets* como interceptadores de navegação.

## 1. Mapeamento da BottomNavigationBar (5 Ícones)
- **Índice 0 (Visão Geral):** Tela `OverviewRoute` (Dashboard inicial, gerenciada via BLoC).
- **Índice 1 (Cadastro):** Rota fantasma. Intercepta o clique -> Abre `CadastroBottomSheet`.
- **Índice 2 (Consultas):** Rota fantasma. Intercepta o clique -> Abre `ConsultasBottomSheet`.
- **Índice 3 (Nota Fiscal):** Aba real (`SalesRoute`).
- **Índice 4 (Configurações):** Aba real (Wrapper de configurações `ConfigWrapperRoute`).

## 2. Implementação da HostScreen Atualizada
O `AutoTabsScaffold` vai gerenciar a interceptação de cliques. As abas "reais" atualizam o índice, enquanto os gatilhos apenas sobem modais.

**Arquivo: `lib/presentation/routes/host_screen.dart`**
```dart
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/presentation/routes/app_router.gr.dart';
import 'package:system_loja/presentation/widgets/cadastro_bottom_sheet.dart';

@RoutePage()
class HostScreen extends StatelessWidget {
  const HostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      // Precisamos de 5 rotas aqui para bater com os 5 BottomNavigationBarItems
      routes: const [
        OverviewRoute(),       // 0: Visão Geral (Nova tela a ser criada)
        DummyCadastroRoute(),  // 1: Rota fantasma (nunca será renderizada)
        DummyConsultasRoute(), // 2: Rota fantasma (nunca será renderizada)
        SalesRoute(),          // 3: Nota Fiscal
        ConfigWrapperRoute(),  // 4: Configurações
      ],
      bottomNavigationBuilder: (context, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            if (index == 1) {
              // Intercepta e abre o Modal de Cadastros
              showModalBottomSheet(
                context: context,
                builder: (_) => const CadastroBottomSheet(),
              );
            } else if (index == 2) {
              // Intercepta e abre o Modal de Consultas
              showModalBottomSheet(
                context: context,
                builder: (_) => const ConsultasBottomSheet(),
              );
            } else {
              // Navegação normal para Visão Geral, Nota Fiscal ou Configurações
              tabsRouter.setActiveIndex(index);
            }
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.dashboard), label: 'Visão Geral'),
            BottomNavigationBarItem(icon: Icon(Icons.add_circle_outline), label: 'Cadastro'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Consultas'),
            BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Nota Fiscal'),
            BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Configurações'),
          ],
        );
      },
    );
  }
}
```

## 3. O Componente BottomSheet de Cadastro
Ele empilha as telas de cadastro em `FullScreen` (sobrepondo tudo). O gerenciador de estado (`CustomerBloc` e o futuro `ProductBloc`) entra em ação apenas nestas telas de destino.

**Arquivo: `lib/presentation/widgets/cadastro_bottom_sheet.dart`**
```dart
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:system_loja/presentation/routes/app_router.gr.dart';

class CadastroBottomSheet extends StatelessWidget {
  const CadastroBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'O que você deseja cadastrar?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.person_add),
            title: const Text('Pessoa (Cliente/Empresa)'),
            onTap: () {
              Navigator.of(context).pop(); // Fecha o modal
              context.router.push(const PersonRegistrationRoute()); // Rota FullScreen
            },
          ),
          ListTile(
            leading: const Icon(Icons.inventory_2),
            title: const Text('Produto'),
            onTap: () {
              Navigator.of(context).pop();
              context.router.push(const ProductRegistrationRoute()); // Futura rota
            },
          ),
        ],
      ),
    );
  }
}
```

## 4. O AppRouter (Root Router)
Define a estrutura hierárquica. Telas que devem ocultar a barra inferior ficam fora do `children` do `HostRoute`.

**Arquivo: `lib/presentation/routes/app_router.dart`**
```dart
import 'package:auto_route/auto_route.dart';

@AutoRouterConfig(replaceInRouteName: 'View|Screen|Wrapper,Route')
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HostRoute.page,
      initial: true,
      children: [
        AutoRoute(page: OverviewRoute.page, initial: true), // 0
        AutoRoute(page: DummyCadastroRoute.page),           // 1
        AutoRoute(page: DummyConsultasRoute.page),          // 2
        AutoRoute(page: SalesRoute.page),                   // 3
        AutoRoute(page: ConfigWrapperRoute.page),           // 4
      ],
    ),
    // Rotas FullScreen / Globais
    AutoRoute(page: PersonRegistrationRoute.page),
    AutoRoute(page: ProductRegistrationRoute.page), // Criar depois
    AutoRoute(page: CompanyEditRoute.page),
    // ...
  ];
}
```

## 5. Próximos Passos & CheckList
- [ ] Criar a página de Visão Geral (OverviewScreen) com a anotação `@RoutePage()`.
- [ ] Criar as `DummyCadastroScreen` e `DummyConsultasScreen` (basta serem um `SizedBox()`).
- [ ] Atualizar o `lib/app_injection.dart` apontando para o novo `AppRouter`.
- [ ] Rodar o build runner: `dart run build_runner build --delete-conflicting-outputs`.
- [ ] Deletar o antigo `lib/screens/route/route_app.dart`.