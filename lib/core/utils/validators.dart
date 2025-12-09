/// Utilitários de validação para formulários.
///
/// Contém validadores reutilizáveis para campos de entrada comuns
/// no sistema de gerenciamento de loja.
library validators;

/// Valida se um texto representa um preço válido.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
/// 
/// Validações aplicadas:
/// - Não pode ser vazio
/// - Deve ser um número válido
/// - Não pode ser negativo
/// - Máximo de 2 casas decimais
///
/// Exemplo:
/// ```dart
/// validator: validatePrice,
/// ```
String? validatePrice(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Preço é obrigatório';
  }

  // Substitui vírgula por ponto para parsing
  final normalizedValue = value.trim().replaceAll(',', '.');
  
  final price = double.tryParse(normalizedValue);
  
  if (price == null) {
    return 'Preço inválido. Use apenas números (ex: 10.50)';
  }
  
  if (price < 0) {
    return 'Preço não pode ser negativo';
  }
  
  // Verifica se tem mais de 2 casas decimais
  final parts = normalizedValue.split('.');
  if (parts.length > 1 && parts[1].length > 2) {
    return 'Preço deve ter no máximo 2 casas decimais';
  }
  
  return null;
}

/// Valida se um texto representa uma quantidade/estoque válido.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
///
/// Validações aplicadas:
/// - Não pode ser vazio
/// - Deve ser um número inteiro válido
/// - Não pode ser negativo
///
/// Exemplo:
/// ```dart
/// validator: validateQuantity,
/// ```
String? validateQuantity(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Quantidade é obrigatória';
  }

  final quantity = int.tryParse(value.trim());
  
  if (quantity == null) {
    return 'Quantidade inválida. Use apenas números inteiros';
  }
  
  if (quantity < 0) {
    return 'Quantidade não pode ser negativa';
  }
  
  return null;
}

/// Valida se um texto representa um estoque válido.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
///
/// Validações aplicadas:
/// - Não pode ser vazio
/// - Deve ser um número inteiro válido
/// - Não pode ser negativo
///
/// Exemplo:
/// ```dart
/// validator: validateStock,
/// ```
String? validateStock(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Estoque é obrigatório';
  }

  final stock = int.tryParse(value.trim());
  
  if (stock == null) {
    return 'Estoque inválido. Use apenas números inteiros';
  }
  
  if (stock < 0) {
    return 'Estoque não pode ser negativo';
  }
  
  return null;
}

/// Valida se um texto representa um código de produto válido.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
///
/// Validações aplicadas:
/// - Não pode ser vazio
/// - Deve conter apenas letras, números e hífens
/// - Mínimo de 3 caracteres
/// - Máximo de 20 caracteres
///
/// Exemplo:
/// ```dart
/// validator: validateProductCode,
/// ```
String? validateProductCode(String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'Código é obrigatório';
  }

  final code = value.trim();
  
  if (code.length < 3) {
    return 'Código deve ter no mínimo 3 caracteres';
  }
  
  if (code.length > 20) {
    return 'Código deve ter no máximo 20 caracteres';
  }
  
  // Permite apenas letras, números e hífens
  final validPattern = RegExp(r'^[a-zA-Z0-9\-]+$');
  if (!validPattern.hasMatch(code)) {
    return 'Código deve conter apenas letras, números e hífens';
  }
  
  return null;
}

/// Valida se um texto não está vazio.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
///
/// Parâmetros:
/// - [fieldName]: Nome do campo a ser exibido na mensagem de erro
///
/// Exemplo:
/// ```dart
/// validator: (value) => validateRequired(value, 'Nome'),
/// ```
String? validateRequired(String? value, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName é obrigatório';
  }
  return null;
}

/// Valida se um texto tem um comprimento mínimo.
///
/// Retorna `null` se o valor for válido, ou uma mensagem de erro caso contrário.
///
/// Parâmetros:
/// - [minLength]: Comprimento mínimo requerido
/// - [fieldName]: Nome do campo a ser exibido na mensagem de erro
///
/// Exemplo:
/// ```dart
/// validator: (value) => validateMinLength(value, 3, 'Nome'),
/// ```
String? validateMinLength(String? value, int minLength, String fieldName) {
  if (value == null || value.trim().isEmpty) {
    return '$fieldName é obrigatório';
  }
  
  if (value.trim().length < minLength) {
    return '$fieldName deve ter no mínimo $minLength caracteres';
  }
  
  return null;
}

/// Combina múltiplos validadores em um único.
///
/// Retorna a primeira mensagem de erro encontrada, ou `null` se todos
/// os validadores passarem.
///
/// Exemplo:
/// ```dart
/// validator: combineValidators([
///   (value) => validateRequired(value, 'Nome'),
///   (value) => validateMinLength(value, 3, 'Nome'),
/// ]),
/// ```
String? combineValidators(
  List<String? Function(String?)> validators,
) {
  return (String? value) {
    for (final validator in validators) {
      final error = validator(value);
      if (error != null) return error;
    }
    return null;
  };
}
