import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

class LogErrorSystemSection extends StatelessWidget {
  const LogErrorSystemSection({super.key});

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.analytics, color: Theme.of(context).colorScheme.primary),
                const SizedBox(width: 8),
                const Text(
                  'Análise de Logs do Sistema',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ],
            ),
            const Divider(),
            ListTile(
              title: const Text('Analisar logs de erro do sistema'),
              subtitle: const Text('Abrir análise detalhada dos logs'),
              leading: const Icon(Icons.analytics),
              onTap: () => onOpenLogsAnalysis(context),
            ),
          ],
        ),
      ),
    );

  void onOpenLogsAnalysis(BuildContext context) {
    // Implementar a lógica para abrir a análise de logs
    context.router.push(const LogSystemRoute());
  }
}
