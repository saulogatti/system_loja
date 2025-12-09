import 'package:flutter/material.dart';
import 'package:system_loja/core/models/configuracao.dart';

/// Widget da seção de configurações de banco de dados
class SecaoBancoDados extends StatelessWidget {
  /// Configuração atual do sistema
  final Configuracao config;
  
  /// Callback para atualizar a configuração
  final Function(Configuracao) onConfigChanged;

  const SecaoBancoDados({
    super.key,
    required this.config,
    required this.onConfigChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.storage,
                    color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Banco de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            RadioListTile<String>(
              title: const Text('JSON (Arquivos locais)'),
              subtitle:
                  const Text('Leve e simples, recomendado para uso básico'),
              value: 'json',
              groupValue: config.tipoBancoDados,
              onChanged: (value) {
                if (value != null) {
                  onConfigChanged(config.copyWith(tipoBancoDados: value));
                }
              },
            ),
            RadioListTile<String>(
              title: const Text('SQL (SQLite)'),
              subtitle: const Text(
                  'Mais robusto, recomendado para muitos dados'),
              value: 'sql',
              groupValue: config.tipoBancoDados,
              onChanged: (value) {
                if (value != null) {
                  onConfigChanged(config.copyWith(tipoBancoDados: value));
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Nota: Alterar o tipo de banco de dados requer reinicialização do aplicativo.',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[600],
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
