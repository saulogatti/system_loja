import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

/// Formas de pagamento aceitas na configuração de preços.
enum PaymentMethodType { cash, card, pix, other }

/// Entidade de domínio para regras de preço, unidades de medida e relatórios.
///
/// A serialização (JSON, Drift) fica na camada de dados; o core permanece
/// independente de `json_annotation` e de geradores de código.
class PriceConfiguration extends DefaultObject {
  List<PaymentMethodType> types = [];
  List<String> measurementUnits = [];
  ReportConfiguration reportConfiguration;

  PriceConfiguration({
    required this.types,
    List<String>? measurementUnits,
    ReportConfiguration? reportConfiguration,
    super.lastUpdatedDate,
    super.registrationDate,
    int? id,
  }) : measurementUnits = measurementUnits ?? [],
       reportConfiguration = reportConfiguration ?? ReportConfiguration();
}
