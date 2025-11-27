/// Define o objeto que pode ser armazenado em cache.
///
/// Esta interface define os métodos necessários para que um objeto
/// possa ser serializado e armazenado no sistema de cache da aplicação.
///
/// Exemplo de implementação:
/// ```dart
/// class MinhaClasse implements Cacheable {
///   @override
///   String get cacheKey => 'minha_classe_$id';
///
///   @override
///   Map<String, dynamic> toJson() => {'id': id};
/// }
/// ```
abstract class Cacheable {
  /// Retorna a chave única que identifica este objeto no cache.
  ///
  /// Esta chave deve ser única para cada instância do objeto
  /// e será usada para armazenar e recuperar o objeto do cache.
  String get cacheKey;

  /// Converte o objeto para um Map que pode ser serializado em JSON.
  ///
  /// Este método é utilizado pelo [CacheManager] para persistir
  /// o objeto em arquivo.
  Map<String, dynamic> toJson();
}
