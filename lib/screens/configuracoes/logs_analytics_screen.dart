import 'package:auto_route/auto_route.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_state_cubit.dart';

/// Tela de análise dos logs de atividade do sistema.
///
/// {@category apresentacao}
/// {@subCategory Sistema}
@RoutePage()
class LogsAnalyticsScreen extends StatefulWidget {
  const LogsAnalyticsScreen({super.key});

  @override
  State<LogsAnalyticsScreen> createState() => _LogsAnalyticsScreenState();
}

class _LogsAnalyticsScreenState extends State<LogsAnalyticsScreen> {
  @override
  Widget build(BuildContext context) => Scaffold(
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
                return Semantics(
                  label:
                      'Ação: ${log.action}, Usuário: ${log.userName}, Entidade: ${log.entity}, Detalhes: ${log.details}, Timestamp: ${log.timestamp}, Criado em: ${log.registrationDate}',
                  excludeSemantics: true,
                  child: ListTile(
                    title: Text('Ação: ${log.action}'),
                    subtitle: Text(
                      'Usuário: ${log.userName} - Entidade: ${log.entity}\nDetalhes: ${log.details} - Timestamp: ${log.timestamp} createdAt: ${log.registrationDate}',
                    ),
                    isThreeLine: true,
                  ),
                );
              },
            );
          case LogsError(:final message):
            return Center(
              child: Semantics(
                button: true,
                child: ElevatedButton.icon(
                  onPressed: () {
                    // Tenta carregar os logs novamente ao clicar no botão
                    context.read<LogsCubit>().fetchActivesLogs();
                  },
                  icon: const Icon(Icons.refresh),
                  label: Text(
                    'Erro ao carregar logs: $message\nToque para tentar novamente',
                    textAlign: TextAlign.center,
                  ),
                  tooltip: 'Tentar novamente',
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.onError,
                    backgroundColor: Theme.of(context).colorScheme.error,
                  ),
                ),
              ),
            );
        }
      },
    ),
  );

  @override
  void initState() {
    super.initState();
    context.read<LogsCubit>().fetchActivesLogs();
  }
}
