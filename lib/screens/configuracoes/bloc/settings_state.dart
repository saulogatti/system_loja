import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/settings/app_settings.dart';

part 'settings_state.freezed.dart';

/// Estados do BLoC de Configurações
@freezed
sealed class SettingsState with _$SettingsState {

  const factory SettingsState.error(String mensagem) = SettingsError;
  const factory SettingsState.initial() = SettingsInitialState;
  const factory SettingsState.loaded(AppSettings appSettings, String mensagem) =
      SettingsLoadedState;
  const factory SettingsState.loading() = SettingsLoadingState;
}
