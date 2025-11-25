/// Exceção base para erros relacionados ao cache.
///
/// Esta classe serve como base para todas as exceções que podem
/// ocorrer durante operações de cache, como leitura, escrita e
/// remoção de dados.
class CacheException implements Exception {
  /// Mensagem descritiva do erro ocorrido.
  final String message;

  /// Exceção original que causou este erro, se houver.
  final Object? cause;

  /// Cria uma nova instância de [CacheException].
  ///
  /// [message] descreve o erro que ocorreu.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheException(this.message, [this.cause]);

  @override
  String toString() {
    if (cause != null) {
      return 'CacheException: $message\nCausa: $cause';
    }
    return 'CacheException: $message';
  }
}

/// Exceção lançada quando o cache não está inicializado.
///
/// Esta exceção é lançada quando uma operação de cache é tentada
/// antes que o [CacheManager] tenha sido completamente inicializado.
class CacheNotInitializedException extends CacheException {
  /// Cria uma nova instância de [CacheNotInitializedException].
  const CacheNotInitializedException()
      : super('O cache não foi inicializado. Aguarde a inicialização.');
}

/// Exceção lançada quando uma chave não é encontrada no cache.
///
/// Esta exceção é lançada quando se tenta recuperar um item
/// do cache usando uma chave que não existe.
class CacheKeyNotFoundException extends CacheException {
  /// A chave que não foi encontrada.
  final String key;

  /// Cria uma nova instância de [CacheKeyNotFoundException].
  ///
  /// [key] é a chave que não foi encontrada no cache.
  CacheKeyNotFoundException(this.key)
      : super('Chave não encontrada no cache: $key');
}

/// Exceção lançada quando ocorre um erro de leitura do cache.
///
/// Esta exceção é lançada quando há uma falha ao ler dados
/// do arquivo de cache no sistema de arquivos.
class CacheReadException extends CacheException {
  /// Cria uma nova instância de [CacheReadException].
  ///
  /// [message] descreve o erro de leitura.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheReadException(super.message, [super.cause]);
}

/// Exceção lançada quando ocorre um erro de escrita no cache.
///
/// Esta exceção é lançada quando há uma falha ao escrever dados
/// no arquivo de cache no sistema de arquivos.
class CacheWriteException extends CacheException {
  /// Cria uma nova instância de [CacheWriteException].
  ///
  /// [message] descreve o erro de escrita.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheWriteException(super.message, [super.cause]);
}

/// Exceção lançada quando ocorre um erro de serialização/deserialização.
///
/// Esta exceção é lançada quando há uma falha ao converter dados
/// entre objetos Dart e formato JSON.
class CacheSerializationException extends CacheException {
  /// Cria uma nova instância de [CacheSerializationException].
  ///
  /// [message] descreve o erro de serialização.
  /// [cause] é a exceção original que causou este erro (opcional).
  const CacheSerializationException(super.message, [super.cause]);
}
