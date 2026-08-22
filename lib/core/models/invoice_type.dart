/// Tipo de nota fiscal: entrada (compra) ou saída (venda).
///
/// {@category modelos}
/// {@subCategory Vendas}
enum InvoiceType {
  /// Nota de entrada: vinculada a uma empresa fornecedora.
  entry,

  /// Nota de saída: vinculada a um cliente.
  exit,
}
