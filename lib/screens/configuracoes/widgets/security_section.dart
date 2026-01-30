import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';

/// Widget da seção de configurações de segurança
class SecuritySection extends StatelessWidget {
  /// Configuração atual do sistema
  final AppSettings config;

  /// Callback para atualizar a configuração
  final Function(AppSettings) onConfigChanged;

  const SecuritySection({
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
                  Icons.security,
                  color: Theme.of(context).colorScheme.primary,
                ),
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
              value: config.exigirSenha,
              onChanged: (value) {
                onConfigChanged(config.copyWith(exigirSenha: value));
              },
            ),
            if (config.exigirSenha)
              ListTile(
                title: const Text('Tempo de bloqueio'),
                subtitle: Slider(
                  value: config.tempoBloqueioMinutos.toDouble(),
                  min: 1,
                  max: 60,
                  divisions: 59,
                  label: '${config.tempoBloqueioMinutos} min',
                  onChanged: (value) {
                    onConfigChanged(
                      config.copyWith(tempoBloqueioMinutos: value.toInt()),
                    );
                  },
                ),
                trailing: Text('${config.tempoBloqueioMinutos} min'),
              ),
            SwitchListTile(
              title: const Text('Permitir múltiplos usuários'),
              subtitle: const Text('Habilitar gestão de usuários'),
              value: config.permitirMultiplosUsuarios,
              onChanged: (value) {
                onConfigChanged(
                  config.copyWith(permitirMultiplosUsuarios: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
