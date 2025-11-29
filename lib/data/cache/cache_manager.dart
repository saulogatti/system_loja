import 'dart:async';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';
import 'package:system_loja/data/files_system/file_system_manager.dart';

/// Tipo de função factory para criar instâncias de [Cacheable] a partir de JSON.
///
/// Esta função é usada pelo [CacheManager] para deserializar objetos
/// armazenados em cache de volta para seus tipos originais.
typedef CacheableFactory<T extends Cacheable> = T Function(Map<String, dynamic> json);

/// Gerencia o cache de dados da aplicação.
///
/// Utiliza o padrão singleton para garantir uma única instância
/// de [CacheManager] durante o ciclo de vida da aplicação.
///
/// O cache é persistido em arquivos JSON no diretório de documentos
/// da aplicação, organizados por tipo de objeto.
///
/// Exemplo de uso:
/// ```dart
/// final cache = CacheManager.instance;
/// await cache.ensureInitialized();
///
/// // Armazenar um objeto
/// await cache.set(meuObjeto);
///
/// // Recuperar um objeto
/// final objeto = await cache.get<MinhaClasse>('chave', MinhaClasse.fromJson);
/// ```
class CacheManager with LoggerClassMixin {
  /// Instância única do [CacheManager].
  static final CacheManager instance = CacheManager._privateConstructor();

  /// Diretório onde os arquivos de cache são armazenados.
  String _cacheDirectory = '';

  /// Indica se o cache foi inicializado com sucesso.
  Future<Directory>? _initialized;

  /// Cache em memória para acesso rápido.
  ///
  /// Organizado por tipo (nome da classe) e depois por chave do objeto.
  final Map<String, Map<String, Map<String, dynamic>>> _memoryCache = {};

  /// Construtor privado para implementar o padrão singleton.
  CacheManager._privateConstructor() {
    ensureInitialized();
  }

