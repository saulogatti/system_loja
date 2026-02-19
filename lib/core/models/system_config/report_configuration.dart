import 'package:json_annotation/json_annotation.dart';

part 'report_configuration.g.dart';

/// Define os parâmetros técnicos dos relatórios gerenciais.
@JsonSerializable()
class ReportConfiguration {
  bool enableSalesByPeriod;
  bool enableTopProducts;
  int defaultPeriodInDays;

  ReportConfiguration({
    this.enableSalesByPeriod = true,
    this.enableTopProducts = true,
    this.defaultPeriodInDays = 30,
  });

  factory ReportConfiguration.fromJson(Map<String, dynamic> json) => _$ReportConfigurationFromJson(json);

  Map<String, dynamic> toJson() => _$ReportConfigurationToJson(this);
}
