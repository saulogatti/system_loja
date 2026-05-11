import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_configuration_repository.dart';
import 'package:system_loja/core/settings/app_settings.dart';
import 'package:system_loja/core/settings/enum_color_app_theme_settings.dart';
import 'package:system_loja/screens/route/route_app.gr.dart';

import 'bloc/settings_bloc.dart';
import 'bloc/settings_event.dart';
import 'bloc/settings_state.dart';
import 'widgets/secao_backup.dart';
import 'widgets/secao_notificacoes.dart';
import 'widgets/theme_settings.dart';

/// Enum para frequência de backup
enum FrequenciaBackup {
  diario('diario', 'Diário'),
  semanal('semanal', 'Semanal'),
  mensal('mensal', 'Mensal');

  final String value;
  final String label;

  const FrequenciaBackup(this.value, this.label);

  static FrequenciaBackup fromValue(String value) {
    return FrequenciaBackup.values.firstWhere(
      (e) => e.value == value,
      orElse: () => FrequenciaBackup.diario,
    );
  }
}

class LogErrorSystemSection extends StatelessWidget {
  const LogErrorSystemSection({super.key});

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
  }

  void onOpenLogsAnalysis(BuildContext context) {
    // Implementar a lógica para abrir a análise de logs
    context.router.push(const LogSystemRoute());
  }
}

/// Tela de Configurações do Sistema
///
/// Permite aos administradores ajustar preferências de notificação,
/// temas visuais, backup, limpeza de dados, segurança e tipo de banco.
/// Utiliza BLoC para gerenciamento de estado.
@RoutePage()
class SettingsScreen extends StatefulWidget implements AutoRouteWrapper {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<SettingsBloc>(
      create: (_) =>
          SettingsBloc(configurationRepository: appInjection.get<IConfigurationRepository>()),
      child: this,
    );
  }
}

