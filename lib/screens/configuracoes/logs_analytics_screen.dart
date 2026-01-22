import 'package:flutter/material.dart';

class LogsAnalyticsScreen extends StatefulWidget {
  const LogsAnalyticsScreen({super.key});

  @override
  State<LogsAnalyticsScreen> createState() => _LogsAnalyticsScreenState();
}

class _LogsAnalyticsScreenState extends State<LogsAnalyticsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Análise de Logs')),
      body: Center(
        child: Text(
          'Aqui será exibida a análise detalhada dos logs do sistema.',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
