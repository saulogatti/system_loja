import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_state_cubit.dart';

@RoutePage()
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
      body: BlocBuilder<LogsCubit, LogsState>(
        builder: (context, state) {
          switch (state) {
            case LogsStateInitial():
            case LogsLoading():
              return const Center(child: CircularProgressIndicator());
            case LogsLoaded(:final logs):
              return ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return ListTile(
                    title: Text('Ação: ${log.action}'),
                    subtitle: Text(
                      'Usuário: ${log.userName} - Entidade: ${log.entity}\nDetalhes: ${log.details} - Timestamp: ${log.timestamp} createdAt: ${log.registrationDate}',
                    ),
                    isThreeLine: true,
                  );
                },
              );
            case LogsError(:final message):
              return Center(
                child: TextButton(
                  onPressed: () {
                    // Tenta carregar os logs novamente ao clicar no botão
                    context.read<LogsCubit>().fetchActivesLogs();
                  },
                  child: Text(
                    'Erro ao carregar logs: $message',
                    style: TextStyle(color: Theme.of(context).colorScheme.error),
                  ),
                ),
              );
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LogsCubit>().fetchActivesLogs();
  }
}