class _SettingsScreenState extends State<SettingsScreen> {
  AppSettings? _draftConfig;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      persistentFooterButtons: [
        TextButton(onPressed: () => _resetToDefault(context), child: const Text('Restaurar Dados')),
        TextButton(
          onPressed: () => _openSystemSettings(context),
          child: const Text('Configurações do Sistema'),
        ),
        TextButton(
          onPressed: () => context.router.push(const UsuarioRoute()),
          child: const Text('Usuários'),
        ),
        TextButton(
          onPressed: () => context.router.push(const IssuerConfigRoute()),
          child: const Text('Empresa Emitente'),
        ),
      ],
      body: BlocConsumer<SettingsBloc, SettingsState>(
        listener: (context, state) {
          if (state is SettingsLoadedState) {
            _draftConfig = state.appSettings;
            if (state.status != SettingsSuccessStatus.loaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.status.mensagem), backgroundColor: Colors.green),
              );
            }
          } else if (state is SettingsError) {
            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(state.mensagem), backgroundColor: Colors.red));
          }
        },

        builder: (context, state) {
          switch (state) {
            case SettingsError():
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.error, size: 64, color: Colors.red),
                    const SizedBox(height: 16),
                    Text(state.mensagem),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => context.read<SettingsBloc>().add(const LoadSettingsEvent()),
                      child: const Text('Tentar Novamente'),
                    ),
                  ],
                ),
              );
            case SettingsLoadingState():
            case SettingsInitialState():
              return const Center(child: CircularProgressIndicator());

            case SettingsLoadedState():
              final currentConfig = _draftConfig ?? state.appSettings;
              return SingleChildScrollView(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SecaoNotificacoes(config: currentConfig, onConfigChanged: _updateConfig),
                    const SizedBox(height: 24),
                    ThemeSettings(
                      config: currentConfig,
                      onConfigChanged: _updateConfig,
                      onMostrarSeletorCor: () => _mostrarSeletorCor(context, currentConfig),
                    ),

                    const SizedBox(height: 24),
                    SecaoBackup(
                      config: currentConfig,
                      onConfigChanged: _updateConfig,
                      onRealizarBackup: () =>
                          context.read<SettingsBloc>().add(const BackupSettingsEvent()),
                      onSelecionarFrequencia: () =>
                          _selecionarFrequenciaBackup(context, currentConfig),
                    ),

                    const SizedBox(height: 32),
                    _buildBotaoSalvar(context, currentConfig),
                  ],
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
    // Carrega as configurações iniciais ao iniciar a tela
    context.read<SettingsBloc>().add(const LoadSettingsEvent());
  }

  /// Botão de salvar configurações
  Widget _buildBotaoSalvar(BuildContext context, AppSettings config) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        icon: const Icon(Icons.save),
        label: const Text('Salvar Configurações'),
        style: ElevatedButton.styleFrom(padding: const EdgeInsets.all(16)),
        onPressed: () {
          context.read<SettingsBloc>().add(UpdateSettingsEvent(_draftConfig ?? config));
        },
      ),
    );
  }

  Future<void> _confirmarRestaurarPadrao(BuildContext context) async {
    final confirmado = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Restaurar Configurações'),
        content: const Text('Deseja restaurar todas as configurações para os valores padrão?'),
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
      context.read<SettingsBloc>().add(const ResetDefaultSettingsEvent());
    }
  }

  /// Mostra seletor de cor
  Future<void> _mostrarSeletorCor(BuildContext context, AppSettings config) async {
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
                Text(entry.name, style: TextStyle(fontWeight: FontWeight.normal)),
              ],
            ),
          );
        }).toList(),
      ),
    );

    if (selecionada != null && context.mounted) {
      final newConfig = config.copyWith(corPrimaria: selecionada);
      _updateConfig(newConfig);
    }
  }

  void _openSystemSettings(BuildContext context) {
    context.router.push(const SystemConfigRoute());
  }

  /// Restaura configurações padrão
  Future<void> _resetToDefault(BuildContext context) async {
    // Neste modal bottom sheet vai ter opções de recuperar padrão ou recuperar do backup. //
    showModalBottomSheet(
      context: context,
      builder: (buildContext) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.restore),
              title: const Text('Restaurar Configurações Padrão'),
              onTap: () {
                Navigator.pop(buildContext);
                _confirmarRestaurarPadrao(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.backup),
              title: const Text('Restaurar de Backup'),
              onTap: () {
                Navigator.pop(buildContext);
                context.read<SettingsBloc>().add(const RestoreBackupEvent());
              },
            ),
          ],
        );
      },
    );
  }

  /// Seleciona a frequência de backup
  Future<void> _selecionarFrequenciaBackup(BuildContext context, AppSettings config) async {
    final selecionado = await showDialog<FrequenciaBackup>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: const Text('Frequência de Backup'),
        children: FrequenciaBackup.values.map((opcao) {
          return SimpleDialogOption(
            onPressed: () => Navigator.pop(dialogContext, opcao),
            child: Text(
              opcao.label,
              style: TextStyle(
                fontWeight: config.frequenciaBackup == opcao.value
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
          );
        }).toList(),
      ),
    );

    if (selecionado != null && context.mounted) {
      final newConfig = config.copyWith(frequenciaBackup: selecionado.value);
      _updateConfig(newConfig);
    }
  }

  /// Atualiza a configuração no estado local (não salva ainda)
  void _updateConfig(AppSettings newConfig) {
    setState(() {
      _draftConfig = newConfig;
    });
  }
}

extension EnumColorAppThemeSettingsExtension on EnumColorAppThemeSettings {
  Color get color {
    switch (this) {
      case EnumColorAppThemeSettings.azul:
        return Colors.blue;
      case EnumColorAppThemeSettings.verde:
        return Colors.green;
      case EnumColorAppThemeSettings.laranka:
        return Colors.orange;
      case EnumColorAppThemeSettings.roxo:
        return Colors.purple;
      case EnumColorAppThemeSettings.vermelho:
        return Colors.red;
      case EnumColorAppThemeSettings.rosa:
        return Colors.pink;
      case EnumColorAppThemeSettings.ciano:
        return Colors.cyan;
      case EnumColorAppThemeSettings.indigo:
        return Colors.indigo;
    }
  }
}
