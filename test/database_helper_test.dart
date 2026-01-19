import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/data/database/database_config.dart';
import 'package:system_loja/data/database/database_helper.dart';

/// Testes do DatabaseHelper
///
/// Valida a inicialização e gerenciamento do banco de dados SQLite.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  setUpAll(() {
    // Configura um banco de dados em memória para testes
    databaseFactory = databaseFactoryFfi;
  });

  setUp(DatabaseHelper.resetInstance);

  tearDown(() async {
    // Limpa o banco após cada teste
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteDatabase();
    DatabaseHelper.resetInstance();
  });

  group('DatabaseHelper - Testes de Inicialização', () {
    test('deve inicializar o banco de dados com sucesso', () async {
      // Arrange
      final dbHelper = DatabaseHelper();

      // Act
      final db = await dbHelper.database;

      // Assert
      expect(db, isNotNull);
      expect(db.isOpen, isTrue);
    });

    test('deve criar a tabela de clientes', () async {
      // Arrange
      final dbHelper = DatabaseHelper();

      // Act - inicializa o banco
      await dbHelper.database;

      // Assert
      final exists = await dbHelper.tableExists(DatabaseConfig.tableClientes);
      expect(exists, isTrue);
    });

    test('deve criar a tabela de produtos', () async {
      // Arrange
      final dbHelper = DatabaseHelper();

      // Act
      await dbHelper.database;

      // Assert
      final exists = await dbHelper.tableExists(DatabaseConfig.tableProdutos);
      expect(exists, isTrue);
    });

    test('deve criar a tabela de notas fiscais', () async {
      // Arrange
      final dbHelper = DatabaseHelper();

      // Act
      await dbHelper.database;

      // Assert
      final exists = await dbHelper.tableExists(
        DatabaseConfig.tableNotasFiscais,
      );
      expect(exists, isTrue);
    });

    test('deve criar a tabela de itens de nota fiscal', () async {
      // Arrange
      final dbHelper = DatabaseHelper();

      // Act
      await dbHelper.database;

      // Assert
      final exists = await dbHelper.tableExists(
        DatabaseConfig.tableInvoiceItems,
      );
      expect(exists, isTrue);
    });

    test('deve retornar a mesma instância (Singleton)', () async {
      // Arrange
      final dbHelper1 = DatabaseHelper();
      final dbHelper2 = DatabaseHelper();

      // Act
      final db1 = await dbHelper1.database;
      final db2 = await dbHelper2.database;

      // Assert
      expect(identical(db1, db2), isTrue);
    });

    test('deve fechar o banco de dados', () async {
      // Arrange
      final dbHelper = DatabaseHelper();
      await dbHelper.database; // Inicializa o banco

      // Act
      await dbHelper.close();

      // Assert
      // Após close, ao chamar database novamente, um novo banco é aberto
      DatabaseHelper.resetInstance();
      final dbHelper2 = DatabaseHelper();
      final db = await dbHelper2.database;
      expect(db.isOpen, isTrue);
    });

    test('deve contar registros em uma tabela vazia', () async {
      // Arrange
      final dbHelper = DatabaseHelper();
      await dbHelper.database; // Inicializa o banco

      // Act
      final count = await dbHelper.countRecords(DatabaseConfig.tableClientes);

      // Assert
      expect(count, equals(0));
    });
  });
}
