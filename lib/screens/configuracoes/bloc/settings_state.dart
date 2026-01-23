import 'package:equatable/equatable.dart';
import 'package:system_loja/core/settings/app_settings.dart';

/// Estado de sucesso em operação
class SettingsConfirmedState extends SettingsState {
  /// Configurações atuais
  final AppSettings appSettings;

  /// Mensagem de sucesso da operação
  final String mensagem;

  const SettingsConfirmedState(this.appSettings, this.mensagem);

  @override
  List<Object?> get props => [appSettings, mensagem];
}

/// Estado de erro
class SettingsError extends SettingsState {
  /// Mensagem de erro ocorrida
  final String mensagem;

  const SettingsError(this.mensagem);

  @override
  List<Object?> get props => [mensagem];
}

/// Estado inicial - carregando configurações
class SettingsInitialState extends SettingsState {
  const SettingsInitialState();
}

/// Estado com configurações carregadas
class SettingsLoadedState extends SettingsState {
  /// Configurações atuais do sistema
  final AppSettings appSettings;

  const SettingsLoadedState(this.appSettings);

  @override
  List<Object?> get props => [appSettings];
}

/// Estado de carregamento
class SettingsLoadingState extends SettingsState {
  const SettingsLoadingState();
}

/// Estados do BLoC de Configurações
abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}
