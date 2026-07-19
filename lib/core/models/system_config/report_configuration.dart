import 'package:system_loja/core/models/default/default_object.dart';

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
