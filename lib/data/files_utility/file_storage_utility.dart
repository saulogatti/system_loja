import 'dart:io';

import 'package:async/async.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';

/// Gerenciador centralizado de operações de sistema de arquivos JSON.
///
/// Este mixin fornece funcionalidades de leitura e escrita de arquivos JSON
/// com cache automático no diretório de suporte da aplicação. Garante formatação
/// consistente (indentação de 2 espaços), validação de caminhos e inicialização
/// segura do sistema de arquivos.
///
/// Classes que utilizam este mixin devem implementar o método `logError`.
mixin FileStorageUtility {
  static const String _maskBackup = 'backup_';

  /// Memoizador para garantir inicialização única do diretório de cache.
  ///
  /// Armazena o resultado da primeira chamada a [_initializeDirectory] e
  /// reutiliza para chamadas subsequentes, evitando operações de I/O
  /// desnecessárias.
  final AsyncMemoizer<String> _asyncAccess = AsyncMemoizer<String>();

  /// Realiza backup de todos os dados do sistema.
  ///
  /// Copia todos os arquivos e diretórios do diretório de suporte da aplicação
  /// para um novo diretório de backup com timestamp. Ignora diretórios de backup
  /// existentes para evitar recursão.
  ///
  /// [localBackup] - Caminho opcional para o diretório de backup. Se vazio, usa o diretório padrão.
  /// [excludeDirectories] - Lista de nomes de diretórios a serem excluídos do backup.
  /// Use para excluir diretórios de banco de dados (ex: 'system_loja_database') que devem
  /// usar mecanismos transacionais próprios (VACUUM INTO, etc) para evitar backups corrompidos.
  ///
  /// Retorna o número de arquivos copiados com sucesso.
  /// Em caso de erro, registra via `logError` e retorna 0.
  Future<int> backup([
    String localBackup = '',
    List<String> excludeDirectories = const [],
  ]) async {
    try {
      // Obtém o diretório principal do app (não o subdiretório específico)
      final appDocDir = await getApplicationSupportDirectory();
      final timestamp = DateTime.now().millisecondsSinceEpoch;
      final backupDir = localBackup.isNotEmpty
          ? Directory(p.join(localBackup, '$_maskBackup$timestamp'))
          : Directory(p.join(appDocDir.path, '$_maskBackup$timestamp'));

      if (!await backupDir.exists()) {
        await backupDir.create(recursive: true);
      }

      var arquivosCopiados = 0;

      // Lista todos os itens no diretório principal do app
      await for (final entity in appDocDir.list()) {
        final basename = p.basename(entity.path);

        // Ignora diretórios de backup existentes para evitar recursão
        if (basename.startsWith(_maskBackup)) {
          continue;
        }

        // Ignora diretórios excluídos (ex: banco de dados SQLite/Drift)
        if (entity is Directory && excludeDirectories.contains(basename)) {
          logDebug(
            'Diretório "$basename" excluído do backup (requer mecanismo transacional)',
          );
          continue;
        }

        if (entity is File) {
          // Copia arquivos diretamente no diretório principal
          final nomeArquivo = basename;
          final destino = File(p.join(backupDir.path, nomeArquivo));
          await entity.copy(destino.path);
          arquivosCopiados++;
        } else if (entity is Directory) {
          // Copia diretórios recursivamente (ex: system_loja_cache)
          final nomeDiretorio = basename;
          final destinoDir = Directory(p.join(backupDir.path, nomeDiretorio));
          arquivosCopiados += await _copyDirectoryRecursively(
            entity,
            destinoDir,
          );
        }
      }

      logDebug(
        'Backup realizado com sucesso: $arquivosCopiados arquivos copiados',
      );
      return arquivosCopiados;
    } catch (e, stackTrace) {
      logError('Erro ao realizar backup: $e', stackTrace);
      return 0;
    }
  }

  /// Exclui todos os arquivos JSON do diretório de cache.
  ///
  /// Itera sobre todos os arquivos `.json` no diretório de cache e os remove.
  /// Se o diretório não existir, não faz nada. Erros durante a exclusão são
  /// registrados via `logError`, mas não lançam exceções.
  ///
  /// Este método é útil para limpar completamente o cache de dados persistidos.
  @protected
  Future<void> deleteDirectory() async {
    try {
      final cacheDir = Directory(await _initializeDirectory());
      if (await cacheDir.exists()) {
        await cacheDir.delete(recursive: true);
      }
    } catch (e, stackTrace) {
      logError('Erro ao deletar diretório de cache: $e', stackTrace);
    }
  }

  /// Exclui um arquivo específico do sistema de cache.
  ///
  /// Remove o arquivo localizado em [fileName] relativo ao diretório
  /// de cache da aplicação. O nome do arquivo deve incluir a extensão
  /// (ex: 'clientes.json', 'config.txt').
  ///
  /// Retorna `true` se o arquivo foi deletado com sucesso, `false`
  /// se o arquivo não existir ou ocorrer um erro durante a exclusão.
  /// Erros são registrados via `logError`.
  ///
  @protected
  Future<bool> deleteFile(String fileName) async {
    try {
      final File file = await _mountFileSystem(fileName);
      if (await file.exists()) {
        await file.delete();
        return true;
      }
      return false;
    } catch (e, stackTrace) {
      logError('Erro ao deletar arquivo $fileName: $e', stackTrace);
      return false;
    }
  }

  @protected
  Future<ResultStatus<List<String>, String>> fetchAllDataFiles() async {
    try {
      final cacheDir = Directory(await _initializeDirectory());
      if (!await cacheDir.exists()) {
        return ResultStatus.success([]);
      }

      final availableData = <String>[];
      await for (var entity in cacheDir.list()) {
        if (entity is File) {
          final data = await entity.readAsString();
          availableData.add(data);
        }
      }
      return ResultStatus.success(availableData);
    } catch (e, stackTrace) {
      logError('Erro ao listar arquivos no diretório de cache: $e', stackTrace);
      return ResultStatus.error('Erro ao listar arquivos: $e');
    }
  }

  /// Carrega o conteúdo de um arquivo de forma assíncrona.
  ///
  /// Lê o conteúdo do arquivo localizado em [fileName] relativo ao diretório
  /// de cache da aplicação e retorna como string. O nome do arquivo deve incluir
  /// a extensão (ex: 'clientes.json', 'config.txt').
  ///
  /// O método garante que o sistema de arquivos esteja inicializado antes
  /// de tentar ler o arquivo.
  ///
  /// Lança [ArgumentError] se [fileName] for vazio ou não contiver extensão.
  /// Registra erros via `logError` e relança exceções em caso de falhas de leitura.
  ///
  /// Exemplo:
  /// ```dart
  /// final content = await fetchDataFromFile('clientes.json');
  /// final data = jsonDecode(content);
  /// ```
  @protected
  Future<ResultStatus<String, String>> fetchDataFromFile(
    String fileName,
  ) async {
    if (fileName.isEmpty || p.extension(fileName).isEmpty) {
      throw ArgumentError(
        'O nome do arquivo não pode ser vazio e deve conter uma extensão (ex: .json, .txt)',
      );
    }

    final File file = await _mountFileSystem(fileName);
    if (!await file.exists()) {
      return ResultStatus.error('Arquivo $fileName não encontrado.');
    }
    try {
      final String content = await file.readAsString();

      return ResultStatus.success(content);
    } catch (e, stackTrace) {
      logError('Erro ao carregar arquivo JSON em $fileName: $e', stackTrace);
      return ResultStatus.error('Erro ao ler arquivo $fileName: $e');
    }
  }

  @protected
  @nonVirtual
  Future<String> getPathWithFileName(String fileName) async {
    final directoryPath = await _initializeDirectory();
    return p.join(directoryPath, fileName);
  }

  void logDebug(String message);

  /// Registra mensagens de erro com stack trace.
  ///
  /// Este método abstrato deve ser implementado pelas classes que usam
  /// este mixin, tipicamente usando `LoggerClassMixin` ou similar.
  void logError(String message, StackTrace stackTrace);

  /// Restaura dados de um backup existente.
  ///
  /// Precisa conter a máscara 'backup_' no nome do diretório. Um diretório válido.
  /// Diretorio de backup deve conter os arquivos copiados anteriormente e subdiretórios.
  /// Retorna o número de arquivos restaurados com sucesso.
  @protected
  Future<int> restoreBackup(String direBackup) async {
    try {
      if (direBackup.isEmpty) {
        throw CacheReadException('Caminho de backup não pode ser vazio', null);
      }
      if (!direBackup.contains(_maskBackup)) {
        throw CacheReadException(
          'Diretório de backup inválido: nome não contém a máscara '
          '"$_maskBackup"',
          null,
        );
      }
      final backupDir = Directory(direBackup);
      if (!await backupDir.exists()) {
        throw CacheReadException('Diretório de backup não encontrado', null);
      }

      final appDocDir = await getApplicationSupportDirectory();
      var arquivosRestaurados = 0;

      // Lista todos os itens no diretório de backup
      await for (final entity in backupDir.list()) {
        if (entity is File) {
          // Restaura arquivos diretamente no diretório principal
          final nomeArquivo = p.basename(entity.path);
          final destino = File(p.join(appDocDir.path, nomeArquivo));
          if (await destino.exists()) {
            logDebug('Restaurando arquivo ${entity.path} para ${destino.path}');
            await entity.rename('${destino.path}.bak');
          } else {
            await entity.copy(destino.path);
          }
          arquivosRestaurados++;
        } else if (entity is Directory) {
          // Restaura diretórios recursivamente
          final nomeDiretorio = p.basename(entity.path);
          final destinoDir = Directory(p.join(appDocDir.path, nomeDiretorio));
          arquivosRestaurados += await _copyDirectoryRecursively(
            entity,
            destinoDir,
          );
        }
      }

      logDebug(
        'Restauração de backup realizada com sucesso: $arquivosRestaurados arquivos restaurados',
      );
      return arquivosRestaurados;
    } catch (e, stackTrace) {
      logError('Erro ao restaurar backup: $e', stackTrace);
      throw CacheReadException('Erro ao restaurar backup', e);
    }
  }

  /// Retorna o nome do diretório de cache específico da aplicação.
  ///
  /// Este método abstrato deve ser implementado pelas classes que usam
  /// este mixin para definir o nome do diretório onde os arquivos serão
  /// armazenados dentro do diretório de suporte da aplicação.
  ///
  /// Exemplo de implementação:
  /// ```dart
  /// @override
  /// String systemNameDirectory() => 'system_loja_cache';
  /// ```
  @protected
  String retrieveDirectoryName();

  /// Salva dados em um arquivo de forma assíncrona.
  ///
  /// Persiste [data] no arquivo especificado em [path] relativo ao diretório
  /// de cache. Cria diretórios pai automaticamente se não existirem.
  /// O caminho deve incluir a extensão do arquivo (ex: 'clientes.json', 'config.txt').
  ///
  /// O método garante que o sistema de arquivos esteja inicializado antes
  /// de tentar salvar o arquivo.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  /// Lança [ArgumentError] se [path] for vazio ou não contiver extensão.
  /// Erros de I/O são registrados via `logError` e o método retorna `false`.
  ///
  /// Exemplo:
  /// ```dart
  /// final jsonString = jsonEncode(clientes);
  /// final success = await saveData('clientes.json', jsonString);
  /// ```
  @protected
  Future<bool> saveData(String path, String data) async {
    if (path.isEmpty || p.extension(path).isEmpty) {
      throw ArgumentError(
        'O caminho do arquivo não pode ser vazio e deve conter uma extensão (ex: .json, .txt)',
      );
    }

    try {
      final File file = await _mountFileSystem(path);
      if (!await file.parent.exists()) {
        await file.parent.create(recursive: true);
      }

      await file.writeAsString(data);
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao salvar arquivo JSON em $path: $e', stackTrace);
      return false;
    }
  }

  /// Copia um diretório recursivamente para o destino.
  ///
  /// [source] é o diretório de origem a ser copiado.
  /// [destination] é o diretório de destino onde os arquivos serão copiados.
  ///
  /// Retorna o número de arquivos copiados.
  Future<int> _copyDirectoryRecursively(
    Directory source,
    Directory destination,
  ) async {
    var filesCopied = 0;
    if (!await destination.exists()) {
      await destination.create(recursive: true);
    }

    await for (final entity in source.list()) {
      if (entity is File) {
        final nomeArquivo = p.basename(entity.path);
        final destino = File(p.join(destination.path, nomeArquivo));
        if (await destino.exists()) {
          logDebug('Copying file ${entity.path} to ${destino.path}');
          await destino.rename('${destino.path}.old');
        }
        await entity.copy(destino.path);
        filesCopied++;
      } else if (entity is Directory) {
        final nomeDiretorio = p.basename(entity.path);
        final destinoDir = Directory(p.join(destination.path, nomeDiretorio));
        filesCopied += await _copyDirectoryRecursively(entity, destinoDir);
      }
    }

    return filesCopied;
  }

  /// Inicializa o cache de forma assíncrona.
  ///
  /// Este método deve ser chamado antes de qualquer operação de cache.
  /// É seguro chamar este método múltiplas vezes, pois ele só inicializa
  /// uma vez.
  ///
  /// Lança [CacheException] se ocorrer um erro durante a inicialização.
  /// Obs: Este método é utilizado internamente pelo mixin. Deixar publico expoe o caminho do diretório. --- IGNORE ---
  Future<String> _initializeDirectory() async {
    if (_asyncAccess.hasRun) return _asyncAccess.future;
    return await _asyncAccess.runOnce(() async {
      try {
        //DEBUG ///Users/saulogatti-pessoal/Library/Containers/com.example.systemLoja/Data/Library/Application%20Support/com.example.systemLoja/json_data_storage/
        final directory = await getApplicationSupportDirectory();
        final String cacheDirectory = p.join(
          directory.path,
          retrieveDirectoryName(),
        );
        final cacheDir = Directory(cacheDirectory);

        if (!await cacheDir.exists()) {
          await cacheDir.create(recursive: true);
        }
        await for (final element in cacheDir.list()) {
          if (element is! File) continue;
          final String ext = p.extension(element.path).toLowerCase();
          if (ext == '.bak') {
            // bak vai subistituir o original
            final originalPath = element.path.substring(
              0,
              element.path.length - ext.length,
            );
            final originalFile = File(originalPath);
            if (await originalFile.exists()) {
              await originalFile.delete();
            }
            await element.rename(originalPath);
          }
        }
        return cacheDirectory;
      } catch (e) {
        throw CacheException('Falha ao inicializar o diretório de cache', e);
      }
    });
  }

  /// Monta o caminho completo do arquivo dentro do sistema de cache.
  ///
  /// Retorna um objeto [File] apontando para [path] dentro do diretório
  /// de cache da aplicação. Garante que o diretório de cache esteja
  /// inicializado antes de retornar o arquivo.
  ///
  /// [path] deve ser relativo ao diretório de cache (ex: 'clientes.json').
  ///
  /// Este é um método privado utilizado internamente por [fetchDataFromFile]
  /// e [saveData].
  Future<File> _mountFileSystem(String path) async {
    final String cacheDirectory = await _initializeDirectory();
    return File(p.join(cacheDirectory, path));
  }
}
