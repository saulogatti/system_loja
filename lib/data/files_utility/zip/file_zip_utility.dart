import 'dart:io';

import 'package:archive/archive_io.dart';
import 'package:path/path.dart' as p;
import 'package:system_loja/data/cache/exceptions/cache_exception.dart';

class FileZipUtility {
  static Future<void> unzipFile(String path, Directory directory) async {
    final input = InputFileStream(path);
    final zip = ZipDecoder().decodeStream(input);
    for (var entry in zip) {
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

  static Future<void> zipDirectory(Directory directory, String fileName) async {
    if (!await directory.exists()) {
      throw CacheException('Directory does not exist');
    }
    final zip = ZipFileEncoder();
    zip.create(fileName);
    await zip.addDirectory(directory);
    await zip.close();
  }

  static Future<void> zipFile(String path, String fileName) async {
    if (!await File(path).exists()) {
      throw CacheException('File does not exist');
    }
    final zip = ZipFileEncoder();
    zip.create(fileName);
    await zip.addFile(File(path));
    await zip.close();
  }

  static Future<void> zipFiles(List<File> files, String fileName) async {
    final zip = ZipFileEncoder();
    zip.create(fileName);
    for (var file in files) {
      await zip.addFile(file);
    }
    await zip.close();
  }
}
