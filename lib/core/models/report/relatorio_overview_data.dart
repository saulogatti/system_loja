import 'package:system_loja/core/models/product.dart';

/// Dados consolidados de estoque para apresentação no relatório.
class RelatorioEstoqueOverviewData {

  const RelatorioEstoqueOverviewData({
    required this.totalProdutos,
    required this.produtosSemEstoque,
    required this.produtosComEstoqueBaixo,
    required this.produtosOrdenadosPorEstoque,
  });
  final int totalProdutos;
  final int produtosSemEstoque;
  final int produtosComEstoqueBaixo;
  final List<Product> produtosOrdenadosPorEstoque;
}

/// Dados consolidados de notas fiscais para apresentação no relatório.
class RelatorioNotasOverviewData {

  const RelatorioNotasOverviewData({
    required this.quantidadeEntradas,
    required this.quantidadeSaidas,
    required this.totalEntrada,
    required this.totalSaida,
  });
  final int quantidadeEntradas;
  final int quantidadeSaidas;
  final double totalEntrada;
  final double totalSaida;
}
