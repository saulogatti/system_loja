import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final ISystemRepository _systemRepository;

  SystemConfigCubit(this._systemRepository)
    : super(SystemConfigState.initial()) {
    loadConfigurationData();
  }

  Future<SystemConfiguration> get _currentConfiguration async {
    final currentState = state;
    if (currentState is SystemConfigStateLoaded) {
      return currentState.data;
    }
    return await _systemRepository.getSystemConfiguration();
  }

  Future<void> exportConfiguration() async {
    final systemConfiguration = await _currentConfiguration;
    //TODO migrar para o repository
    try {
      const acceptedTypes = <XTypeGroup>[
        XTypeGroup(label: 'json', extensions: ['json']),
      ];
      final location = await getSaveLocation(
        suggestedName: 'system_configuration.json',
        acceptedTypeGroups: acceptedTypes,
      );

      if (location == null) {
        return;
      }

      final file = File(location.path);
      await file.writeAsString(jsonEncode(systemConfiguration), flush: true);

      emit(
        SystemConfigState.loaded(
          systemConfiguration,
          feedbackMessage: 'Configuração exportada com sucesso.',
          feedbackType: SystemConfigFeedbackType.exported,
        ),
      );
    } catch (e) {
      emit(SystemConfigState.error('Erro ao exportar configuração: $e'));
    }
  }

  //FIXME: migrar para o repository
  Future<void> importConfiguration() async {
    try {
      const acceptedTypes = <XTypeGroup>[
        XTypeGroup(label: 'json', extensions: ['json']),
      ];
      final file = await openFile(acceptedTypeGroups: acceptedTypes);

      if (file == null) {
        return;
      }

      final content = await file.readAsString();
      final Map<String, dynamic> dataMap = Map.from(jsonDecode(content));
      final importedData = SystemConfiguration();

      final validationError = _validateConfigurationData(
        paymentMethods: importedData.priceConfiguration.types,
        measurementUnits: importedData.priceConfiguration.measurementUnits,
        reportConfiguration:
            importedData.priceConfiguration.reportConfiguration,
      );

      if (validationError != null) {
        emit(SystemConfigState.error(validationError));
        return;
      }

      final normalizedData = SystemConfiguration(
        id: importedData.id,
        registrationDate: importedData.registrationDate,
        lastUpdatedDate: DateTime.now(),
        productCategories: importedData.productCategories,
        priceConfiguration: PriceConfiguration(
          types: importedData.priceConfiguration.types.toSet().toList(),
          measurementUnits: _normalizeUnits(
            importedData.priceConfiguration.measurementUnits,
          ),
          reportConfiguration:
              importedData.priceConfiguration.reportConfiguration,
        ),
        systemUserData: importedData.systemUserData,
      );

      await _systemRepository.saveSystemConfiguration(normalizedData);
      emit(
        SystemConfigState.loaded(
          normalizedData,
          feedbackMessage: 'Configuração importada com sucesso.',
          feedbackType: SystemConfigFeedbackType.imported,
        ),
      );
    } catch (e) {
      emit(SystemConfigState.error('Erro ao importar configuração: $e'));
    }
  }

  Future<void> loadConfigurationData() async {
    emit(SystemConfigState.loading());
    try {
      final configData = await _systemRepository.getSystemConfiguration();
      emit(SystemConfigState.loaded(configData));
    } catch (e) {
      emit(SystemConfigState.error(e.toString()));
    }
  }

  Future<void> resetToDefaultConfiguration() async {
    emit(SystemConfigState.loading());

    try {
      final defaultConfiguration = await _systemRepository
          .resetToDefaultConfiguration();
      emit(
        SystemConfigState.loaded(
          defaultConfiguration,
          feedbackMessage:
              'Configurações restauradas para os valores padrão do sistema.',
          feedbackType: SystemConfigFeedbackType.reset,
        ),
      );
    } catch (e) {
      emit(SystemConfigState.error(e.toString()));
    }
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
    final systemConfiguration = await _currentConfiguration;

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

    try {
      await _systemRepository.saveSystemConfiguration(data);
      emit(
        SystemConfigState.loaded(
          data,
          feedbackMessage: 'Configurações salvas com sucesso.',
          feedbackType: SystemConfigFeedbackType.saved,
        ),
      );
    } catch (e) {
      emit(SystemConfigState.error(e.toString()));
    }
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
