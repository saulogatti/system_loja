import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/system_config/report_configuration.dart';

/// Formas de pagamento aceitas na configuração de preços.
enum PaymentMethodType { cash, card, pix, other }

class PriceConfiguration extends DefaultObject {
  PriceConfiguration({
    required this.types,
    required this.measurementUnits,
    this.reportConfiguration,
    super.id,
    super.lastUpdatedDate,
    super.registrationDate,
  });
  List<PaymentMethodType> types;
  List<String> measurementUnits;
  ReportConfiguration? reportConfiguration;

  PriceConfiguration copyWith({
    List<PaymentMethodType>? types,
    List<String>? measurementUnits,
    ReportConfiguration? reportConfiguration,
  }) => PriceConfiguration(
      types: types ?? this.types,
      measurementUnits: measurementUnits ?? this.measurementUnits,
      reportConfiguration: reportConfiguration ?? this.reportConfiguration,
      id: id,
      lastUpdatedDate: lastUpdatedDate,
      registrationDate: registrationDate,
    );

  static PriceConfiguration defaultConfiguration() => PriceConfiguration(
      types: [],
      measurementUnits: [],
      reportConfiguration: ReportConfiguration(),
    );
}
