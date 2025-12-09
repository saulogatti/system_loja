import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';

/// Widget da seção de configurações de backup
class SecaoBackup extends StatelessWidget {
  /// Configuração atual do sistema
  final AppSettings config;

  /// Callback para atualizar a configuração
  final Function(AppSettings) onConfigChanged;

  /// Callback para realizar backup manual
  final VoidCallback onRealizarBackup;

  /// Callback para selecionar frequência de backup
  final VoidCallback onSelecionarFrequencia;

  const SecaoBackup({
    super.key,
    required this.config,
    required this.onConfigChanged,
    required this.onRealizarBackup,
    required this.onSelecionarFrequencia,
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
                  Icons.backup,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Backup de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Backup automático'),
              subtitle: const Text('Realizar backups periodicamente'),
              value: config.backupAutomatico,
              onChanged: (value) {
                onConfigChanged(config.copyWith(backupAutomatico: value));
              },
            ),
            if (config.backupAutomatico)
              ListTile(
                title: const Text('Frequência de backup'),
                subtitle: Text(config.frequenciaBackup),
                trailing: const Icon(Icons.arrow_forward_ios),
                onTap: onSelecionarFrequencia,
              ),
            ListTile(
              title: const Text('Realizar backup agora'),
              subtitle: const Text('Criar cópia dos dados manualmente'),
              leading: const Icon(Icons.save),
              onTap: onRealizarBackup,
            ),
          ],
        ),
      ),
    );
  }
}
