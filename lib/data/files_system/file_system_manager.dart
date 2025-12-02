import 'dart:convert';
import 'dart:io';

import 'package:async/async.dart';
import 'package:meta/meta.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';

/// Gerenciador centralizado de operações de sistema de arquivos JSON.
///
/// Este mixin fornece funcionalidades de leitura e escrita de arquivos JSON
/// com cache automático no diretório de suporte da aplicação. Garante formatação
/// consistente (indentação de 2 espaços), validação de caminhos e inicialização
/// segura do sistema de arquivos.
///
/// Classes que utilizam este mixin devem implementar o método `logError`.
mixin FileSystemManager {
  /// Encoder JSON reutilizável para formatação consistente.
  static const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');

  /// Memoizador para garantir inicialização única do diretório de cache.
  ///
  /// Armazena o resultado da primeira chamada a [setupFileSystem] e
  /// reutiliza para chamadas subsequentes, evitando operações de I/O
  /// desnecessárias.
  AsyncMemoizer<String> memoizer = AsyncMemoizer<String>();

  @protected
  /// Exclui todos os arquivos JSON do diretório de cache.
  /// Esta função é útil para limpar o cache
  /// de dados persistidos, removendo todos os arquivos JSON
  /// armazenados no diretório de cache.
  /// Exclui apenas arquivos com extensão `.json`.
  /// Se o diretório não existir, não faz nada.
  /// Se ocorrer um erro ao excluir os arquivos,
  /// o erro é registrado via `logError`,
  /// mas a função não lança exceções.
  @protected
  Future<void> deleteDirectory() async {
    final cacheDir = Directory(await setupFileSystem());
    if (await cacheDir.exists()) {
      await for (final entity in cacheDir.list()) {
        if (entity is File && entity.path.endsWith('.json')) {
          await entity.delete();
        }
      }
    }
  }

  /// Carrega e decodifica dados JSON de um arquivo de forma assíncrona.
  ///
  /// Lê o conteúdo de um arquivo JSON localizado em [fileName] relativo ao
  /// diretório de cache da aplicação e retorna os dados decodificados no
  /// tipo genérico [R]. O caminho deve ser válido e terminar com `.json`.
  ///
  /// O método garante que o sistema de arquivos esteja inicializado antes
  /// de tentar ler o arquivo.
  ///
  /// Lança [ArgumentError] se o caminho for vazio ou não terminar com `.json`.
  /// Registra erros e relança exceções em caso de falhas de leitura ou decodificação.
  @protected
  Future<R> loadJsonFromFile<R>(String fileName) async {
    if (fileName.isEmpty || p.extension(fileName) != '.json') {
      throw ArgumentError('O caminho do arquivo não pode ser vazio. Caminhos JSON devem terminar com .json');
    }

    File file = await _mountFileSystem(fileName);
    if (!await file.exists()) {
      assert(false, 'Arquivo não encontrado: $fileName');
    }
    try {
      String content = await file.readAsString();
      final R data = jsonDecode(content) as R;
      return data;
    } catch (e, stackTrace) {
      logError('Erro ao carregar arquivo JSON em $fileName: $e', stackTrace);
      rethrow;
    }
  }

  /// Registra mensagens de erro com stack trace.
  ///
  /// Este método abstrato deve ser implementado pelas classes que usam
  /// este mixin, tipicamente usando `LoggerClassMixin` ou similar.
  void logError(String message, StackTrace stackTrace);

  /// Salva dados no formato JSON em um arquivo de forma assíncrona.
  ///
  /// Codifica [data] em formato JSON com indentação de 2 espaços e
  /// persiste no caminho especificado em [path] relativo ao diretório
  /// de cache. Cria diretórios pai automaticamente se não existirem.
  ///
  /// O método garante que o sistema de arquivos esteja inicializado antes
  /// de tentar salvar o arquivo.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  /// Lança [ArgumentError] se o caminho for vazio ou não terminar com `.json`.
  /// Erros de I/O são registrados via `logError` e o método retorna `false`.
  @protected
  Future<bool> saveJsonToFile(String path, Object data) async {
    if (path.isEmpty || p.extension(path) != '.json') {
      throw ArgumentError('O caminho do arquivo não pode ser vazio. Caminhos JSON devem terminar com .json');
    }

    try {
      File file = await _mountFileSystem(path);
      if (!file.parent.existsSync()) {
        file.parent.createSync(recursive: true);
      }
      String jsonString = _jsonEncoder.convert(data);
      await file.writeAsString(jsonString);
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao salvar arquivo JSON em $path: $e', stackTrace);
      return false;
    }
  }

  /// Inicializa o cache de forma assíncrona.
  ///
  /// Este método deve ser chamado antes de qualquer operação de cache.
  /// É seguro chamar este método múltiplas vezes, pois ele só inicializa
  /// uma vez.
  ///
  /// Lança [CacheException] se ocorrer um erro durante a inicialização.
  Future<String> setupFileSystem() async {
    if (memoizer.hasRun) return memoizer.future;
    return await memoizer.runOnce(() async {
      try {
        final directory = await getApplicationSupportDirectory();
        String cacheDirectory = p.join(directory.path, systemNameDirectory());
        final cacheDir = Directory(cacheDirectory);

        if (!await cacheDir.exists()) {
          await cacheDir.create(recursive: true);
        }
        return cacheDirectory;
      } catch (e) {
        throw CacheException('Falha ao inicializar o diretório de cache', e);
      }
    });
  }

  @protected
  String systemNameDirectory();

  /// Monta o sistema de arquivos para o caminho fornecido.
  ///
  /// Retorna um objeto [File] apontando para [path] dentro do diretório
  /// de cache da aplicação. Garante que o diretório de cache esteja
  /// inicializado antes de retornar o arquivo.
  ///
  /// Este é um método privado utilizado internamente por [loadJsonFromFile]
  /// e [saveJsonToFile].
  Future<File> _mountFileSystem(String path) async {
    String cacheDirectory = await setupFileSystem();
    return File(p.join(cacheDirectory, path));
  }
}
