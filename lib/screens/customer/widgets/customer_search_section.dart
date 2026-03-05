import 'package:flutter/material.dart';
import 'package:system_loja/core/utils/text_formatters.dart';

/// Widget da seção de busca de cliente por CPF
///
/// Exibe campo de busca formatado para CPF e botão de busca.
class CustomerSearchSection extends StatelessWidget {
  final TextEditingController searchCpfController;
  final VoidCallback onSearch;

  const CustomerSearchSection({
    required this.searchCpfController, required this.onSearch, super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text(
          'Buscar Cliente por CPF',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: TextFormField(
                controller: searchCpfController,
                decoration: const InputDecoration(
                  labelText: 'CPF',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Digite o CPF para buscar',
                ),
                keyboardType: TextInputType.number,
                inputFormatters: [CpfTextInputFormatter()],
                maxLength: 14, // Formato XXX.XXX.XXX-XX
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton.icon(
              onPressed: onSearch,
              icon: const Icon(Icons.search),
              label: const Text('Buscar'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
