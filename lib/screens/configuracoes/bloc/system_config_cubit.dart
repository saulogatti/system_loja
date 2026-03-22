import 'dart:convert';
import 'dart:io';

import 'package:file_selector/file_selector.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/configuracoes/bloc/system_config_state.dart';

class SystemConfigCubit extends Cubit<SystemConfigState> {
  final ISystemRepository _systemRepository;

  SystemConfigCubit(this._systemRepository)
    : super(SystemConfigState.initial()) {
    loadConfigurationData();
  }

  Future<ResultStatus<SystemConfiguration, String>>
  get _currentConfiguration async {
    final currentState = state;
    if (currentState is SystemConfigStateLoaded) {
      return ResultStatus.success(currentState.data);
    }
    return await _systemRepository.getSystemConfiguration();
  }

  Future<void> exportConfiguration() async {
    final configResult = await _currentConfiguration;
    switch (configResult) {
      case ResultSuccess(result: final systemConfiguration):
        // TODO migrar para o repository
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
          await file.writeAsString(
            jsonEncode(systemConfiguration),
            flush: true,
          );

          emit(
            SystemConfigState.loaded(
              systemConfiguration,
              feedbackMessage: 'Configuração exportada com sucesso.',
              feedbackType: SystemConfigFeedbackType.exported,
            ),
          );
        } catch (_) {
          emit(
            SystemConfigState.error(
              'Erro ao exportar configuração para o arquivo selecionado.',
            ),
          );
        }
      case ResultError(resultError: final errorMessage):
        emit(SystemConfigState.error(errorMessage));
    }
  }

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
      final result = await _systemRepository.importConfigurationFromJson(
        content,
      );
      switch (result) {
        case ResultSuccess(result: final normalizedData):
          emit(
            SystemConfigState.loaded(
              normalizedData,
              feedbackMessage: 'Configuração importada com sucesso.',
              feedbackType: SystemConfigFeedbackType.imported,
            ),
          );
        case ResultError(resultError: final errorMessage):
          emit(SystemConfigState.error(errorMessage));
      }
    } catch (_) {
      emit(
        SystemConfigState.error('Erro ao importar arquivo de configuração.'),
      );
    }
  }

  Future<void> loadConfigurationData() async {
    emit(SystemConfigState.loading());
    final result = await _systemRepository.getSystemConfiguration();
    switch (result) {
      case ResultSuccess(result: final configData):
        emit(SystemConfigState.loaded(configData));
      case ResultError(resultError: final errorMessage):
        emit(SystemConfigState.error(errorMessage));
    }
  }

  Future<void> resetToDefaultConfiguration() async {
    emit(SystemConfigState.loading());
    final result = await _systemRepository.resetToDefaultConfiguration();
    switch (result) {
      case ResultSuccess(result: final defaultConfiguration):
        emit(
          SystemConfigState.loaded(
            defaultConfiguration,
            feedbackMessage:
                'Configurações restauradas para os valores padrão do sistema.',
            feedbackType: SystemConfigFeedbackType.reset,
          ),
        );
      case ResultError(resultError: final errorMessage):
        emit(SystemConfigState.error(errorMessage));
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
    final currentConfigurationResult = await _currentConfiguration;
    if (currentConfigurationResult.hasError) {
      emit(SystemConfigState.error(currentConfigurationResult.asError));
      return;
    }
    final systemConfiguration = currentConfigurationResult.asSuccess;

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
    switch (saveResult) {
      case ResultSuccess():
        emit(
          SystemConfigState.loaded(
            data,
            feedbackMessage: 'Configurações salvas com sucesso.',
            feedbackType: SystemConfigFeedbackType.saved,
          ),
        );
      case ResultError(resultError: final errorMessage):
        emit(SystemConfigState.error(errorMessage));
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
