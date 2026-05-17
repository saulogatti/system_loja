import 'package:system_loja/core/models/analytics_point.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Contrato para recuperação de dados agregados de vendas e compras.
///
/// Define métodos que retornam listas de [AnalyticsPoint] agrupados
/// por data ou por produto, prontos para exibição em gráficos.
abstract interface class IAnalyticsRepository {
  /// Retorna pontos de analytics agrupados por data de emissão.
  ///
  /// Cada ponto representa um dia com totais de vendas, compras e
  /// quantidade de produtos movimentados naquela data.
  Future<ResultStatus<List<AnalyticsPoint>, String>> getAnalyticsByDate();

  /// Retorna pontos de analytics agrupados por produto.
  ///
  /// Cada ponto representa um produto com totais de vendas, compras e
  /// quantidade total movimentada (soma das quantidades dos itens).
  Future<ResultStatus<List<AnalyticsPoint>, String>> getAnalyticsByProduct();
}
