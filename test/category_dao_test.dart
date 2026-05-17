import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/dao/category_dao.dart';

import 'support/test_app_database.dart';

/// Testes para o CategoryDao.
///
/// Verifica operações CRUD de categorias e validações de duplicidade.
void main() {
  late AppDatabase database;
  late CategoryDao categoryDao;

  setUp(() {
    database = AppDatabase(
      applicationSupportDirectory: testApplicationSupportDirectory,
      tempDirectoryPath: testSqliteTempDirectoryPath,
    );
    categoryDao = database.categoryDao;
  });

  tearDown(() async {
    await database.close();
  });

  group('CategoryDao', () {
    group('insertCategory', () {
      test('deve inserir categoria com sucesso', () async {
        // Arrange
        const name = 'Eletrônicos';
        const description = 'Produtos eletrônicos e tecnologia';

        // Act
        final id = await categoryDao.insertCategory(
          name: name,
          description: description,
        );

        // Assert
        expect(id, greaterThan(0));

        final category = await categoryDao.getById(id);
        expect(category, isNotNull);
        expect(category!.name, name);
        expect(category.description, description);
      });

      test('deve inserir categoria sem descrição', () async {
        // Arrange
        const name = 'Alimentos';

        // Act
        final id = await categoryDao.insertCategory(name: name);

        // Assert
        expect(id, greaterThan(0));

        final category = await categoryDao.getById(id);
        expect(category, isNotNull);
        expect(category!.name, name);
        expect(category.description, isNull);
      });
    });

    group('getAll', () {
      test('deve retornar lista vazia quando não há categorias', () async {
        // Act
        final categories = await categoryDao.getAll();

        // Assert
        expect(categories, isEmpty);
      });

      test('deve retornar categorias ordenadas por nome', () async {
        // Arrange
        await categoryDao.insertCategory(name: 'Zebra');
        await categoryDao.insertCategory(name: 'Alpha');
        await categoryDao.insertCategory(name: 'Beta');

        // Act
        final categories = await categoryDao.getAll();

        // Assert
        expect(categories.length, 3);
        expect(categories[0].name, 'Alpha');
        expect(categories[1].name, 'Beta');
        expect(categories[2].name, 'Zebra');
      });
    });

    group('getByName', () {
      test('deve buscar categoria por nome', () async {
        // Arrange
        const name = 'Roupas';
        await categoryDao.insertCategory(name: name);

        // Act
        final category = await categoryDao.getByName(name);

        // Assert
        expect(category, isNotNull);
        expect(category!.name, name);
      });

      test('deve retornar null quando categoria não existe', () async {
        // Act
        final category = await categoryDao.getByName('Inexistente');

        // Assert
        expect(category, isNull);
      });
    });

    group('updateCategory', () {
      test('deve atualizar categoria com sucesso', () async {
        // Arrange
        final id = await categoryDao.insertCategory(
          name: 'Nome Antigo',
          description: 'Descrição antiga',
        );

        // Act
        final success = await categoryDao.updateCategory(
          id: id,
          name: 'Nome Novo',
          description: 'Descrição nova',
        );

        // Assert
        expect(success, isTrue);

        final category = await categoryDao.getById(id);
        expect(category!.name, 'Nome Novo');
        expect(category.description, 'Descrição nova');
      });
    });

    group('remove', () {
      test('deve remover categoria com sucesso', () async {
        // Arrange
        final id = await categoryDao.insertCategory(name: 'Para Remover');

        // Act
        final success = await categoryDao.remove(id);

        // Assert
        expect(success, isTrue);

        final category = await categoryDao.getById(id);
        expect(category, isNull);
      });

      test('deve retornar false ao remover categoria inexistente', () async {
        // Act
        final success = await categoryDao.remove(999);

        // Assert
        expect(success, isFalse);
      });
    });

    group('nameExists', () {
      test('deve retornar true quando nome existe', () async {
        // Arrange
        const name = 'Ferramentas';
        await categoryDao.insertCategory(name: name);

        // Act
        final exists = await categoryDao.nameExists(name);

        // Assert
        expect(exists, isTrue);
      });

      test('deve retornar false quando nome não existe', () async {
        // Act
        final exists = await categoryDao.nameExists('Não Existe');

        // Assert
        expect(exists, isFalse);
      });
    });
  });
}
