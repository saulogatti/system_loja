import 'dart:io';

/// Diretório temporário exclusivo para [AppDatabase] em testes unitários,
/// sem depender de `path_provider` / `MethodChannel`.
Future<Object> testApplicationSupportDirectory() async {
  return Directory.systemTemp.createTempSync('system_loja_test_');
}

/// Caminho para arquivos temporários do SQLite (`sqlite3.tempDirectory`), sem plugin.
Future<String?> testSqliteTempDirectoryPath() async =>
    Directory.systemTemp.path;
