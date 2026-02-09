import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final ISystemRepository _systemRepository;
  SystemConfigCubit(this._systemRepository) : super(Initial()) {
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
