import 'package:flutter/material.dart';

import 'cliente/cliente_screen.dart';
import 'nota_fiscal_screen.dart';
import 'produto_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sistema de Gerenciamento de Loja'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Icon(Icons.store, size: 100, color: Colors.blue),
            const SizedBox(height: 40),
            const Text(
              'Bem-vindo!',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            const Text(
              'Selecione uma opção para continuar',
              style: TextStyle(fontSize: 16, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            _buildMenuCard(
              context,
              title: 'Cadastro de Cliente',
              icon: Icons.person,
              color: Colors.blue,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ClienteScreen()));
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: 'Cadastro de Produto',
              icon: Icons.inventory,
              color: Colors.green,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ProdutoScreen()));
              },
            ),
            const SizedBox(height: 16),
            _buildMenuCard(
              context,
              title: 'Cadastro de Nota Fiscal',
              icon: Icons.receipt_long,
              color: Colors.orange,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const NotaFiscalScreen()));
              },
            ),
          ],
        ),
      ),
    );
  }

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
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
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
              const SizedBox(width: 20),
              Expanded(
                child: Text(title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
              ),
              Icon(Icons.arrow_forward_ios, color: Colors.grey[400]),
            ],
          ),
        ),
      ),
    );
  }
}
