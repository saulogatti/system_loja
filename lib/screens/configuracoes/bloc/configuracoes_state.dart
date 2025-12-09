import 'package:equatable/equatable.dart';
import 'package:system_loja/core/models/configuracao.dart';

/// Estados do BLoC de Configurações
abstract class ConfiguracoesState extends Equatable {
  const ConfiguracoesState();

  @override
  List<Object?> get props => [];
}

/// Estado inicial - carregando configurações
class ConfiguracoesInitial extends ConfiguracoesState {
  const ConfiguracoesInitial();
}

/// Estado de carregamento
class ConfiguracoesLoading extends ConfiguracoesState {
  const ConfiguracoesLoading();
}

/// Estado com configurações carregadas
class ConfiguracoesLoaded extends ConfiguracoesState {
  /// Configurações atuais do sistema
  final Configuracao configuracao;

  const ConfiguracoesLoaded(this.configuracao);

  @override
  List<Object?> get props => [configuracao];
}

/// Estado de erro
class ConfiguracoesError extends ConfiguracoesState {
  /// Mensagem de erro ocorrida
  final String mensagem;

  const ConfiguracoesError(this.mensagem);

  @override
  List<Object?> get props => [mensagem];
}

/// Estado de sucesso em operação
class ConfiguracoesSuccess extends ConfiguracoesState {
  /// Configurações atuais
  final Configuracao configuracao;
  
  /// Mensagem de sucesso da operação
  final String mensagem;

  const ConfiguracoesSuccess(this.configuracao, this.mensagem);

  @override
  List<Object?> get props => [configuracao, mensagem];
}
