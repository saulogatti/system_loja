/// Resumo consolidado de movimentacao de um produto.
class ProductMovementSummary {

  const ProductMovementSummary({
    required this.totalEntryQuantity,
    required this.totalExitQuantity,
    required this.totalEntryValue,
    required this.totalExitValue,
    required this.balanceQuantity,
    required this.balanceValue,
  });
  final int totalEntryQuantity;
  final int totalExitQuantity;
  final double totalEntryValue;
  final double totalExitValue;
  final int balanceQuantity;
  final double balanceValue;
}
