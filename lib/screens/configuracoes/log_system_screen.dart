//SystemErrorModel
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_system_error_manager.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_state.dart';

@RoutePage()
class LogSystemScreen extends StatefulWidget implements AutoRouteWrapper {
  const LogSystemScreen({super.key});

  @override
  State<LogSystemScreen> createState() => _LogSystemScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) => LogsSystemCubit(appInjection.get<ISystemErrorManager>()),
      child: this,
    );
  }
}

class _LogSystemScreenState extends State<LogSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LogsSystemCubit, LogsSystemState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Logs do Sistema'),
            leading: AutoLeadingButton(),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () {
                  context.read<LogsSystemCubit>().clearLogs();
                },
                tooltip: 'Limpar Logs',
              ),
            ],
          ),
          body: Center(
            child: state.when(
              initial: () => const Text('Por favor, carregue os logs.'),
              loading: () => const CircularProgressIndicator(),
              loaded: (logs) => ListView.builder(
                itemCount: logs.length,
                itemBuilder: (context, index) {
                  final log = logs[index];
                  return ListTile(
                    title: Text('Código do Erro: ${log.code}'),
                    subtitle: Text(log.message),
                    onTap: () {
                      showDialog(
                        context: context,

                        builder: (context) => AlertDialog(
                          scrollable: true,
                          title: Text('Detalhes do Erro'),
                          content: Text(
                            'Código: ${log.code}\nMensagem: ${log.message}\nDetalhes: ${log.stackTrace}',
                          ),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(),
                              child: const Text('Fechar'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
              error: (message) => Text('Erro: $message'),
            ),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    context.read<LogsSystemCubit>().loadLogs();
  }
}