  /// Retorna o diretório de cache atual.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  String get cacheDirectory {
    _ensureInitialized();
    return _cacheDirectory;
  }

  /// Limpa todo o cache da aplicação.
  ///
  /// Remove todos os objetos de todos os tipos, tanto da memória
  /// quanto dos arquivos de cache.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheWriteException] se ocorrer um erro ao limpar.
  ///
  /// Exemplo:
  /// ```dart
  /// await cache.clearAll();
  /// ```
  Future<void> clearAll() async {
    _ensureInitialized();

    try {
      _memoryCache.clear();

      final cacheDir = Directory(_cacheDirectory);
      if (await cacheDir.exists()) {
        await for (final entity in cacheDir.list()) {
          if (entity is File && entity.path.endsWith('.json')) {
            await entity.delete();
          }
        }
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao limpar todo o cache', e);
    }
  }

  /// Limpa todos os objetos de um tipo específico do cache.
  ///
  /// [typeName] é o nome do tipo a ser limpo.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheWriteException] se ocorrer um erro ao limpar.
  ///
  /// Exemplo:
  /// ```dart
  /// await cache.clearType<Cliente>();
  /// ```
  Future<void> clearType<T extends Cacheable>({String? typeName}) async {
    String type = _findType<T>(typeName);

    try {
      _memoryCache.remove(type);

      final file = File(_getCacheFilePath(type));
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao limpar cache do tipo: $type', e);
    }
  }

  /// Verifica se uma chave existe no cache.
  ///
  /// [key] é a chave única do objeto.
  /// [typeName] é o nome do tipo do objeto.
  ///
  /// Retorna `true` se a chave existe, `false` caso contrário.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  ///
  /// Exemplo:
  /// ```dart
  /// if (await cache.containsKey<Cliente>('cliente_1')) {
  ///   // Objeto existe no cache
  /// }
  /// ```
  Future<bool> containsKey<T extends Cacheable>(String key, {String? typeName}) async {
    assert(key.isNotEmpty, 'A chave de cache não pode ser vazia');

    final type = _findType<T>(typeName);

    try {
      // Carrega do arquivo se necessário
      await _loadTypeCache(type);

      return _memoryCache.containsKey(type) && _memoryCache[type]!.containsKey(key);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheReadException('Falha ao verificar chave no cache: $key', e);
    }
  }

  /// Retorna o número de objetos de um tipo específico no cache.
  ///
  /// [typeName] é o nome do tipo.
  ///
  /// Retorna o número de objetos, ou 0 se o tipo não existir.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  ///
  /// Exemplo:
  /// ```dart
  /// final count = await cache.count<Cliente>();
  /// ```
  Future<int> count<T extends Cacheable>({String? typeName}) async {
    final type = _findType<T>(typeName);

    try {
      await _loadTypeCache(type);
      return _memoryCache[type]?.length ?? 0;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheReadException('Falha ao contar itens do cache: $type', e);
    }
  }

  /// Inicializa o cache de forma assíncrona.
  ///
  /// Este método deve ser chamado antes de qualquer operação de cache.
  /// É seguro chamar este método múltiplas vezes, pois ele só inicializa
  /// uma vez.
  ///
  /// Lança [CacheException] se ocorrer um erro durante a inicialização.
  Future<void> ensureInitialized() async {
    if (_initialized != null) {
      //FIXME: Trocar para usar um completer
      await _initialized;
      return;
    }

    try {
      _initialized = getApplicationSupportDirectory();
      final directory = await _initialized!;
      _cacheDirectory = p.join(directory.path, 'system_loja_cache');
      final cacheDir = Directory(_cacheDirectory);

      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }
    } catch (e) {
      throw CacheException('Falha ao inicializar o diretório de cache', e);
    }
  }

  /// Recupera um objeto do cache pela sua chave.
  ///
  /// [key] é a chave única do objeto no cache.
  /// [factory] é a função que converte o JSON de volta para o objeto.
  /// [typeName] é o nome do tipo (opcional).
  ///
  /// Retorna o objeto se encontrado, ou `null` se não existir no cache.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheSerializationException] se houver erro na deserialização.
  ///
  /// Exemplo:
  /// ```dart
  /// final cliente = await cache.get<Cliente>('cliente_1', Cliente.fromJson);
  /// ```
  Future<T?> get<T extends Cacheable>(String key, CacheableFactory<T> factory, {String? typeName}) async {
    assert(key.isNotEmpty, 'A chave de cache não pode ser vazia');

    final type = _findType<T>(typeName);

    try {
      // Tenta buscar do cache em memória primeiro
      if (_memoryCache.containsKey(type) && _memoryCache[type]!.containsKey(key)) {
        return factory(_memoryCache[type]![key]!);
      }

      // Se não está em memória, tenta carregar do arquivo
      await _loadTypeCache(type);

      if (_memoryCache.containsKey(type) && _memoryCache[type]!.containsKey(key)) {
        return factory(_memoryCache[type]![key]!);
      }

      return null;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheSerializationException('Falha ao deserializar objeto do cache: $key', e);
    }
  }

  /// Recupera todos os objetos de um tipo específico do cache.
  ///
  /// [factory] é a função que converte o JSON de volta para o objeto.
  /// [typeName] é o nome do tipo (opcional).
  ///
  /// Retorna uma lista com todos os objetos do tipo especificado.
  /// Retorna uma lista vazia se não houver objetos no cache.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheSerializationException] se houver erro na deserialização.
  ///
  /// Exemplo:
  /// ```dart
  /// final clientes = await cache.getAll<Cliente>(Cliente.fromJson);
  /// ```
  Future<List<T>> getAll<T extends Cacheable>(CacheableFactory<T> factory, {String? typeName}) async {
    final type = _findType<T>(typeName);

    try {
      // Carrega do arquivo se necessário
      await _loadTypeCache(type);

      if (!_memoryCache.containsKey(type)) {
        return [];
      }

      return _memoryCache[type]!.values.map((json) => factory(json)).toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheSerializationException('Falha ao deserializar objetos do cache do tipo: $type', e);
    }
  }

  /// Invalida todo o cache em memória.
  ///
  /// Isso força o [CacheManager] a recarregar os dados dos arquivos
  /// nas próximas leituras.
  ///
  /// Exemplo:
  /// ```dart
  /// cache.invalidateAllMemoryCache();
  /// ```
  void invalidateAllMemoryCache() {
    _ensureInitialized();
    _memoryCache.clear();
  }

  /// Invalida o cache em memória para um tipo específico.
  ///
  /// Isso força o [CacheManager] a recarregar os dados do arquivo
  /// na próxima leitura.
  ///
  /// [typeName] é o nome do tipo a ser invalidado.
  ///
  /// Exemplo:
  /// ```dart
  /// cache.invalidateMemoryCache<Cliente>();
  /// ```
  void invalidateMemoryCache<T extends Cacheable>({String? typeName}) {
    final type = _findType<T>(typeName);
    _memoryCache.remove(type);
  }

  /// Retorna todas as chaves de um tipo específico no cache.
  ///
  /// [typeName] é o nome do tipo.
  ///
  /// Retorna um conjunto com todas as chaves.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  ///
  /// Exemplo:
  /// ```dart
  /// final keys = await cache.keys<Cliente>();
  /// ```
  Future<Set<String>> keys<T extends Cacheable>({String? typeName}) async {
    final type = _findType<T>(typeName);

    try {
      await _loadTypeCache(type);
      return _memoryCache[type]?.keys.toSet() ?? {};
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheReadException('Falha ao obter chaves do cache: $type', e);
    }
  }

  /// Remove um objeto do cache pela sua chave.
  ///
  /// [key] é a chave única do objeto a ser removido.
  /// [typeName] é o nome do tipo do objeto.
  ///
  /// Retorna `true` se o objeto foi removido, `false` se não existia.
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheWriteException] se ocorrer um erro ao salvar.
  ///
  /// Exemplo:
  /// ```dart
  /// final removido = await cache.remove<Cliente>('cliente_1');
  /// ```
  Future<bool> remove<T extends Cacheable>(String key, {String? typeName}) async {
    final type = _findType<T>(typeName);

    try {
      // Carrega do arquivo se necessário
      await _loadTypeCache(type);

      if (!_memoryCache.containsKey(type) || !_memoryCache[type]!.containsKey(key)) {
        return false;
      }

      _memoryCache[type]!.remove(key);
      await _saveTypeCache(type);

      return true;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao remover item do cache: $key', e);
    }
  }

  /// Armazena um objeto [Cacheable] no cache.
  ///
  /// O objeto será persistido tanto em memória quanto em arquivo.
  ///
  /// [item] é o objeto a ser armazenado.
  /// [typeName] é o nome do tipo (opcional, usa o nome da classe por padrão).
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheWriteException] se ocorrer um erro ao salvar no arquivo.
  ///
  /// Exemplo:
  /// ```dart
  /// await cache.set(meuCliente);
  /// ```
  Future<void> set(Cacheable item, {String? typeName}) async {
    _ensureInitialized();

    final type = typeName ?? item.runtimeType.toString();
    final key = item.cacheKey;
    assert(key.isNotEmpty, 'A chave de cache não pode ser vazia');
    try {
      // Atualiza cache em memória
      _memoryCache[type] ??= {};
      _memoryCache[type]![key] = item.toJson();

      // Persiste no arquivo
      await _saveTypeCache(type);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao armazenar item no cache: $key', e);
    }
  }

  /// Armazena múltiplos objetos [Cacheable] no cache de uma vez.
  ///
  /// Este método é mais eficiente que chamar [set] múltiplas vezes,
  /// pois realiza apenas uma operação de escrita no arquivo.
  ///
  /// [items] é a lista de objetos a serem armazenados.
  /// [typeName] é o nome do tipo (opcional).
  ///
  /// Lança [CacheNotInitializedException] se o cache não estiver inicializado.
  /// Lança [CacheWriteException] se ocorrer um erro ao salvar.
  Future<void> setAll(List<Cacheable> items, {String? typeName}) async {
    _ensureInitialized();

    if (items.isEmpty) return;

    final type = typeName ?? items.first.runtimeType.toString();

    try {
      _memoryCache[type] ??= {};

      for (final item in items) {
        _memoryCache[type]![item.cacheKey] = item.toJson();
      }

      await _saveTypeCache(type);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao armazenar múltiplos itens no cache', e);
    }
  }

  /// Verifica se o cache está inicializado.
  ///
  /// Lança [CacheNotInitializedException] se não estiver.
  void _ensureInitialized() {
    if (_initialized == null) {
      throw const CacheNotInitializedException();
    }
  }

  /// Encontra o nome do tipo para operações de cache.
  ///
  /// [typeName] é o nome do tipo fornecido opcionalmente.
  /// Se não for fornecido, usa o nome da classe genérica [T].
  ///
  /// Retorna o nome do tipo como uma string.
  String _findType<T extends Cacheable>(String? typeName) {
    _ensureInitialized();

    final type = typeName ?? T.toString();
    return type;
  }

  /// Retorna o caminho do arquivo de cache para um tipo específico.
  ///
  /// [typeName] é o nome do tipo de objeto (geralmente o nome da classe).
  String _getCacheFilePath(String typeName) {
    return p.join(_cacheDirectory, '${typeName.toLowerCase()}.json');
  }

  /// Carrega os dados do cache de um tipo específico do arquivo.
  ///
  /// [type] é o nome do tipo a ser carregado.
  Future<void> _loadTypeCache(String type) async {
    // Se já está em memória, não precisa carregar
    if (_memoryCache.containsKey(type)) return;
    _memoryCache[type] ??= {};
    try {
      final Map<String, dynamic> jsonData = FileSystemManager().loadJsonFromFile<Map<String, dynamic>>(
        _getCacheFilePath(type),
      );

      _memoryCache[type] = jsonData.map(
        (key, value) => MapEntry(key, Map<String, dynamic>.from(value as Map)),
      );
    } catch (e, stackTrace) {
      logError('Erro ao carregar cache do tipo $type: $e', stackTrace);
    }
  }

  /// Salva os dados do cache de um tipo específico no arquivo.
  ///
  /// [type] é o nome do tipo a ser salvo.
  Future<void> _saveTypeCache(String type) async {
    if (!_memoryCache.containsKey(type)) return;

    try {
      String filePath = _getCacheFilePath(type);

      final isSaveSuccessful = FileSystemManager().saveJsonToFile(filePath, _memoryCache[type]!);
      if (isSaveSuccessful == false) {
        throw CacheWriteException('Falha ao salvar dados no arquivo de cache: $filePath');
      }
    } on FileSystemException catch (e) {
      throw CacheWriteException('Erro ao escrever arquivo de cache: $type', e);
    }
  }
}
