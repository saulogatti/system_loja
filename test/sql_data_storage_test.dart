import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/storage/sql_data_storage.dart';
import 'package:system_loja/data/storage/storage_data.dart';

/// Testes do SqlDataStorage
///
/// Valida as operações de CRUD para armazenamento persistente genérico
/// no banco de dados SQL usando a tabela persistent_data_store.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late SqlDataStorage storage;
  const String testCategory = 'TestCategory';

  setUpAll(() async {
    // Configura um banco de dados em memória para testes
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Reset da instância do banco antes de cada teste
    DatabaseHelper.resetInstance();
    storage = SqlDataStorage(storageCategory: testCategory);
  });

  tearDown(() async {
    // Limpa o banco após cada teste
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteDatabase();
    DatabaseHelper.resetInstance();
  });

  group('SqlDataStorage - Testes de save', () {
    test('deve salvar um novo objeto com sucesso', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {'nome': 'Teste', 'valor': 123},
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      // Verifica se o objeto foi salvo
      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.id, equals(1));
      expect(result.asSuccess.data['nome'], equals('Teste'));
      expect(result.asSuccess.data['valor'], equals(123));
    });

    test('deve atualizar um objeto existente', () async {
      // Arrange
      final objeto1 = PersistentDataStore(
        id: 1,
        data: {'nome': 'Teste', 'valor': 123},
      );
      await storage.save(objeto1);

      final objeto2 = PersistentDataStore(
        id: 1,
        data: {'nome': 'Teste Atualizado', 'valor': 456},
      );

      // Act
      final success = await storage.save(objeto2);

      // Assert
      expect(success, isTrue);

      // Verifica se o objeto foi atualizado
      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['nome'], equals('Teste Atualizado'));
      expect(result.asSuccess.data['valor'], equals(456));
    });

    test('deve salvar múltiplos objetos com IDs diferentes', () async {
      // Arrange
      final objeto1 = PersistentDataStore(
        id: 1,
        data: {'nome': 'Objeto 1'},
      );
      final objeto2 = PersistentDataStore(
        id: 2,
        data: {'nome': 'Objeto 2'},
      );
      final objeto3 = PersistentDataStore(
        id: 3,
        data: {'nome': 'Objeto 3'},
      );

      // Act
      final success1 = await storage.save(objeto1);
      final success2 = await storage.save(objeto2);
      final success3 = await storage.save(objeto3);

      // Assert
      expect(success1, isTrue);
      expect(success2, isTrue);
      expect(success3, isTrue);

      final result = await storage.loadAll();
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.length, equals(3));
    });

    test('deve salvar dados complexos (objetos aninhados)', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {
          'usuario': {
            'nome': 'João Silva',
            'email': 'joao@email.com',
            'idade': 30,
          },
          'configuracoes': {
            'tema': 'escuro',
            'notificacoes': true,
          },
          'tags': ['admin', 'developer'],
        },
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      final dados = result.asSuccess.data;
      expect(dados['usuario']['nome'], equals('João Silva'));
      expect(dados['configuracoes']['tema'], equals('escuro'));
      expect(dados['tags'], equals(['admin', 'developer']));
    });
  });

  group('SqlDataStorage - Testes de fetchById', () {
    test('deve buscar um objeto existente por ID', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 42,
        data: {'descricao': 'Teste de busca'},
      );
      await storage.save(objeto);

      // Act
      final result = await storage.fetchById(42);

      // Assert
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.id, equals(42));
      expect(result.asSuccess.data['descricao'], equals('Teste de busca'));
    });

    test('deve retornar erro ao buscar objeto inexistente', () async {
      // Act
      final result = await storage.fetchById(999);

      // Assert
      expect(result.hasError, isTrue);
      expect(result.asError, contains('não encontrado'));
    });

    test('deve isolar buscas por categoria', () async {
      // Arrange
      final storage1 = SqlDataStorage(storageCategory: 'Categoria1');
      final storage2 = SqlDataStorage(storageCategory: 'Categoria2');

      final objeto1 = PersistentDataStore(
        id: 1,
        data: {'categoria': 'primeira'},
      );
      final objeto2 = PersistentDataStore(
        id: 1, // Mesmo ID, mas categoria diferente
        data: {'categoria': 'segunda'},
      );

      await storage1.save(objeto1);
      await storage2.save(objeto2);

      // Act
      final result1 = await storage1.fetchById(1);
      final result2 = await storage2.fetchById(1);

      // Assert
      expect(result1.isSuccessful, isTrue);
      expect(result2.isSuccessful, isTrue);
      expect(result1.asSuccess.data['categoria'], equals('primeira'));
      expect(result2.asSuccess.data['categoria'], equals('segunda'));
    });
  });

  group('SqlDataStorage - Testes de loadAll', () {
    test('deve retornar lista vazia quando não há objetos', () async {
      // Act
      final result = await storage.loadAll();

      // Assert
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess, isEmpty);
    });

    test('deve carregar todos os objetos da categoria', () async {
      // Arrange
      final objetos = [
        PersistentDataStore(id: 1, data: {'nome': 'Objeto 1'}),
        PersistentDataStore(id: 2, data: {'nome': 'Objeto 2'}),
        PersistentDataStore(id: 3, data: {'nome': 'Objeto 3'}),
        PersistentDataStore(id: 4, data: {'nome': 'Objeto 4'}),
        PersistentDataStore(id: 5, data: {'nome': 'Objeto 5'}),
      ];

      for (var obj in objetos) {
        await storage.save(obj);
      }

      // Act
      final result = await storage.loadAll();

      // Assert
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.length, equals(5));
      
      // Verifica se os IDs estão em ordem crescente
      final ids = result.asSuccess.map((e) => e.id).toList();
      expect(ids, equals([1, 2, 3, 4, 5]));
    });

    test('deve isolar carregamento por categoria', () async {
      // Arrange
      final storage1 = SqlDataStorage(storageCategory: 'Categoria1');
      final storage2 = SqlDataStorage(storageCategory: 'Categoria2');

      await storage1.save(PersistentDataStore(id: 1, data: {'cat': '1'}));
      await storage1.save(PersistentDataStore(id: 2, data: {'cat': '1'}));
      await storage2.save(PersistentDataStore(id: 1, data: {'cat': '2'}));

      // Act
      final result1 = await storage1.loadAll();
      final result2 = await storage2.loadAll();

      // Assert
      expect(result1.isSuccessful, isTrue);
      expect(result2.isSuccessful, isTrue);
      expect(result1.asSuccess.length, equals(2));
      expect(result2.asSuccess.length, equals(1));
      expect(result1.asSuccess.first.data['cat'], equals('1'));
      expect(result2.asSuccess.first.data['cat'], equals('2'));
    });

    test('deve manter a ordem dos objetos por ID', () async {
      // Arrange - Salva em ordem não sequencial
      await storage.save(PersistentDataStore(id: 5, data: {'ordem': 5}));
      await storage.save(PersistentDataStore(id: 1, data: {'ordem': 1}));
      await storage.save(PersistentDataStore(id: 3, data: {'ordem': 3}));
      await storage.save(PersistentDataStore(id: 2, data: {'ordem': 2}));
      await storage.save(PersistentDataStore(id: 4, data: {'ordem': 4}));

      // Act
      final result = await storage.loadAll();

      // Assert
      expect(result.isSuccessful, isTrue);
      final ids = result.asSuccess.map((e) => e.id).toList();
      expect(ids, equals([1, 2, 3, 4, 5])); // Deve estar ordenado
    });
  });

  group('SqlDataStorage - Testes de delete', () {
    test('deve deletar um objeto existente', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {'teste': 'deletar'},
      );
      await storage.save(objeto);

      // Verifica que o objeto existe
      var result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);

      // Act
      final deleteResult = await storage.delete(1);

      // Assert
      expect(deleteResult.isSuccessful, isTrue);
      expect(deleteResult.asSuccess, isTrue);

      // Verifica que o objeto não existe mais
      result = await storage.fetchById(1);
      expect(result.hasError, isTrue);
    });

    test('deve retornar erro ao deletar objeto inexistente', () async {
      // Act
      final result = await storage.delete(999);

      // Assert
      expect(result.hasError, isTrue);
      expect(result.asError, contains('Nenhum objeto encontrado'));
    });

    test('deve isolar deleção por categoria', () async {
      // Arrange
      final storage1 = SqlDataStorage(storageCategory: 'Categoria1');
      final storage2 = SqlDataStorage(storageCategory: 'Categoria2');

      await storage1.save(PersistentDataStore(id: 1, data: {'cat': '1'}));
      await storage2.save(PersistentDataStore(id: 1, data: {'cat': '2'}));

      // Act - Deleta apenas da categoria 1
      final deleteResult = await storage1.delete(1);

      // Assert
      expect(deleteResult.isSuccessful, isTrue);

      // Verifica que foi deletado apenas da categoria 1
      final result1 = await storage1.fetchById(1);
      final result2 = await storage2.fetchById(1);

      expect(result1.hasError, isTrue);
      expect(result2.isSuccessful, isTrue);
      expect(result2.asSuccess.data['cat'], equals('2'));
    });

    test('deve deletar múltiplos objetos independentemente', () async {
      // Arrange
      await storage.save(PersistentDataStore(id: 1, data: {'num': 1}));
      await storage.save(PersistentDataStore(id: 2, data: {'num': 2}));
      await storage.save(PersistentDataStore(id: 3, data: {'num': 3}));

      // Act
      await storage.delete(1);
      await storage.delete(3);

      // Assert
      final result = await storage.loadAll();
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.length, equals(1));
      expect(result.asSuccess.first.id, equals(2));
    });
  });

  group('SqlDataStorage - Testes de integração', () {
    test('deve executar ciclo completo CRUD', () async {
      // Create
      final objeto = PersistentDataStore(
        id: 100,
        data: {'status': 'criado'},
      );
      var success = await storage.save(objeto);
      expect(success, isTrue);

      // Read
      var result = await storage.fetchById(100);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['status'], equals('criado'));

      // Update
      final objetoAtualizado = PersistentDataStore(
        id: 100,
        data: {'status': 'atualizado'},
      );
      success = await storage.save(objetoAtualizado);
      expect(success, isTrue);

      result = await storage.fetchById(100);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['status'], equals('atualizado'));

      // Delete
      final deleteResult = await storage.delete(100);
      expect(deleteResult.isSuccessful, isTrue);

      result = await storage.fetchById(100);
      expect(result.hasError, isTrue);
    });

    test('deve lidar com múltiplas categorias simultaneamente', () async {
      // Arrange
      final usuarios = SqlDataStorage(storageCategory: 'usuarios');
      final produtos = SqlDataStorage(storageCategory: 'produtos');
      final configs = SqlDataStorage(storageCategory: 'configuracoes');

      // Act
      await usuarios.save(PersistentDataStore(id: 1, data: {'nome': 'João'}));
      await usuarios.save(PersistentDataStore(id: 2, data: {'nome': 'Maria'}));
      
      await produtos.save(PersistentDataStore(id: 1, data: {'nome': 'Cadeira'}));
      await produtos.save(PersistentDataStore(id: 2, data: {'nome': 'Mesa'}));
      await produtos.save(PersistentDataStore(id: 3, data: {'nome': 'Sofá'}));
      
      await configs.save(PersistentDataStore(id: 1, data: {'tema': 'escuro'}));

      // Assert
      final usuariosResult = await usuarios.loadAll();
      final produtosResult = await produtos.loadAll();
      final configsResult = await configs.loadAll();

      expect(usuariosResult.asSuccess.length, equals(2));
      expect(produtosResult.asSuccess.length, equals(3));
      expect(configsResult.asSuccess.length, equals(1));
    });

    test('deve preservar dados após reabrir o banco', () async {
      // Arrange - Salva dados
      await storage.save(PersistentDataStore(
        id: 1,
        data: {'persistente': true},
      ));

      // Fecha e reabre o banco
      final dbHelper = DatabaseHelper();
      await dbHelper.close();
      DatabaseHelper.resetInstance();

      // Cria nova instância do storage
      final novoStorage = SqlDataStorage(storageCategory: testCategory);

      // Act
      final result = await novoStorage.fetchById(1);

      // Assert
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['persistente'], isTrue);
    });
  });

  group('SqlDataStorage - Testes de casos extremos', () {
    test('deve lidar com dados vazios', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {},
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data, isEmpty);
    });

    test('deve lidar com strings longas', () async {
      // Arrange
      final textoLongo = 'A' * 10000; // 10k caracteres
      final objeto = PersistentDataStore(
        id: 1,
        data: {'texto': textoLongo},
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['texto'], equals(textoLongo));
      expect(result.asSuccess.data['texto'].length, equals(10000));
    });

    test('deve lidar com caracteres especiais', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {
          'emoji': '😀🎉💻',
          'acentos': 'áéíóú ãõ çÇ',
          'especiais': '!@#\$%^&*()_+-=[]{}|;:",.<>?',
          'unicode': '∞ ≠ ≈ ∑ π',
        },
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['emoji'], equals('😀🎉💻'));
      expect(result.asSuccess.data['acentos'], equals('áéíóú ãõ çÇ'));
    });

    test('deve lidar com arrays e valores null', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {
          'array_vazio': [],
          'array_numeros': [1, 2, 3, 4, 5],
          'array_mixed': [1, 'texto', true, null],
          'valor_null': null,
          'boolean': true,
          'numero': 42.5,
        },
      );

      // Act
      final success = await storage.save(objeto);

      // Assert
      expect(success, isTrue);

      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['array_vazio'], equals([]));
      expect(result.asSuccess.data['array_numeros'], equals([1, 2, 3, 4, 5]));
      expect(result.asSuccess.data['valor_null'], isNull);
      expect(result.asSuccess.data['boolean'], isTrue);
      expect(result.asSuccess.data['numero'], equals(42.5));
    });
  });
}
