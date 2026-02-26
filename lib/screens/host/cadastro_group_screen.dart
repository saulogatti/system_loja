import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Tela do grupo Cadastro.
///
/// Ao ser exibida, mostra um bottom sheet com opções: Cliente, Empresa, Produto.
/// Ao escolher uma opção, navega para a tela correspondente.
/// Se o usuário fechar sem escolher, exibe uma tela mínima com botão para reabrir.
@RoutePage()
class CadastroGroupScreen extends StatefulWidget {
  const CadastroGroupScreen({super.key});

  @override
  State<CadastroGroupScreen> createState() => _CadastroGroupScreenState();
}

class _CadastroGroupScreenState extends State<CadastroGroupScreen> {
  bool _sheetShown = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.person_add, size: 64, color: Theme.of(context).colorScheme.primary),
            const SizedBox(height: 16),
            Text(
              'Selecione uma opção de cadastro',
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: _showCadastroBottomSheet,
              icon: const Icon(Icons.add),
              label: const Text('Abrir opções'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showCadastroBottomSheet());
  }

  void _showCadastroBottomSheet() {
    if (!mounted || _sheetShown) return;
    _sheetShown = true;

    showModalBottomSheet<void>(
      context: context,
      useSafeArea: true,
      builder: (context) {
        return Material(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  'Selecione o cadastro',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text('Cadastro de Cliente'),
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(CustomerRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.business),
                  title: const Text('Cadastro de Empresa'),
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(CompanyRoute());
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.inventory),
                  title: const Text('Cadastro de Produto'),
                  onTap: () {
                    Navigator.pop(context);
                    context.router.push(ProductInfoRoute());
                  },
                ),
              ],
            ),
          ),
        );
      },
    ).whenComplete(() {
      _sheetShown = false;
    });
  }
}
