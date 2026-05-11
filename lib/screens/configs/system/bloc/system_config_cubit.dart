import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configs/system/bloc/system_config_state.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final ISystemRepository _systemRepository;

  SystemConfigCubit(this._systemRepository)
    : super(SystemConfigState.initial()) {
    loadConfigurationData();
  }

  Future<void> exportConfiguration() async {
    final result = await _systemRepository.exportConfigurationToJson();
    result.when(
      onSuccess: (systemConfiguration) {
        emit(
          SystemConfigState.loaded(
            systemConfiguration,
            feedbackMessage: 'Configuração exportada com sucesso.',
            feedbackType: SystemConfigFeedbackType.exported,
          ),
        );
      },
      onError: (message) {
        emit(SystemConfigState.error(message));
      },
    );
  }

  Future<void> importConfiguration() async {
    final result = await _systemRepository.importConfigurationFromJson();

    result.when(
      onSuccess: (normalizedData) {
        emit(
          SystemConfigState.loaded(
            normalizedData,
            feedbackMessage: 'Configuração importada com sucesso.',
            feedbackType: SystemConfigFeedbackType.imported,
          ),
        );
      },
      onError: (message) {
        //Cancelado pelo usuário que não selecionou um arquivo
        if (message.isEmpty) {
          return;
        }
        emit(SystemConfigState.error(message));
      },
    );
  }

  Future<void> loadConfigurationData() async {
    emit(SystemConfigState.loading());
    final result = await _systemRepository.getSystemConfiguration();
    result.when(
      onSuccess: (configData) {
        emit(SystemConfigState.loaded(configData));
      },
      onError: (message) {
        emit(SystemConfigState.error(message));
      },
    );
  }

  Future<void> resetToDefaultConfiguration() async {
    emit(SystemConfigState.loading());

    final result = await _systemRepository.resetToDefaultConfiguration();
    result.when(
      onSuccess: (defaultConfiguration) {
        emit(
          SystemConfigState.loaded(
            defaultConfiguration,
            feedbackMessage:
                'Configurações restauradas para os valores padrão do sistema.',
            feedbackType: SystemConfigFeedbackType.reset,
          ),
        );
      },
      onError: (message) {
        emit(SystemConfigState.error(message));
      },
    );
  }

  Future<void> saveConfigurationData({
    required List<PaymentMethodType> paymentMethods,
    required List<String> measurementUnits,
    required ReportConfiguration reportConfiguration,
  }) async {
    final validationError = _validateConfigurationData(
      paymentMethods: paymentMethods,
      measurementUnits: measurementUnits,
      reportConfiguration: reportConfiguration,
    );
    if (validationError != null) {
      emit(SystemConfigState.error(validationError));
      return;
    }

    emit(SystemConfigState.loading());
    final normalizedUnits = _normalizeUnits(measurementUnits);
    final systemConfiguration = await _obterConfiguracaoAtual();
    if (systemConfiguration == null) {
      return;
    }

    final data = SystemConfiguration(
      id: systemConfiguration.id,
      registrationDate: systemConfiguration.registrationDate,
      lastUpdatedDate: DateTime.now(),
      productCategories: List<String>.from(
        systemConfiguration.productCategories,
      ),
      priceConfiguration: PriceConfiguration(
        types: paymentMethods.toSet().toList(),
        measurementUnits: normalizedUnits,
        reportConfiguration: reportConfiguration,
      ),
      systemUserData: systemConfiguration.systemUserData,
    );

    final saveResult = await _systemRepository.saveSystemConfiguration(data);
    saveResult.when(
      onSuccess: (_) {
        emit(
          SystemConfigState.loaded(
            data,
            feedbackMessage: 'Configurações salvas com sucesso.',
            feedbackType: SystemConfigFeedbackType.saved,
          ),
        );
      },
      onError: (message) {
        emit(SystemConfigState.error(message));
      },
    );
  }

  List<String> _normalizeUnits(List<String> measurementUnits) {
    final normalizedUnits = measurementUnits
        .map((unit) => unit.trim().toUpperCase())
        .where((unit) => unit.isNotEmpty)
        .toSet()
        .toList();
    normalizedUnits.sort();
    return normalizedUnits;
  }

  /// Configuração atual a partir do estado carregado ou do repositório.
  Future<SystemConfiguration?> _obterConfiguracaoAtual() async {
    final currentState = state;
    if (currentState is SystemConfigStateLoaded) {
      return currentState.data;
    }
    final result = await _systemRepository.getSystemConfiguration();
    if (result.isSuccessful) {
      return result.asSuccess;
    }
    emit(SystemConfigState.error(result.asError));
    return null;
  }

  String? _validateConfigurationData({
    required List<PaymentMethodType> paymentMethods,
    required List<String> measurementUnits,
    required ReportConfiguration reportConfiguration,
  }) {
    if (paymentMethods.isEmpty) {
      return 'Selecione pelo menos um tipo de pagamento.';
    }

    if (paymentMethods.toSet().length != paymentMethods.length) {
      return 'Existem tipos de pagamento duplicados na seleção.';
    }

    final normalizedUnits = _normalizeUnits(measurementUnits);
    if (normalizedUnits.isEmpty) {
      return 'Adicione pelo menos uma unidade de medida.';
    }

    if (reportConfiguration.defaultPeriodInDays <= 0) {
      return 'O período padrão de relatório deve ser maior que zero.';
    }

    return null;
  }
}
