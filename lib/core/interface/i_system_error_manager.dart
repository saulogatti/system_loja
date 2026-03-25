import 'package:system_loja/core/models/system_errors/system_error.dart';

/// Contrato para consulta e limpeza de erros sistêmicos em cache.
abstract interface class ISystemErrorManager {
  /// Remove todos os erros sistêmicos armazenados.
  Future<void> clearAllErrors();

  /// Retorna todos os erros sistêmicos armazenados.
  Future<List<SystemError>> getAllErrors();
}
