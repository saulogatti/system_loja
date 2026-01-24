import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

import 'settings_event.dart';
import 'settings_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema
///
/// Utiliza o ConfiguracaoManager para persistência de dados
/// e gerencia os estados da tela de configurações.
class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsInitialState()) {
    on<LoadSettingsEvent>(_onCarregarConfiguracoes);
    on<UpdateSettingsEvent>(_onAtualizarConfiguracoes);
    on<ResetDefaultSettingsEvent>(_onRestaurarPadrao);
    on<BackupSettingsEvent>(_onRealizarBackup);
    on<ClearOldLogsEvent>(_onLimparLogsAntigos);
    on<ClearAllDataEvent>(_onLimparTodosDados);
  }

  /// Atualiza as configurações do sistema
  Future<void> _onAtualizarConfiguracoes(
    UpdateSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final updatedSettings = await AppInjection
          .instance
          .configurationRepository
          .atualizarConfiguracao(event.appSettings);
      emit(
        SettingsLoadedState(
          updatedSettings,
          'Configurações salvas com sucesso!',
        ),
      );
    } catch (e) {
      emit(SettingsError('Erro ao salvar configurações: $e'));
    }
  }

  /// Carrega as configurações iniciais
  Future<void> _onCarregarConfiguracoes(
    LoadSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final configuracao = await AppInjection.instance.configurationRepository
          .carregarConfiguracao();
      emit(
        SettingsLoadedState(
          configuracao,
          'Configurações carregadas com sucesso!',
        ),
      );
    } catch (e) {
      emit(SettingsError('Erro ao carregar configurações: $e'));
    }
  }

  /// Limpa logs antigos baseado na configuração
  Future<void> _onLimparLogsAntigos(
    ClearOldLogsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .clearOldLogs();

      emit(SettingsLoadedState(sucesso, 'Logs antigos limpos com sucesso!'));
    } catch (e) {
      emit(SettingsError('Erro ao limpar logs: $e'));
    }
  }

  /// Limpa todos os dados do sistema
  Future<void> _onLimparTodosDados(
    ClearAllDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .limparTodosDados();

      emit(SettingsLoadedState(sucesso, 'Todos os dados foram removidos!'));
    } catch (e) {
      emit(SettingsError('Erro ao limpar dados: $e'));
    }
  }

  /// Realiza backup dos dados do sistema
  Future<void> _onRealizarBackup(
    BackupSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .realizarBackup();

      emit(SettingsLoadedState(sucesso, 'Backup realizado com sucesso!'));
    } catch (e) {
      emit(SettingsError('Erro ao realizar backup: $e'));
    }
  }

  /// Restaura as configurações para valores padrão
  Future<void> _onRestaurarPadrao(
    ResetDefaultSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    emit(const SettingsLoadingState());
    try {
      await AppInjection.instance.configurationRepository.restaurarPadrao();
      final configuracao = await AppInjection.instance.configurationRepository
          .carregarConfiguracao();

      emit(
        SettingsLoadedState(
          configuracao,
          'Configurações restauradas para o padrão!',
        ),
      );
    } catch (e) {
      emit(SettingsError('Erro ao restaurar configurações: $e'));
    }
  }
}
