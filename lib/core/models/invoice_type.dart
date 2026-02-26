/// Tipo de nota fiscal: entrada (compra/fornecedor) ou saída (venda/cliente).
enum InvoiceType {
  /// Nota de entrada: vinculada a uma empresa fornecedora.
  entry,

  /// Nota de saída: vinculada a um cliente.
  exit,
}
