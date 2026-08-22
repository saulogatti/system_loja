import 'package:system_loja/data/cache/cache_manager.dart' show CacheManager;

/// Exceção base das falhas de cache em arquivo JSON.
///
/// {@category dados}
/// {@subCategory Sistema}
class CacheException implements Exception {

  /// Cria uma nova instância de [CacheException].
  ///
  /// [message] descreve o erro que ocorreu.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheException(this.message, [this.cause]);
  /// Mensagem descritiva do erro ocorrido.
  final String message;

  /// Exceção original que causou este erro, se houver.
  final Object? cause;

  @override
  String toString() {
    if (cause != null) {
      return 'CacheException: $message\nCausa: $cause';
    }
    return 'CacheException: $message';
  }
}

/// Exceção lançada quando o cache ainda não foi inicializado.
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Disparada se uma operação ocorre antes do [CacheManager] estar pronto.
class CacheNotInitializedException extends CacheException {
  /// Cria uma nova instância de [CacheNotInitializedException].
  const CacheNotInitializedException()
    : super('O cache não foi inicializado. Aguarde a inicialização.');
}

/// Exceção lançada quando a chave não existe no cache.
///
/// {@category dados}
/// {@subCategory Sistema}
class CacheKeyNotFoundException extends CacheException {

  /// Cria uma nova instância de [CacheKeyNotFoundException].
  ///
  /// [key] é a chave que não foi encontrada no cache.
  const CacheKeyNotFoundException(this.key)
    : super('Chave não encontrada no cache: $key');
  /// A chave que não foi encontrada.
  final String key;
}

/// Exceção lançada quando a leitura do arquivo de cache falha.
///
/// {@category dados}
/// {@subCategory Sistema}
class CacheReadException extends CacheException {
  /// Cria uma nova instância de [CacheReadException].
  ///
  /// [message] descreve o erro de leitura.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheReadException(super.message, [super.cause]);
}

/// Exceção lançada quando a escrita no arquivo de cache falha.
///
/// {@category dados}
/// {@subCategory Sistema}
class CacheWriteException extends CacheException {
  /// Cria uma nova instância de [CacheWriteException].
  ///
  /// [message] descreve o erro de escrita.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheWriteException(super.message, [super.cause]);
}

/// Exceção lançada quando a serialização JSON do cache falha.
///
/// {@category dados}
/// {@subCategory Sistema}
class CacheSerializationException extends CacheException {
  /// Cria uma nova instância de [CacheSerializationException].
  ///
  /// [message] descreve o erro de serialização.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheSerializationException(super.message, [super.cause]);
}
