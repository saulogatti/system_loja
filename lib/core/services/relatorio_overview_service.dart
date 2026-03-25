import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/report/relatorio_overview_data.dart';

/// Consolida métricas usadas pela tela de relatórios.
class RelatorioOverviewService {
  /// Calcula resumo de estoque e ordenação por quantidade.
  RelatorioEstoqueOverviewData buildEstoqueOverview(List<Product> products) {
    final produtosSemEstoque = products.where((p) => p.stockQuantity == 0).length;
    final produtosComEstoqueBaixo = products.where((p) => p.stockQuantity > 0 && p.stockQuantity <= 5).length;
    final produtosOrdenadosPorEstoque = List<Product>.from(products)
      ..sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));

    return RelatorioEstoqueOverviewData(
      totalProdutos: products.length,
      produtosSemEstoque: produtosSemEstoque,
      produtosComEstoqueBaixo: produtosComEstoqueBaixo,
      produtosOrdenadosPorEstoque: produtosOrdenadosPorEstoque,
    );
  }

  /// Calcula totais financeiros e quantidade de notas por tipo.
  RelatorioNotasOverviewData buildNotasOverview({
    required Map<int, Invoice> entryInvoices,
    required Map<int, Invoice> exitInvoices,
  }) {
    final totalEntrada = entryInvoices.values.fold<double>(0, (sum, inv) => sum + inv.data.totalValue);
    final totalSaida = exitInvoices.values.fold<double>(0, (sum, inv) => sum + inv.data.totalValue);

    return RelatorioNotasOverviewData(
      quantidadeEntradas: entryInvoices.length,
      quantidadeSaidas: exitInvoices.length,
      totalEntrada: totalEntrada,
      totalSaida: totalSaida,
    );
  }
}
