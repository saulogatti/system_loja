import 'dart:convert';
import 'dart:io';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:path/path.dart' as p;

/// Gerenciador centralizado de operações de sistema de arquivos JSON.
///
/// Esta classe implementa o padrão Singleton para fornecer acesso global
/// a operações de leitura e escrita de arquivos JSON. Garante formatação
/// consistente (indentação de 2 espaços) e validação de caminhos.
class FileSystemManager with LoggerClassMixin {
  /// Instância única do gerenciador (padrão Singleton).
  static final FileSystemManager _instance = FileSystemManager._();

  /// Encoder JSON reutilizável para formatação consistente.
  static const JsonEncoder _jsonEncoder = JsonEncoder.withIndent('  ');

  /// Factory que retorna a instância única do gerenciador.
  factory FileSystemManager() => _instance;

  /// Construtor privado para garantir padrão Singleton.
  FileSystemManager._();

  /// Carrega e decodifica dados JSON de um arquivo.
  ///
  /// Lê o conteúdo de um arquivo JSON localizado em [path] e retorna
  /// os dados decodificados no tipo genérico [R]. O caminho deve ser
  /// válido e terminar com a extensão `.json`.
  ///
  /// Lança [ArgumentError] se o caminho for vazio ou não terminar com `.json`.
  /// Lança [FileSystemException] se o arquivo não existir.
  /// 
  /// Lança outras exceções em caso de erros de leitura ou decodificação.
  R loadJsonFromFile<R>(String path) {
    if (path.isEmpty || p.extension(path) != ".json") {
      throw ArgumentError('O caminho do arquivo não pode ser vazio. Caminhos JSON devem terminar com .json');
    }
    File file = File(path);
    if (!file.existsSync()) {
      throw FileSystemException('Arquivo não encontrado', path);
    }
    try {
      String content = file.readAsStringSync();
      final R data = jsonDecode(content) as R;
      return data;
    } catch (e, stackTrace) {
      logError("Erro ao carregar arquivo JSON em $path: $e", stackTrace);
      rethrow;
    }
  }

  /// Salva dados no formato JSON em um arquivo.
  ///
  /// Codifica [data] em formato JSON com indentação de 2 espaços e
  /// persiste no caminho especificado em [path]. Cria diretórios pai
  /// automaticamente se não existirem.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  /// Lança [ArgumentError] se o caminho for vazio ou não terminar com `.json`.
  /// Erros de I/O são registrados via `logError` e o método retorna `false`.
  bool saveJsonToFile(String path, Object data) {
    if (path.isEmpty || p.extension(path) != ".json") {
      throw ArgumentError('O caminho do arquivo não pode ser vazio. Caminhos JSON devem terminar com .json');
    }

    try {
      File file = File(path);
      if (!file.parent.existsSync()) {
        file.parent.createSync(recursive: true);
      }
      String jsonString = _jsonEncoder.convert(data);
      file.writeAsStringSync(jsonString);
      return true;
    } catch (e, stackTrace) {
      logError('Erro ao salvar arquivo JSON em $path: $e', stackTrace);
      return false;
    }
  }
}
