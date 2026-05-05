//SystemErrorModel
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_system_error_manager.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_cubit.dart';
import 'package:system_loja/screens/configuracoes/bloc/logs_system_state.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

@RoutePage()
class LogSystemScreen extends StatefulWidget implements AutoRouteWrapper {
  const LogSystemScreen({super.key});

  @override
  State<LogSystemScreen> createState() => _LogSystemScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          LogsSystemCubit(appInjection.get<ISystemErrorManager>()),
      child: this,
    );
  }
}

class _LogSystemScreenState extends State<LogSystemScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LogsSystemCubit, LogsSystemState>(
      listener: (context, state) {
        state.whenOrNull(
          error: (message) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(message),
                backgroundColor: Theme.of(context).colorScheme.error,
              ),
            );
          },
        );
      },
      builder: (context, state) {
        final hasLogs = state.maybeWhen(
          loaded: (logs) => logs.isNotEmpty,
          orElse: () => false,
        );

        return Scaffold(
          appBar: AppBar(
            title: const Text('Logs do Sistema'),
            leading: const AutoLeadingButton(),
            actions: [
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: hasLogs
                    ? () async {
                        final confirmar = await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Limpar Logs'),
                            content: const Text(
                              'Tem certeza que deseja limpar todos os logs do sistema? Esta ação não poderá ser desfeita.',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(false),
                                child: const Text('Cancelar'),
                              ),
                              ElevatedButton(
                                onPressed: () =>
                                    Navigator.of(context).pop(true),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Theme.of(
                                    context,
                                  ).colorScheme.error,
                                  foregroundColor: Theme.of(
                                    context,
                                  ).colorScheme.onError,
                                ),
                                child: const Text('Limpar'),
                              ),
                            ],
                          ),
                        );

                        if (confirmar == true && context.mounted) {
                          context.read<LogsSystemCubit>().clearLogs();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Logs limpos com sucesso.'),
                              backgroundColor: Colors.green,
                            ),
                          );
                        }
                      }
                    : null,
                tooltip: 'Limpar Logs',
              ),
            ],
          ),
          body: Center(
            child: state.when(
              initial: () => const Text('Por favor, carregue os logs.'),
              loading: () => const CircularProgressIndicator(),
              loaded: (logs) {
                if (logs.isEmpty) {
                  return const EmptyWidget(
                    message: 'Nenhum log registrado',
                    subMessage:
                        'O sistema não possui erros registrados no momento.',
                    icon: Icons.check_circle_outline,
                    semanticLabel:
                        'Lista de logs vazia. Nenhum log registrado.',
                  );
                }

                return ListView.builder(
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
                            title: const Text('Detalhes do Erro'),
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
                );
              },
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
