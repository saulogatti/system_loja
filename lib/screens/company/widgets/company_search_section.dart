import 'package:flutter/material.dart';

/// Widget de busca de empresa por CNPJ
///
/// Permite pesquisar uma empresa específica pelo CNPJ e navegar para detalhes.
class CompanySearchSection extends StatelessWidget {
  final TextEditingController searchCnpjController;
  final VoidCallback onSearch;

  const CompanySearchSection({
    super.key,
    required this.searchCnpjController,
    required this.onSearch,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Buscar Empresa por CNPJ',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: searchCnpjController,
                decoration: const InputDecoration(
                  labelText: 'CNPJ',
                  hintText: '00.000.000/0000-00',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.badge),
                ),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => onSearch(),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 20,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
