import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';

part 'system_config_state.freezed.dart';

enum SystemConfigFeedbackType { saved, reset, imported, exported }

@freezed
sealed class SystemConfigState with _$SystemConfigState {
  const factory SystemConfigState.error(String message) = SystemConfigStateError;
  const factory SystemConfigState.initial() = SystemConfigStateInitial;
  const factory SystemConfigState.loaded(
    SystemConfiguration data, {
    String? feedbackMessage,
    SystemConfigFeedbackType? feedbackType,
  }) = SystemConfigStateLoaded;
  const factory SystemConfigState.loading() = SystemConfigStateLoading;
}
