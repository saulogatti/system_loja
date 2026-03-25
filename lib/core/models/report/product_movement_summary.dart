/// Resumo consolidado de movimentacao de um produto.
class ProductMovementSummary {
  final int totalEntradaQuantidade;
  final int totalSaidaQuantidade;
  final double totalEntradaValor;
  final double totalSaidaValor;
  final int saldoQuantidade;
  final double saldoValor;

  const ProductMovementSummary({
    required this.totalEntradaQuantidade,
    required this.totalSaidaQuantidade,
    required this.totalEntradaValor,
    required this.totalSaidaValor,
    required this.saldoQuantidade,
    required this.saldoValor,
  });
}
