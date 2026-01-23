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
      await AppInjection.instance.configurationRepository.atualizarConfiguracao(
        event.appSettings,
      );
      emit(
        SettingsConfirmedState(
          event.appSettings,
          'Configurações salvas com sucesso!',
        ),
      );
      // Retorna ao estado loaded após sucesso
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(event.appSettings));
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
      emit(SettingsLoadedState(configuracao));
    } catch (e) {
      emit(SettingsError('Erro ao carregar configurações: $e'));
    }
  }

  /// Limpa logs antigos baseado na configuração
  Future<void> _onLimparLogsAntigos(
    ClearOldLogsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsConfirmedState) return;

    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .clearOldLogs();
      if (sucesso) {
        emit(
          SettingsConfirmedState(
            currentState.appSettings,
            'Logs antigos removidos com sucesso!',
          ),
        );
      } else {
        emit(const SettingsError('Erro ao remover logs'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
    } catch (e) {
      emit(SettingsError('Erro ao limpar logs: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
    }
  }

  /// Limpa todos os dados do sistema
  Future<void> _onLimparTodosDados(
    ClearAllDataEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsConfirmedState) return;

    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .limparTodosDados();
      if (sucesso) {
        emit(
          SettingsConfirmedState(
            currentState.appSettings,
            'Todos os dados foram removidos!',
          ),
        );
      } else {
        emit(const SettingsError('Erro ao remover dados'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
    } catch (e) {
      emit(SettingsError('Erro ao limpar dados: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
    }
  }

  /// Realiza backup dos dados do sistema
  Future<void> _onRealizarBackup(
    BackupSettingsEvent event,
    Emitter<SettingsState> emit,
  ) async {
    final currentState = state;
    if (currentState is! SettingsConfirmedState) return;

    emit(const SettingsLoadingState());
    try {
      final sucesso = await AppInjection.instance.configurationRepository
          .realizarBackup();
      if (sucesso) {
        emit(
          SettingsConfirmedState(
            currentState.appSettings,
            'Backup realizado com sucesso!',
          ),
        );
      } else {
        emit(const SettingsError('Erro ao realizar backup'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
    } catch (e) {
      emit(SettingsError('Erro ao realizar backup: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(currentState.appSettings));
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
        SettingsConfirmedState(
          configuracao,
          'Configurações restauradas para padrão!',
        ),
      );
      await Future.delayed(const Duration(milliseconds: 500));
      emit(SettingsLoadedState(configuracao));
    } catch (e) {
      emit(SettingsError('Erro ao restaurar configurações: $e'));
    }
  }
}
