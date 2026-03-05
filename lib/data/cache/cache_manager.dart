import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:path/path.dart' as p;
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';
import 'package:system_loja/data/files_utility/file_storage_utility.dart';

/// Tipo de função factory para criar instâncias de [Cacheable] a partir de JSON.
///
/// Esta função é usada pelo [CacheManager] para deserializar objetos
/// armazenados em cache de volta para seus tipos originais.
typedef CacheableFactory<T extends Cacheable> =
    T Function(Map<String, dynamic> json);

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
class CacheManager with FileStorageUtility, LoggerClassMixin {
  /// Instância única do [CacheManager].
  static final CacheManager instance = CacheManager._privateConstructor();

  /// Cache em memória para acesso rápido.
  ///
  /// Organizado por tipo (nome da classe) e depois por chave do objeto.
  final Map<String, Map<String, Map<String, dynamic>>> _memoryCache = {};

  final Lock _memoryLock = Lock();

  final Map<String, Lock> _fileLocks = {};

  /// Construtor privado para implementar o padrão singleton.
  ///
  /// Inicializa o sistema de arquivos através do [FileStorageUtility]
  /// chamando [_initializeDirectory] para preparar o ambiente de cache.
  CacheManager._privateConstructor();

  /// Limpa todo o cache da aplicação.
  ///
  /// Remove todos os objetos de todos os tipos, tanto da memória
  /// quanto dos arquivos de cache. Itera sobre todos os arquivos `.json`
  /// no diretório de cache e os remove.
  ///
  /// **Nota**: Implementação atual usa acesso direto ao diretório e
  /// deve ser refatorada para usar [FileStorageUtility].
  ///
  /// Lança [CacheWriteException] se ocorrer um erro ao limpar.
  ///
  /// Exemplo:
  /// ```dart
  /// await cache.clearAll();
  /// ```
  Future<void> clearAll() async {
    try {
      await _memoryLock.synchronized(_memoryCache.clear);
      await deleteDirectory();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao limpar todo o cache', e);
    }
  }

  /// Realiza backup dos dados do sistema
  ///
  /// Cria uma cópia dos arquivos JSON em um diretório de backup
  /// com timestamp.
  Future<bool> createBackup(String localBackup) async {
    try {
      final arquivosCopiados = await backup(localBackup);
      // Lista de arquivos para backup

      logInfo(
        'Backup realizado com sucesso: $arquivosCopiados arquivos copiados',
      );
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return false;
    }
  }

  /// Recupera um objeto do cache pela sua chave.
  ///
  /// [key] é a chave única do objeto no cache.
  /// [factory] é a função que converte o JSON de volta para o objeto [T].
  ///
  /// O método primeiro busca em memória. Se não encontrar, carrega do arquivo
  /// (lazy loading) e busca novamente. Retorna o objeto deserializado se
  /// encontrado, ou `null` se não existir no cache.
  ///
  /// Lança [CacheSerializationException] se houver erro na deserialização.
  ///
  /// Exemplo:
  /// ```dart
  /// final cliente = await cache.get<Cliente>('cliente_1', Cliente.fromJson);
  /// if (cliente != null) {
  ///   // Usar objeto
  /// }
  /// ```
  Future<T?> get<T extends Cacheable>(
    String key,
    CacheableFactory<T> factory,
  ) async {
    assert(key.isNotEmpty, 'A chave de cache não pode ser vazia');

    final type = _findType<T>();

    try {
      await _loadTypeCache(type);

      final cachedAfterLoad = await _memoryLock.synchronized(() {
        final entries = _memoryCache[type];
        if (entries != null && entries.containsKey(key)) {
          return Map<String, dynamic>.from(entries[key]!);
        }
        return null;
      });

      if (cachedAfterLoad != null) {
        return factory(cachedAfterLoad);
      }

      return null;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheSerializationException(
        'Falha ao deserializar objeto do cache: $key',
        e,
      );
    }
  }

