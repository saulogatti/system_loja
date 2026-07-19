import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';

/// Widget da seção de configurações de segurança
class SecuritySection extends StatelessWidget {

  const SecuritySection({required this.config, required this.onConfigChanged, super.key});
  /// Configuração atual do sistema
  final SystemConfiguration config;

  /// Callback para atualizar a configuração
  final Function(SystemConfiguration) onConfigChanged;

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.security, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Segurança',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Exigir senha'),
              subtitle: const Text('Solicitar senha ao abrir o aplicativo'),
              value: config.isPasswordRequired,
              onChanged: (value) {
                onConfigChanged(config.copyWith(isPasswordRequired: value));
              },
            ),
            if (config.isPasswordRequired)
              ListTile(
                title: const Text('Tempo de bloqueio'),
                subtitle: Slider(
                  value: config.lockTimeoutMinutes.toDouble(),
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: '${config.lockTimeoutMinutes} min',
                  onChanged: (value) {
                    onConfigChanged(config.copyWith(lockTimeoutMinutes: value.toInt()));
                  },
                ),
                trailing: Text('${config.lockTimeoutMinutes} min'),
              ),
            SwitchListTile(
              title: const Text('Permitir múltiplos usuários'),
              subtitle: const Text('Habilitar gestão de usuários'),
              value: config.isMultiUserEnabled,
              onChanged: (value) {
                onConfigChanged(config.copyWith(isMultiUserEnabled: value));
              },
            ),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<SystemConfiguration>('config', config));
    properties.add(ObjectFlagProperty<Function(SystemConfiguration)>.has('onConfigChanged', onConfigChanged));
  }
}
