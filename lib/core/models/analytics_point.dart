import 'package:meta/meta.dart';

/// Ponto de dados para gráficos de analytics de vendas e compras.
///
/// Representa um agrupamento (por data ou por produto) com os totais
/// de vendas, compras e quantidade de produtos movimentados.
@immutable
class AnalyticsPoint {

  const AnalyticsPoint({
    required this.label,
    required this.salesValue,
    required this.purchaseValue,
    required this.productsCount,
  });
  /// Rótulo do agrupamento (ex.: '10/03' ou nome do produto).
  final String label;

  /// Valor total de vendas (notas de saída) no agrupamento.
  final double salesValue;

  /// Valor total de compras (notas de entrada) no agrupamento.
  final double purchaseValue;

  /// Quantidade total de produtos movimentados no agrupamento.
  final int productsCount;
}
