import 'package:flutter/material.dart';
import 'package:system_loja/screens/configuracoes/configuracoes_screen.dart';
import 'package:system_loja/screens/usuario_screen.dart';

import '../customer/customer_view.dart';
import '../products/product_screen.dart';
import '../sales/sales_screen.dart';

/// Tela principal do sistema de gerenciamento de loja.
///
/// Exibe um menu com cartões de navegação para as principais funcionalidades:
/// - Cadastro de Cliente
/// - Cadastro de Produto
/// - Cadastro de Nota Fiscal
/// - Gestão de Usuários
class HomeScreen extends StatelessWidget {
  /// Cria uma instância de [HomeScreen].
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _buildMenuCard(
        context,
        title: 'Cadastro de Cliente',
        icon: Icons.person,
        color: Colors.blue,
        onTap: () => _navigateToScreen(context, const CustomerView()),
      ),
      _buildMenuCard(
        context,
        title: 'Cadastro de Produto',
        icon: Icons.inventory,
        color: Colors.green,
        onTap: () => _navigateToScreen(context, const ProductViewScreen()),
      ),
      _buildMenuCard(
        context,
        title: 'Cadastro de Nota Fiscal',
        icon: Icons.receipt_long,
        color: Colors.orange,
        onTap: () => _navigateToScreen(context, const SalesView()),
      ),
      _buildMenuCard(
        context,
        title: 'Gestão de Usuários',
        icon: Icons.people,
        color: Colors.purple,
        onTap: () => _navigateToScreen(context, const UsuarioScreen()),
      ),
      _buildMenuCard(
        context,
        title: 'Configurações do Sistema',
        icon: Icons.settings,
        color: Colors.teal,
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConfiguracoesScreen(),
            ),
          );
        },
      ),
    ];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Gerenciamento de Loja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.store,
                size: 100,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 40),
              Text(
                'Bem-vindo!',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 10),
              Text(
                'Selecione uma opção para continuar',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 320, // cada card no máximo 320px
                  mainAxisSpacing: 12,
                  crossAxisSpacing: 12,
                  childAspectRatio: 1.5,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) => items[index],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Constrói um cartão de menu com ícone, título e ação de navegação.
  ///
  /// Cada cartão é interativo e navega para uma tela específica quando tocado.
  ///
  /// Parâmetros:
  /// - [context]: O contexto de build para acessar o tema e navegação
  /// - [title]: Título exibido no cartão
  /// - [icon]: Ícone exibido no lado esquerdo do cartão
  /// - [color]: Cor do ícone e do fundo do container
  /// - [onTap]: Callback executado quando o cartão é tocado
  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 4,
      child: InkWell(
        onTap: onTap,
        // borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, size: 32, color: color),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    overflow: TextOverflow.ellipsis,
                  ),
                  maxLines: 2,
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Icon(
                  Icons.arrow_forward_ios,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Navega para a tela especificada.
  ///
  /// Encapsula a lógica de navegação para reduzir duplicação de código.
  void _navigateToScreen(BuildContext context, Widget screen) {
    Navigator.push(
      context,
      MaterialPageRoute<void>(builder: (context) => screen),
    );
  }
}