  /// Recupera todos os objetos de um tipo específico do cache.
  ///
  /// [factory] é a função que converte o JSON de volta para o objeto.
  /// [T] é o tipo de objeto a ser recuperado.
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
  Future<List<T>> getAll<T extends Cacheable>(
    CacheableFactory<T> factory,
  ) async {
    final type = _findType<T>();

    try {
      // Carrega do arquivo se necessário
      await _loadTypeCache(type);

      final entries = await _memoryLock.synchronized(() {
        final stored = _memoryCache[type];
        if (stored == null) return null;
        return stored.map(
          (key, value) => MapEntry(key, Map<String, dynamic>.from(value)),
        );
      });

      if (entries == null) {
        return [];
      }

      return entries.values.map((json) => factory(json)).toList();
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheSerializationException(
        'Falha ao deserializar objetos do cache do tipo: $type',
        e,
      );
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
    unawaited(_memoryLock.synchronized(_memoryCache.clear));
  }

  Map<String, dynamic> parseData(String dataString) {
    return Map<String, dynamic>.from(jsonDecode(dataString));
  }

  /// Remove um objeto do cache pela sua chave.
  ///
  /// [key] é a chave única do objeto a ser removido.
  /// [T] é o      do tipo do objeto.
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
  Future<bool> remove<T extends Cacheable>(String key) async {
    final type = _findType<T>();

    try {
      // Carrega do arquivo se necessário
      await _loadTypeCache(type);

      var removed = false;
      await _memoryLock.synchronized(() {
        if (_memoryCache.containsKey(type) &&
            _memoryCache[type]!.containsKey(key)) {
          _memoryCache[type]!.remove(key);
          removed = true;
        }
      });

      if (!removed) {
        return false;
      }

      await _saveTypeCache(type);

      return true;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao remover item do cache: $key', e);
    }
  }

  Future<void> restoreBackupFrom(String direBackup) async {
    try {
      await restoreBackup(direBackup);
      logInfo('Restauração de backup realizada com sucesso');
    } catch (e, stackTrace) {
      logError('Erro ao restaurar backup: $e', stackTrace);
      throw CacheReadException('Erro ao restaurar backup', e);
    }
  }

  /// Retorna o nome do diretório do sistema de cache.
  ///
  /// Este método sobrescreve o comportamento do [FileStorageUtility]
  /// para definir o nome do diretório onde os arquivos de cache serão
  /// armazenados dentro do diretório de suporte da aplicação.
  @override
  String retrieveDirectoryName() {
    return 'system_loja_cache';
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
  Future<void> set(Cacheable item) async {
    final type = item.runtimeType.toString();
    final key = item.cacheKey;
    assert(key.isNotEmpty, 'A chave de cache não pode ser vazia');
    try {
      await _memoryLock.synchronized(() {
        _memoryCache[type] ??= {};
        _memoryCache[type]![key] = item.toJson();
      });

      // Persiste no arquivo
      await _saveTypeCache(type);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException('Falha ao armazenar item no cache: $key', e);
    }
  }

  /// Armazena múltiplos objetos [Cacheable] no cache de uma vez.
  ///
  /// [items] é a lista de objetos a serem armazenados.
  ///
  /// Este método é significativamente mais eficiente que chamar [set]
  /// múltiplas vezes, pois realiza apenas uma operação de escrita no arquivo
  /// ao final, em vez de escrever após cada item. Todos os itens devem ser
  /// do mesmo tipo (determinado pelo primeiro item da lista).
  ///
  /// Se a lista estiver vazia, retorna imediatamente sem fazer nada.
  ///
  /// Lança [CacheWriteException] se ocorrer um erro ao salvar.
  ///
  /// Exemplo:
  /// ```dart
  /// await cache.setAll([cliente1, cliente2, cliente3]);
  /// ```
  Future<void> setAll(List<Cacheable> items) async {
    if (items.isEmpty) return;

    final type = items.first.runtimeType.toString();

    try {
      await _memoryLock.synchronized(() {
        _memoryCache[type] ??= {};

        for (final item in items) {
          _memoryCache[type]![item.cacheKey] = item.toJson();
        }
      });

      await _saveTypeCache(type);
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheWriteException(
        'Falha ao armazenar múltiplos itens no cache',
        e,
      );
    }
  }

  /// Encontra o nome do tipo para operações de cache.
  ///
  /// Usa o tipo genérico [T] para obter o nome da classe através de
  /// [toString]. Este nome é usado como chave para organizar objetos
  /// no cache em memória e determinar o nome do arquivo de persistência.
  ///
  /// Retorna o nome do tipo como uma string (ex: 'Cliente', 'Produto').
  String _findType<T extends Cacheable>() {
    final type = T.toString();
    assert(type != 'Cacheable', 'O tipo genérico T deve ser específico');
    return type;
  }

  /// Retorna o caminho relativo do arquivo de cache para um tipo específico.
  ///
  /// [typeName] é o nome do tipo de objeto (geralmente o nome da classe).
  /// O caminho é relativo ao diretório de cache gerenciado pelo [FileStorageUtility].
  ///
  /// Retorna um caminho no formato: `${typeName.toLowerCase()}.json`
  String _getCacheFilePath(String typeName) {
    return p.setExtension(typeName.toLowerCase(), '.json');
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock(String dataFile) {
    return _fileLocks.putIfAbsent(dataFile, Lock.new);
  }

  /// Carrega os dados do cache de um tipo específico do arquivo para memória.
  ///
  /// [type] é o nome do tipo a ser carregado.
  ///
  /// Se os dados já estão em memória, retorna imediatamente sem carregar do disco.
  /// Caso contrário, lê o arquivo JSON correspondente usando [fetchDataFromFile] e
  /// popula o cache em memória.
  ///
  /// Lança [CacheReadException] em caso de erro ao ler ou parsear o arquivo.
  Future<void> _loadTypeCache(String type) async {
    await _memoryLock.synchronized(() {
      if (_memoryCache.containsKey(type)) {
        return;
      }
      _memoryCache[type] = {};
    });

    final filePath = _getCacheFilePath(type);
    final lock = _getLock(filePath);

    String? dataString;

    await lock.synchronized(() async {
      final result = await fetchDataFromFile(filePath);
      if (result.isSuccessful) {
        dataString = result.asSuccess;
      }
    });

    if (dataString == null) {
      return;
    }

    try {
      final Map<String, dynamic> jsonData = parseData(dataString!);
      final loadedData = jsonData.map(
        (key, value) => MapEntry(
          key,
          Map<String, dynamic>.from(value as Map<String, dynamic>),
        ),
      );
      await _memoryLock.synchronized(() {
        _memoryCache[type] = loadedData;
      });
    } catch (e, stackTrace) {
      logError('Erro ao carregar cache do tipo $type: $e', stackTrace);
      throw CacheReadException('Erro ao carregar cache do tipo $type', e);
    }
  }

  /// Salva os dados do cache de um tipo específico do memória para arquivo.
  ///
  /// [type] é o nome do tipo a ser salvo.
  ///
  /// Persiste todos os objetos do tipo especificado que estão em memória
  /// no arquivo JSON correspondente usando [saveData]. Se não houver
  /// dados em memória para o tipo, retorna sem fazer nada.
  ///
  /// Lança [CacheWriteException] em caso de erro ao escrever no arquivo.
  Future<void> _saveTypeCache(String type) async {
    String? snapshot;

    await _memoryLock.synchronized(() {
      final entries = _memoryCache[type];
      if (entries == null || entries.isEmpty) {
        return;
      }
      snapshot = jsonEncode(entries);
    });

    if (snapshot == null) {
      return;
    }

    final filePath = _getCacheFilePath(type);
    final lock = _getLock(filePath);

    await lock.synchronized(() async {
      try {
        final isSaveSuccessful = await saveData(filePath, snapshot!);
        if (!isSaveSuccessful) {
          throw CacheWriteException(
            'Falha ao salvar dados no arquivo de cache: $filePath',
          );
        }
      } on FileSystemException catch (e) {
        throw CacheWriteException(
          'Erro ao escrever arquivo de cache: $filePath',
          e,
        );
      }
    });
  }
}
