import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/managers/configuracao_manager.dart';
import 'package:system_loja/core/models/configuracao.dart';

import 'configuracoes_event.dart';
import 'configuracoes_state.dart';

/// BLoC para gerenciar o estado das configurações do sistema
///
/// Utiliza o ConfiguracaoManager para persistência de dados
/// e gerencia os estados da tela de configurações.
class ConfiguracoesBloc extends Bloc<ConfiguracoesEvent, ConfiguracoesState> {
  final ConfiguracaoManager _manager;

  ConfiguracoesBloc({ConfiguracaoManager? manager})
      : _manager = manager ?? ConfiguracaoManager(),
        super(const ConfiguracoesInitial()) {
    on<CarregarConfiguracoesEvent>(_onCarregarConfiguracoes);
    on<AtualizarConfiguracoesEvent>(_onAtualizarConfiguracoes);
    on<RestaurarPadraoEvent>(_onRestaurarPadrao);
    on<RealizarBackupEvent>(_onRealizarBackup);
    on<LimparLogsAntigosEvent>(_onLimparLogsAntigos);
    on<LimparTodosDadosEvent>(_onLimparTodosDados);
  }

  /// Carrega as configurações iniciais
  Future<void> _onCarregarConfiguracoes(
    CarregarConfiguracoesEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    emit(const ConfiguracoesLoading());
    try {
      final configuracao = _manager.configuracao;
      emit(ConfiguracoesLoaded(configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao carregar configurações: $e'));
    }
  }

  /// Atualiza as configurações do sistema
  Future<void> _onAtualizarConfiguracoes(
    AtualizarConfiguracoesEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    emit(const ConfiguracoesLoading());
    try {
      await _manager.atualizarConfiguracao(event.configuracao);
      emit(ConfiguracoesSuccess(
        event.configuracao,
        'Configurações salvas com sucesso!',
      ));
      // Retorna ao estado loaded após sucesso
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(event.configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao salvar configurações: $e'));
    }
  }

  /// Restaura as configurações para valores padrão
  Future<void> _onRestaurarPadrao(
    RestaurarPadraoEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    emit(const ConfiguracoesLoading());
    try {
      await _manager.restaurarPadrao();
      final configuracao = _manager.configuracao;
      emit(ConfiguracoesSuccess(
        configuracao,
        'Configurações restauradas para padrão!',
      ));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao restaurar configurações: $e'));
    }
  }

  /// Realiza backup dos dados do sistema
  Future<void> _onRealizarBackup(
    RealizarBackupEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ConfiguracoesLoaded) return;

    emit(const ConfiguracoesLoading());
    try {
      final sucesso = await _manager.realizarBackup();
      if (sucesso) {
        emit(ConfiguracoesSuccess(
          currentState.configuracao,
          'Backup realizado com sucesso!',
        ));
      } else {
        emit(const ConfiguracoesError('Erro ao realizar backup'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao realizar backup: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    }
  }

  /// Limpa logs antigos baseado na configuração
  Future<void> _onLimparLogsAntigos(
    LimparLogsAntigosEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ConfiguracoesLoaded) return;

    emit(const ConfiguracoesLoading());
    try {
      final sucesso = await _manager.limparLogsAntigos();
      if (sucesso) {
        emit(ConfiguracoesSuccess(
          currentState.configuracao,
          'Logs antigos removidos com sucesso!',
        ));
      } else {
        emit(const ConfiguracoesError('Erro ao remover logs'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao limpar logs: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    }
  }

  /// Limpa todos os dados do sistema
  Future<void> _onLimparTodosDados(
    LimparTodosDadosEvent event,
    Emitter<ConfiguracoesState> emit,
  ) async {
    final currentState = state;
    if (currentState is! ConfiguracoesLoaded) return;

    emit(const ConfiguracoesLoading());
    try {
      final sucesso = await _manager.limparTodosDados();
      if (sucesso) {
        emit(ConfiguracoesSuccess(
          currentState.configuracao,
          'Todos os dados foram removidos!',
        ));
      } else {
        emit(const ConfiguracoesError('Erro ao remover dados'));
      }
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    } catch (e) {
      emit(ConfiguracoesError('Erro ao limpar dados: $e'));
      await Future.delayed(const Duration(milliseconds: 500));
      emit(ConfiguracoesLoaded(currentState.configuracao));
    }
  }
}
