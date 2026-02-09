import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/configuration_data_state.dart';

class ConfigurationDataCubit extends Cubit<ConfigurationDataState> {
  final ISystemRepository _systemRepository;
  ConfigurationDataCubit(this._systemRepository) : super(Initial()) {
    loadConfigurationData();
  }
  
  Future<void> loadConfigurationData() async {
    final configData = await _systemRepository.getSystemConfiguration();
    if (configData != null) {
      emit(Loaded(configData));
    }
  }
  Future<void> saveConfigurationData(SystemConfiguration data) async {
    await _systemRepository.saveSystemConfiguration(data);
    emit(Loaded(data));
  }
}
