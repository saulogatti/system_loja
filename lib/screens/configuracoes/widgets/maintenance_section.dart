import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

/// Widget da seção de configurações de limpeza de dados
class MaintenanceSection extends StatelessWidget {
  /// Configuração atual do sistema
  final SystemConfiguration config;

  /// Callback para atualizar a configuração
  final Function(SystemConfiguration) onConfigChanged;

  /// Callback para limpar logs antigos
  final VoidCallback onLimparLogsAntigos;

  /// Callback para limpar todos os dados
  final VoidCallback onLimparTodosDados;

  const MaintenanceSection({
    required this.config,
    required this.onConfigChanged,
    required this.onLimparLogsAntigos,
    required this.onLimparTodosDados,
    super.key,
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
                Icon(Icons.cleaning_services, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Limpeza de Dados',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            SwitchListTile(
              title: const Text('Limpeza automática de logs'),
              subtitle: const Text('Remover logs antigos automaticamente'),
              value: config.isAutoCleanEnabled,
              onChanged: (value) {
                onConfigChanged(config.copyWith(isAutoCleanEnabled: value));
              },
            ),
            if (config.isAutoCleanEnabled)
              ListTile(
                title: const Text('Dias para manter logs'),
                subtitle: Slider(
                  value: config.logRetentionDays.toDouble(),
                  min: 7,
                  max: 365,
                  divisions: 358,
                  label: '${config.logRetentionDays} dias',
                  onChanged: (value) {
                    onConfigChanged(config.copyWith(logRetentionDays: value.toInt()));
                  },
                ),
                trailing: Text('${config.logRetentionDays}'),
              ),
            ListTile(
              title: const Text('Analisar logs do sistema'),
              subtitle: const Text('Abrir análise detalhada dos logs'),
              leading: const Icon(Icons.analytics),
              onTap: () => onOpenLogsAnalysis(context),
            ),
            ListTile(
              title: const Text('Limpar logs antigos agora'),
              subtitle: const Text('Remover logs com base na configuração'),
              leading: const Icon(Icons.delete_sweep),
              onTap: onLimparLogsAntigos,
            ),
            ListTile(
              title: const Text('Limpar todos os dados', style: TextStyle(color: Colors.red)),
              subtitle: const Text('Remover TODOS os dados do sistema'),
              leading: const Icon(Icons.warning, color: Colors.red),
              onTap: onLimparTodosDados,
            ),
          ],
        ),
      ),
    );
  }

  void onOpenLogsAnalysis(BuildContext context) {
    AutoRouter.of(context).push(const LogsAnalyticsRoute());
  }
}
