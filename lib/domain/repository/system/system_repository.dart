import 'dart:convert';

import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';
import 'package:system_loja/core/models/system_config/system_configuration.dart';
import 'package:system_loja/core/models/system_config/system_user_data.dart';
import 'package:system_loja/core/services/selector_file_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/repository_error_mapper.dart';
import 'package:system_loja/data/converter/system_configuration_codec.dart';
import 'package:system_loja/data/database/dao/system_dao.dart';

/// Repositório para gerenciamento da configuração técnica do sistema usando Drift.
///
/// Persiste e recupera [SystemConfiguration] via [SystemDao], incluindo
/// métodos de pagamento, unidades de medida e dados do usuário do sistema.
/// Todos os erros são capturados internamente e devolvidos como
/// [ResultStatus.error] com mensagem amigável.
///
/// Veja também:
/// - [ISystemRepository] - contrato da interface
/// - [SystemDao] - DAO do Drift
class SystemRepository implements ISystemRepository {
  final SystemDao _systemDao;
  SystemRepository({required SystemDao systemDao}) : _systemDao = systemDao;

  @override
  Future<ResultStatus<SystemConfiguration, String>>
  exportConfigurationToJson() async {
    try {
      final systemConfiguration = await getSystemConfiguration();
      if (systemConfiguration.hasError) {
        return ResultStatus.error(systemConfiguration.asError);
      }
      await SelectorFileService().saveSystemConfiguration(
        systemConfiguration.asSuccess,
      );
      return ResultStatus.success(systemConfiguration.asSuccess);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(
          e,
          contexto: 'Falha ao exportar configuração para o arquivo selecionado',
        ),
      );
    }
  }

  @override
  Future<ResultStatus<SystemConfiguration, String>>
  getSystemConfiguration() async {
    try {
      SystemConfiguration? systemConfiguration = await _systemDao
          .getSystemConfiguration();
      if (systemConfiguration == null) {
        systemConfiguration = _createDefaultConfiguration();
        await _systemDao.saveSystemConfiguration(systemConfiguration);
      }
      return ResultStatus.success(systemConfiguration);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(
          e,
          contexto: 'Falha ao obter configuração do sistema',
        ),
      );
    }
  }

  @override
  Future<ResultStatus<SystemConfiguration, String>>
  importConfigurationFromJson() async {
    try {
      final jsonContent = await SelectorFileService().getSystemConfiguration();
      if (jsonContent == null) {
        return ResultStatus.error('');
      }
      final dataMap = jsonDecode(jsonContent) as Map<String, dynamic>;
      final importedData = SystemConfigurationCodec.fromJson(dataMap);

      final validationError = _validateConfigurationData(
        paymentMethods: importedData.priceConfiguration.types,
        measurementUnits: importedData.priceConfiguration.measurementUnits,
        reportConfiguration:
            importedData.priceConfiguration.reportConfiguration,
      );
      if (validationError != null) {
        return ResultStatus.error(validationError);
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
      return ResultStatus.success(normalizedData);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao importar configuração'),
      );
    }
  }

  @override
  Future<ResultStatus<SystemConfiguration, String>>
  resetToDefaultConfiguration() async {
    try {
      final defaultConfiguration = _createDefaultConfiguration();
      await _systemDao.saveSystemConfiguration(defaultConfiguration);
      return ResultStatus.success(defaultConfiguration);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(
          e,
          contexto: 'Falha ao restaurar configuração padrão',
        ),
      );
    }
  }

  @override
  Future<ResultStatus<bool, String>> saveSystemConfiguration(
    SystemConfiguration data,
  ) async {
    try {
      await _systemDao.saveSystemConfiguration(data);
      return ResultStatus.success(true);
    } catch (e) {
      return ResultStatus.error(
        mensagemErroRepositorio(e, contexto: 'Falha ao salvar configuração'),
      );
    }
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
