import 'package:system_loja/core/models/default/default_object.dart';

/// Preferências de relatórios do sistema, como período e seções habilitadas.
///
/// {@category modelos}
/// {@subCategory Sistema}
class ReportConfiguration extends DefaultObject {

  ReportConfiguration({
    this.defaultPeriodInDays = 30,
    this.enableSalesByPeriod = true,
    this.enableTopProducts = true,
    super.id,
    super.registrationDate,
    super.lastUpdatedDate,
  });
  bool enableSalesByPeriod;
  bool enableTopProducts;
  int defaultPeriodInDays;
}
