import 'package:system_loja/data/cache/cache_manager.dart' show CacheManager;

/// Contrato de objeto serializável no cache de arquivo JSON.
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Persistência principal é Drift; [Cacheable] só descreve chave e JSON
/// para o [CacheManager].
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
