import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

/// Tela inicial do sistema de gerenciamento de loja.
///
/// Exibe boas-vindas e atalhos. A navegação principal é feita pela
/// barra inferior (Home, Cadastro, Vendas, Usuários, Configurações).
@RoutePage()
class HomeScreen extends StatelessWidget {
  /// Cria uma instância de [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(Icons.store, size: 100, color: Theme.of(context).colorScheme.primary),
              const SizedBox(height: 40),
              Text(
                'Bem-vindo!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Use o menu inferior para acessar as funcionalidades',
                style: Theme.of(
                  context,
                ).textTheme.bodyLarge?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
