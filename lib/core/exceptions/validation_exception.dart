/// Exceção lançada quando há falha na validação de dados.
///
/// Esta classe representa erros de validação de campos de entrada,
/// fornecendo mensagens detalhadas sobre o que falhou e como corrigir.
class ValidationException implements Exception {
  /// Mensagem principal descrevendo o erro de validação
  final String message;
  
  /// Campo que falhou na validação (opcional)
  final String? field;
  
  /// Sugestão de como corrigir o erro (opcional)
  final String? suggestion;
  
  /// Valor inválido que causou o erro (opcional)
  final dynamic invalidValue;

  /// Cria uma nova exceção de validação.
  ///
  /// Parâmetros:
  /// - [message]: Mensagem descrevendo o erro
  /// - [field]: Nome do campo que falhou (opcional)
  /// - [suggestion]: Sugestão de correção (opcional)
  /// - [invalidValue]: Valor que causou o erro (opcional)
  const ValidationException(
    this.message, {
    this.field,
    this.suggestion,
    this.invalidValue,
  });

  @override
  String toString() {
    final buffer = StringBuffer('ValidationException: $message');
    
    if (field != null) {
      buffer.write(' (campo: $field)');
    }
    
    if (invalidValue != null) {
      buffer.write(' [valor: $invalidValue]');
    }
    
    if (suggestion != null) {
      buffer.write('\nSugestão: $suggestion');
    }
    
    return buffer.toString();
  }

  /// Retorna uma mensagem formatada para exibição ao usuário.
  String get userMessage {
    final buffer = StringBuffer(message);
    
    if (suggestion != null) {
      buffer.write('\n\n💡 $suggestion');
    }
    
    return buffer.toString();
  }
}
