import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/settings/app_settings.dart';

/// Widget da seção de configurações de notificações
class SecaoNotificacoes extends StatelessWidget {

  const SecaoNotificacoes({
    required this.config,
    required this.onConfigChanged,
    super.key,
  });
  /// Configuração atual do sistema
  final AppSettings config;

  /// Callback para atualizar a configuração
  final Function(AppSettings) onConfigChanged;

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.notifications,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                const Text(
                  'Notificações',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Ativar notificações'),
              subtitle: const Text('Receber alertas do sistema'),
              value: config.notificacoesAtivadas,
              onChanged: (value) {
                onConfigChanged(config.copyWith(notificacoesAtivadas: value));
              },
            ),
            SwitchListTile(
              title: const Text('Notificar vendas'),
              subtitle: const Text('Alertas sobre novas vendas'),
              value: config.notificarVendas,
              onChanged: config.notificacoesAtivadas
                  ? (value) {
                      onConfigChanged(config.copyWith(notificarVendas: value));
                    }
                  : null,
            ),
            SwitchListTile(
              title: const Text('Notificar estoque baixo'),
              subtitle: const Text('Alertas quando estoque está baixo'),
              value: config.notificarEstoqueBaixo,
              onChanged: config.notificacoesAtivadas
                  ? (value) {
                      onConfigChanged(
                        config.copyWith(notificarEstoqueBaixo: value),
                      );
                    }
                  : null,
            ),
            if (config.notificarEstoqueBaixo && config.notificacoesAtivadas)
              ListTile(
                title: const Text('Limite de estoque baixo'),
                subtitle: Slider(
                  value: config.limiteEstoqueBaixo.toDouble(),
                  min: 1,
                  max: 50,
                  divisions: 49,
                  label: '${config.limiteEstoqueBaixo} unidades',
                  onChanged: (value) {
                    onConfigChanged(
                      config.copyWith(limiteEstoqueBaixo: value.toInt()),
                    );
                  },
                ),
                trailing: Text('${config.limiteEstoqueBaixo}'),
              ),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<AppSettings>('config', config));
    properties.add(ObjectFlagProperty<Function(AppSettings)>.has('onConfigChanged', onConfigChanged));
  }
}
