import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final ISystemRepository _systemRepository;
  SystemConfigCubit(this._systemRepository)
    : super(SystemConfigState.initial()) {
    loadConfigurationData();
  }

  Future<void> loadConfigurationData() async {
    final configData = await _systemRepository.getSystemConfiguration();
    if (configData != null) {
      emit(SystemConfigState.loaded(configData));
    }
  }

  Future<void> saveConfigurationData({
    required List<PaymentMethodType> paymentMethods,
  }) async {
    final data = SystemConfiguration(
      priceConfiguration: PriceConfiguration(types: paymentMethods),
    );
    await _systemRepository.saveSystemConfiguration(data);
    emit(SystemConfigState.loaded(data));
  }
}
