import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';

part 'system_config_state.freezed.dart';

@freezed
sealed class SystemConfigState with _$SystemConfigState {
  const factory SystemConfigState.initial() = SystemConfigStateInitial;
  const factory SystemConfigState.loaded(SystemConfiguration data) = SystemConfigStateLoaded;
  const factory SystemConfigState.error(String message) = SystemConfigStateError;
}
