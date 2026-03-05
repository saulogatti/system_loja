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

  SystemConfigCubit(this._systemRepository) : super(SystemConfigState.initial()) {
    loadConfigurationData();
  }

  SystemConfiguration? get _currentConfiguration {
    final currentState = state;
    if (currentState is SystemConfigStateLoaded) {
      return currentState.data;
    }
    return null;
  }

  Future<void> exportConfiguration() async {
    final data = _currentConfiguration;
    if (data == null) {
      emit(SystemConfigState.error('Nenhuma configuração carregada para exportar.'));
      return;
    }

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
      await file.writeAsString(jsonEncode(data.toJson()), flush: true);

      emit(
        SystemConfigState.loaded(
          data,
          feedbackMessage: 'Configuração exportada com sucesso.',
          feedbackType: SystemConfigFeedbackType.exported,
        ),
      );
    } catch (e) {
      emit(SystemConfigState.error('Erro ao exportar configuração: $e'));
    }
  }

  Future<void> importConfiguration() async {
    final baseConfig = _currentConfiguration;

    try {
      const acceptedTypes = <XTypeGroup>[
        XTypeGroup(label: 'json', extensions: ['json']),
      ];
      final file = await openFile(acceptedTypeGroups: acceptedTypes);

      if (file == null) {
        return;
      }

      final content = await file.readAsString();
      final Map<String, dynamic> dataMap = jsonDecode(content) as Map<String, dynamic>;
      final importedData = SystemConfiguration.fromJson(dataMap);

      final validationError = _validateConfigurationData(
        paymentMethods: importedData.priceConfiguration.types,
        measurementUnits: importedData.priceConfiguration.measurementUnits,
        reportConfiguration: importedData.priceConfiguration.reportConfiguration,
      );

      if (validationError != null) {
        emit(SystemConfigState.error(validationError));
        return;
      }

      final normalizedData = SystemConfiguration(
        id: baseConfig?.id ?? importedData.id,
        registrationDate: baseConfig?.registrationDate ?? importedData.registrationDate,
        lastUpdatedDate: DateTime.now(),
        productCategories: baseConfig?.productCategories ?? importedData.productCategories,
        priceConfiguration: PriceConfiguration(
          types: importedData.priceConfiguration.types.toSet().toList(),
          measurementUnits: _normalizeUnits(importedData.priceConfiguration.measurementUnits),
          reportConfiguration: importedData.priceConfiguration.reportConfiguration,
        ),
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
      if (configData != null) {
        emit(SystemConfigState.loaded(configData));
      } else {
        final defaultConfig = _createDefaultConfiguration();
        await _systemRepository.saveSystemConfiguration(defaultConfig);
        emit(
          SystemConfigState.loaded(
            defaultConfig,
            feedbackMessage: 'Configuração padrão criada. Você já pode personalizá-la.',
          ),
        );
      }
    } catch (e) {
      emit(SystemConfigState.error(e.toString()));
    }
  }

  Future<void> resetToDefaultConfiguration() async {
    emit(SystemConfigState.loading());
    final defaultData = _createDefaultConfiguration();

    try {
      await _systemRepository.saveSystemConfiguration(defaultData);
      emit(
        SystemConfigState.loaded(
          defaultData,
          feedbackMessage: 'Configurações restauradas para os valores padrão do sistema.',
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
    final baseConfig = _currentConfiguration ?? _createDefaultConfiguration();

    final data = SystemConfiguration(
      id: baseConfig.id,
      registrationDate: baseConfig.registrationDate,
      lastUpdatedDate: DateTime.now(),
      productCategories: List<String>.from(baseConfig.productCategories),
      priceConfiguration: PriceConfiguration(
        types: paymentMethods.toSet().toList(),
        measurementUnits: normalizedUnits,
        reportConfiguration: reportConfiguration,
      ),
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

  SystemConfiguration _createDefaultConfiguration() {
    return SystemConfiguration(
      id: 1,
      priceConfiguration: PriceConfiguration(
        types: const [PaymentMethodType.cash, PaymentMethodType.pix],
        measurementUnits: const ['UN', 'KG'],
        reportConfiguration: ReportConfiguration(),
      ),
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
