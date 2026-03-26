/// Resumo consolidado de movimentacao de um produto.
class ProductMovementSummary {
  final int totalEntryQuantity;
  final int totalExitQuantity;
  final double totalEntryValue;
  final double totalExitValue;
  final int balanceQuantity;
  final double balanceValue;

  const ProductMovementSummary({
    required this.totalEntryQuantity,
    required this.totalExitQuantity,
    required this.totalEntryValue,
    required this.totalExitValue,
    required this.balanceQuantity,
    required this.balanceValue,
  });
}
