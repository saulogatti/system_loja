import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';

/// Widget da seção de configurações de banco de dados
class SecaoBancoDados extends StatelessWidget {
  /// Configuração atual do sistema
  final AppSettings config;

  /// Callback para atualizar a configuração
  final Function(AppSettings) onConfigChanged;

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
                Icon(
                  Icons.storage,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Banco de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            RadioGroup<EnumTypeCache>(
              groupValue: config.typeCache,
              onChanged: (EnumTypeCache? value) {
                if (value != null) {
                  config.typeCache = value;
                  onConfigChanged(config);
                }
              },
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text('Selected: ${config.typeCache.name.toUpperCase()}'),
                  const ListTile(
                    title: Text('JSON'),
                    leading: Radio<EnumTypeCache>(value: EnumTypeCache.json),
                  ),
                  const ListTile(
                    title: Text('SQL'),
                    leading: Radio<EnumTypeCache>(value: EnumTypeCache.sql),
                  ),
                ],
              ),
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
