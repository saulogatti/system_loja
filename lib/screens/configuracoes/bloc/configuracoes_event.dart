import 'package:equatable/equatable.dart';
import 'package:system_loja/core/models/configuracao.dart';

/// Eventos do BLoC de Configurações
abstract class ConfiguracoesEvent extends Equatable {
  const ConfiguracoesEvent();

  @override
  List<Object?> get props => [];
}

/// Evento para carregar as configurações iniciais
class CarregarConfiguracoesEvent extends ConfiguracoesEvent {
  const CarregarConfiguracoesEvent();
}

/// Evento para atualizar as configurações
class AtualizarConfiguracoesEvent extends ConfiguracoesEvent {
  /// Nova configuração a ser aplicada
  final Configuracao configuracao;

  const AtualizarConfiguracoesEvent(this.configuracao);

  @override
  List<Object?> get props => [configuracao];
}

/// Evento para restaurar configurações padrão
class RestaurarPadraoEvent extends ConfiguracoesEvent {
  const RestaurarPadraoEvent();
}

/// Evento para realizar backup dos dados
class RealizarBackupEvent extends ConfiguracoesEvent {
  const RealizarBackupEvent();
}

/// Evento para limpar logs antigos
class LimparLogsAntigosEvent extends ConfiguracoesEvent {
  const LimparLogsAntigosEvent();
}

/// Evento para limpar todos os dados do sistema
class LimparTodosDadosEvent extends ConfiguracoesEvent {
  const LimparTodosDadosEvent();
}
