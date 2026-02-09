import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';

part 'configuration_data_state.freezed.dart';

@freezed
sealed class ConfigurationDataState with _$ConfigurationDataState {
  const factory ConfigurationDataState.initial() = Initial;
  const factory ConfigurationDataState.loaded(SystemConfiguration data) = Loaded;
}
