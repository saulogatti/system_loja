import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/data/cache/models/cacheable.dart';

typedef CacheableFactory<T extends Cacheable> = T Function(Map<String, dynamic> json);

/// Gerencia o cache de dados da aplicação
/// Utiliza o padrão singleton para garantir uma única instância
/// de CacheManager durante o ciclo de vida da aplicação.
class CacheManager {
  static final CacheManager instance = CacheManager._privateConstructor();
  String _cacheDirectory = "";
  // singleton pattern
  CacheManager._privateConstructor() {
    // inicialização do cache
    _initializeCache();
  }

  void _initializeCache() async {
    if (_cacheDirectory.isEmpty) {
      final directory = await getApplicationDocumentsDirectory();
      _cacheDirectory = p.join(directory.path, 'cache');
      final cacheDir = Directory(_cacheDirectory);
      if (!await cacheDir.exists()) {
        await cacheDir.create(recursive: true);
      }
    }
  }

  //TODO: implementar métodos de leitura e escrita no cache para os objetos necessários
}
