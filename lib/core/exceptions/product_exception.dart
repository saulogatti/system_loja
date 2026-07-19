/// Exceção lançada quando há erros relacionados a produtos.
///
/// Esta classe representa erros específicos de operações com produtos,
/// como duplicação de código, produto não encontrado, etc.
class ProductException implements Exception {

  /// Cria uma nova exceção de produto.
  ///
  /// Parâmetros:
  /// - [type]: Tipo do erro
  /// - [message]: Mensagem descrevendo o erro
  /// - [details]: Detalhes adicionais (opcional)
  /// - [productCode]: Código do produto (opcional)
  const ProductException({
    required this.type,
    required this.message,
    this.details,
    this.productCode,
  });

  /// Cria uma exceção para código duplicado.
  factory ProductException.duplicateCode(String code) => ProductException(
      type: ProductErrorType.duplicateCode,
      message: 'Código de produto já existe',
      details: 'Um produto com o código "$code" já está cadastrado no sistema.',
      productCode: code,
    );

  /// Cria uma exceção para produto não encontrado.
  factory ProductException.notFound(String code) => ProductException(
      type: ProductErrorType.notFound,
      message: 'Produto não encontrado',
      details: 'Não foi possível encontrar um produto com o código "$code".',
      productCode: code,
    );

  /// Cria uma exceção para estoque insuficiente.
  factory ProductException.insufficientStock(
    String code,
    int available,
    int requested,
  ) => ProductException(
      type: ProductErrorType.insufficientStock,
      message: 'Estoque insuficiente',
      details:
          'Estoque disponível: $available. Quantidade solicitada: $requested.',
      productCode: code,
    );

  /// Cria uma exceção para preço inválido.
  factory ProductException.invalidPrice(String code, double price) => ProductException(
      type: ProductErrorType.invalidPrice,
      message: 'Preço inválido',
      details:
          'O preço R\$ ${price.toStringAsFixed(2)} não é válido. '
          'O preço deve ser maior ou igual a zero.',
      productCode: code,
    );

  /// Cria uma exceção para estoque inválido.
  factory ProductException.invalidStock(String code, int stock) => ProductException(
      type: ProductErrorType.invalidStock,
      message: 'Estoque inválido',
      details:
          'O estoque $stock não é válido. '
          'O estoque deve ser maior ou igual a zero.',
      productCode: code,
    );
  /// Tipo de erro de produto
  final ProductErrorType type;

  /// Mensagem descrevendo o erro
  final String message;

  /// Detalhes adicionais sobre o erro (opcional)
  final String? details;

  /// Código do produto relacionado ao erro (opcional)
  final String? productCode;

  @override
  String toString() {
    final buffer = StringBuffer('ProductException [${type.name}]: $message');

    if (productCode != null) {
      buffer.write(' (código: $productCode)');
    }

    if (details != null) {
      buffer.write('\nDetalhes: $details');
    }

    return buffer.toString();
  }

  /// Retorna uma mensagem formatada para exibição ao usuário.
  String get userMessage {
    final buffer = StringBuffer(message);

    if (details != null) {
      buffer.write('\n\nDetalhes: $details');
    }

    return buffer.toString();
  }
}

/// Tipos de erros relacionados a produtos.
enum ProductErrorType {
  /// Código de produto duplicado
  duplicateCode,

  /// Produto não encontrado
  notFound,

  /// Estoque insuficiente
  insufficientStock,

  /// Preço inválido (negativo)
  invalidPrice,

  /// Estoque inválido (negativo)
  invalidStock,

  /// Erro genérico de banco de dados
  databaseError,

  /// Erro desconhecido
  unknown,
}
