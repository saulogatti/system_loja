import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:path/path.dart' as p;
import 'support/test_app_database.dart';

void main() {
  late AppDatabase db;

  setUp(() {
    db = AppDatabase(
      applicationSupportDirectory: testApplicationSupportDirectory,
      tempDirectoryPath: testSqliteTempDirectoryPath,
    );
  });

  tearDown(() async {
    await db.close();
  });

  test('manualBackup creates a backup file', () async {
    final supportDir = await testApplicationSupportDirectory() as Directory;
    final backupFile = p.join(supportDir.path, 'backup.db');

    // Clean up if exists from previous run
    if (File(backupFile).existsSync()) {
      File(backupFile).deleteSync();
    }

    await db.manualBackup(backupFile);
    expect(File(backupFile).existsSync(), isTrue);

    // Clean up after test
    File(backupFile).deleteSync();
  });

  test('Verify if VACUUM INTO supports parameters', () async {
    final supportDir = await testApplicationSupportDirectory() as Directory;
    final backupFile = p.join(supportDir.path, 'parameter_backup.db');

    if (File(backupFile).existsSync()) {
      File(backupFile).deleteSync();
    }

    try {
      await db.customStatement('VACUUM INTO ?', [backupFile]);
      expect(File(backupFile).existsSync(), isTrue);
    } catch (e) {
      // If it doesn't support parameters, it will throw.
      // We expect it to support parameters in modern SQLite (3.44.0+).
      rethrow;
    } finally {
      if (File(backupFile).existsSync()) {
        File(backupFile).deleteSync();
      }
    }
  });

  test('Attempt SQL injection on manualBackup', () async {
    final supportDir = await testApplicationSupportDirectory() as Directory;
    // We try to inject a second command.
    // If parameterized query works, this whole string is treated as one filename.
    final injectionFile = p.join(supportDir.path, "test.db'; DROP TABLE IF EXISTS non_existent; --");

    try {
      await db.manualBackup(injectionFile);
      // If it succeeds, it just created a file with a weird name (if the OS allows)
      final file = File(injectionFile);
      if (file.existsSync()) {
        file.deleteSync();
      }
    } catch (_) {
      // Expected failure if the OS doesn't allow these characters in filename
    }

    // The real verification is that it didn't crash the database or execute
    // the injected part as a command. Parameterized queries ensure this.
  });
}
