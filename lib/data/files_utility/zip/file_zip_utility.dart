import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';

/// Compactação e extração ZIP de arquivos de cache/backup.
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Auxilia import/export em arquivo. Persistência principal é Drift.
class FileZipUtility {
  /// Extrai o ZIP em [path] para [directory].
  static Future<void> unzipFile(String path, Directory directory) async {
    final input = InputFileStream(path);
    final zip = ZipDecoder().decodeStream(input);
    for (final entry in zip) {
      final fileName = entry.name;
      if (entry.isFile) {
        final output = OutputFileStream(p.join(directory.path, fileName));
        output.writeStream(entry.getContent()!);
        await output.close();
      } else {
        await Directory(p.join(directory.path, fileName)).create(recursive: true);
      }
    }
  }

  /// Compacta o conteúdo de [directory] em [fileName].
  static Future<void> zipDirectory(Directory directory, String fileName) async {
    if (!await directory.exists()) {
      throw const CacheException('Directory does not exist');
    }
    final zip = ZipFileEncoder();
    zip.create(fileName);
    await zip.addDirectory(directory);
    await zip.close();
  }

  /// Compacta o arquivo em [path] gerando [fileName].
  static Future<void> zipFile(String path, String fileName) async {
    if (!await File(path).exists()) {
      throw const CacheException('File does not exist');
    }
    final zip = ZipFileEncoder();
    zip.create(fileName);
    await zip.addFile(File(path));
    await zip.close();
  }

  /// Compacta a lista [files] gerando [fileName].
  static Future<void> zipFiles(List<File> files, String fileName) async {
    final zip = ZipFileEncoder();
    zip.create(fileName);
    for (final file in files) {
      await zip.addFile(file);
    }
    await zip.close();
  }
}
