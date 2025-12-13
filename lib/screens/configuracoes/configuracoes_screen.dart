import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/app_theme_settings.dart';

import 'bloc/configuracoes_bloc.dart';
import 'bloc/configuracoes_event.dart';
import 'bloc/configuracoes_state.dart';
import 'widgets/secao_backup.dart';
import 'widgets/secao_limpeza.dart';
import 'widgets/secao_notificacoes.dart';
import 'widgets/secao_seguranca.dart';
import 'widgets/secao_tema.dart';

/// Tela de Configurações do Sistema
///
/// Permite aos administradores ajustar preferências de notificação,
/// temas visuais, backup, limpeza de dados, segurança e tipo de banco.
/// Utiliza BLoC para gerenciamento de estado.
class ConfiguracoesScreen extends StatelessWidget {
  const ConfiguracoesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ConfiguracoesBloc()..add(const CarregarConfiguracoesEvent()),
      child: const _ConfiguracoesView(),
    );
  }
}

class _ConfiguracoesView extends StatelessWidget {
  const _ConfiguracoesView();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações do Sistema'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.restore),
            tooltip: 'Restaurar Padrão',
            onPressed: () => _restaurarPadrao(context),
          ),
        ],
      ),
      body: BlocConsumer<ConfiguracoesBloc, ConfiguracoesState>(
        listener: (context, state) {
          if (state is ConfiguracoesSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.mensagem),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state is ConfiguracoesError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.mensagem),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is ConfiguracoesLoading || state is ConfiguracoesInitial) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is ConfiguracoesError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(state.mensagem),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => context.read<ConfiguracoesBloc>().add(
                      const CarregarConfiguracoesEvent(),
                    ),
                    child: const Text('Tentar Novamente'),
                  ),
                ],
              ),
            );
          }

          final config = state is ConfiguracoesLoaded
              ? state.configuracao
              : (state as ConfiguracoesSuccess).configuracao;

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SecaoNotificacoes(
                  config: config,
                  onConfigChanged: (newConfig) =>
                      _updateConfig(context, newConfig),
                ),
                const SizedBox(height: 24),
                SecaoTema(
                  config: config,
                  onConfigChanged: (newConfig) =>
                      _updateConfig(context, newConfig),
                  onMostrarSeletorCor: () =>
                      _mostrarSeletorCor(context, config),
                ),
                const SizedBox(height: 24),
                SecaoBackup(
                  config: config,
                  onConfigChanged: (newConfig) =>
                      _updateConfig(context, newConfig),
                  onRealizarBackup: () => context.read<ConfiguracoesBloc>().add(
                    const RealizarBackupEvent(),
                  ),
                  onSelecionarFrequencia: () =>
                      _selecionarFrequenciaBackup(context, config),
                ),
                const SizedBox(height: 24),
                SecaoLimpeza(
                  config: config,
                  onConfigChanged: (newConfig) =>
                      _updateConfig(context, newConfig),
                  onLimparLogsAntigos: () =>
                      _limparLogsAntigos(context, config),
                  onLimparTodosDados: () => _limparTodosDados(context),
                ),
                const SizedBox(height: 24),
                SecaoSeguranca(
                  config: config,
                  onConfigChanged: (newConfig) =>
                      _updateConfig(context, newConfig),
                ),
                const SizedBox(height: 24),
                // SecaoBancoDados(
                //   config: config,
                //   onConfigChanged: (newConfig) =>
                //       _updateConfig(context, newConfig),
                // ),
                const SizedBox(height: 32),
                _buildBotaoSalvar(context, config),
              ],
            ),
          );
        },
      ),
    );
  }

  /// Botão de salvar configurações
  Widget _buildBotaoSalvar(BuildContext context, AppSettings config) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Salvar Configurações'),
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(16),
          backgroundColor: Theme.of(context).colorScheme.primary,
          foregroundColor: Colors.white,
        ),
        onPressed: () {
          context.read<ConfiguracoesBloc>().add(
            AtualizarConfiguracoesEvent(config),
          );
        },
      ),
    );
  }

  /// Limpa logs antigos
  Future<void> _limparLogsAntigos(
    BuildContext context,
    AppSettings config,
  ) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Limpar Logs Antigos'),
        content: Text(
          'Deseja remover logs com mais de ${config.diasManterLogs} dias?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Limpar'),
          ),
        ],
      ),
    );

    if (confirmado == true && context.mounted) {
      context.read<ConfiguracoesBloc>().add(const LimparLogsAntigosEvent());
    }
  }

  /// Limpa todos os dados do sistema
  Future<void> _limparTodosDados(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('ATENÇÃO!'),
        content: const Text(
          'Esta ação irá REMOVER TODOS OS DADOS do sistema '
          '(clientes, produtos, notas fiscais, usuários e logs).\n\n'
          'Esta ação NÃO PODE ser desfeita!\n\n'
          'Tem certeza que deseja continuar?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Sim, Limpar Tudo'),
          ),
        ],
      ),
    );

    if (confirmado == true && context.mounted) {
      context.read<ConfiguracoesBloc>().add(const LimparTodosDadosEvent());
    }
  }

  /// Mostra seletor de cor
  Future<void> _mostrarSeletorCor(
    BuildContext context,
    AppSettings config,
  ) async {
    final selecionada = await showDialog<EnumColorAppThemeSettings>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Escolher Cor'),
        children: EnumColorAppThemeSettings.values.map((entry) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, entry),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: entry.color,
                    borderRadius: BorderRadius.circular(4),
                    border: Border.all(color: Colors.grey),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  entry.name,
                  style: TextStyle(fontWeight: FontWeight.normal),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selecionada != null && context.mounted) {
      final newConfig = config.copyWith(corPrimaria: selecionada);
      context.read<ConfiguracoesBloc>().add(
        AtualizarConfiguracoesEvent(newConfig),
      );
    }
  }

  /// Restaura configurações padrão
  Future<void> _restaurarPadrao(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Restaurar Configurações'),
        content: const Text(
          'Deseja restaurar todas as configurações para os valores padrão?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: const Text('Restaurar'),
          ),
        ],
      ),
    );

    if (confirmado == true && context.mounted) {
      context.read<ConfiguracoesBloc>().add(const RestaurarPadraoEvent());
    }
  }

  /// Seleciona a frequência de backup
  Future<void> _selecionarFrequenciaBackup(
    BuildContext context,
    AppSettings config,
  ) async {
    final opcoes = ['diario', 'semanal', 'mensal'];
    final selecionado = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Frequência de Backup'),
        children: opcoes.map((opcao) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, opcao),
            child: Text(
              opcao[0].toUpperCase() + opcao.substring(1),
              style: TextStyle(
                fontWeight: config.frequenciaBackup == opcao
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );

    if (selecionado != null && context.mounted) {
      final newConfig = config.copyWith(frequenciaBackup: selecionado);
      context.read<ConfiguracoesBloc>().add(
        AtualizarConfiguracoesEvent(newConfig),
      );
    }
  }

  /// Atualiza a configuração no estado local (não salva ainda)
  void _updateConfig(BuildContext context, AppSettings newConfig) {
    context.read<ConfiguracoesBloc>().add(
      CarregarConfiguracoesEvent(),
    ); // Recarrega para manter estado
    // Aqui mantemos o config local até salvar
    // Em uma implementação mais complexa, usaríamos outro evento
  }
}
