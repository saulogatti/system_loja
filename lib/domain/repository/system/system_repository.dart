import 'dart:convert';

import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';

class SystemRepository implements ISystemRepository {
  final SystemDao _systemDao;
  SystemRepository({required SystemDao systemDao}) : _systemDao = systemDao;
  @override
  Future<SystemConfiguration> getSystemConfiguration() async {
    SystemConfiguration? systemConfiguration = await _systemDao
        .getSystemConfiguration();
    if (systemConfiguration == null) {
      systemConfiguration = _createDefaultConfiguration();
      await _systemDao.saveSystemConfiguration(systemConfiguration);
    }
    return systemConfiguration;
  }

  @override
  Future<SystemConfiguration> importConfigurationFromJson(
    String jsonContent,
  ) async {
    final dataMap = jsonDecode(jsonContent) as Map<String, dynamic>;
    final importedData = SystemConfiguration.fromJson(dataMap);

    final validationError = _validateConfigurationData(
      paymentMethods: importedData.priceConfiguration.types,
      measurementUnits: importedData.priceConfiguration.measurementUnits,
      reportConfiguration: importedData.priceConfiguration.reportConfiguration,
    );
    if (validationError != null) {
      throw FormatException(validationError);
    }

    final normalizedData = SystemConfiguration(
      registrationDate: importedData.registrationDate,
      lastUpdatedDate: DateTime.now(),
      productCategories: List<String>.from(importedData.productCategories),
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

    await _systemDao.saveSystemConfiguration(normalizedData);
    return normalizedData;
  }

  @override
  Future<SystemConfiguration> resetToDefaultConfiguration() async {
    final defaultConfiguration = _createDefaultConfiguration();
    await _systemDao.saveSystemConfiguration(defaultConfiguration);
    return defaultConfiguration;
  }

  @override
  Future<void> saveSystemConfiguration(SystemConfiguration data) {
    return _systemDao.saveSystemConfiguration(data);
  }

  SystemConfiguration _createDefaultConfiguration() {
    return SystemConfiguration(
      priceConfiguration: PriceConfiguration(
        types: const [PaymentMethodType.cash, PaymentMethodType.pix],
        measurementUnits: const ['UN', 'KG'],
        reportConfiguration: ReportConfiguration(),
      ),
      systemUserData: SystemUserData.defaultObject(),
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
    required ReportConfiguration? reportConfiguration,
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
    if (reportConfiguration != null &&
        reportConfiguration.defaultPeriodInDays <= 0) {
      return 'O período padrão de relatório deve ser maior que zero.';
    }
    return null;
  }
}
