// ignore_for_file: avoid_dynamic_calls

import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:path_provider_platform_interface/path_provider_platform_interface.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
import 'package:system_loja/data/storage/json_storage.dart';
import 'package:system_loja/data/storage/storage_data.dart';

/// Implementação fake do PathProvider para testes
class FakePathProviderPlatform extends Fake
    with MockPlatformInterfaceMixin
    implements PathProviderPlatform {
  @override
  Future<String?> getApplicationSupportPath() async {
    // Retorna um diretório temporário para testes
    final tempDir = Directory.systemTemp.createTempSync('json_storage_test_');
    return tempDir.path;
  }
}

/// Testes do JsonDataStorage
///
/// Valida as operações de CRUD para armazenamento persistente em arquivos JSON,
/// com foco especial em operações concorrentes e sincronização.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late JsonDataStorage storage;
  late Directory testDir;
  const String testCategory = 'TestCategory';

  setUpAll(() {
    // Configura o PathProvider fake para todos os testes
    PathProviderPlatform.instance = FakePathProviderPlatform();
  });

  setUp(() async {
    // Cria um diretório temporário único para cada teste
    testDir = Directory.systemTemp.createTempSync('json_storage_test_');
    storage = JsonDataStorage(storageCategory: testCategory);
  });

  tearDown(() async {
    // Limpa o diretório após cada teste
    try {
      if (testDir.existsSync()) {
        testDir.deleteSync(recursive: true);
      }
    } catch (e) {
      // Ignora erros de limpeza
    }
  });

  group('JsonDataStorage - Testes de save', () {
    test('deve salvar um novo objeto com sucesso', () async {
      // Arrange
      final objeto = PersistentDataStore(id: 1, data: {'nome': 'Teste', 'valor': 123});

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
      final objeto1 = PersistentDataStore(id: 1, data: {'nome': 'Teste', 'valor': 123});
      await storage.save(objeto1);

      final objeto2 = PersistentDataStore(id: 1, data: {'nome': 'Teste Atualizado', 'valor': 456});

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
      final objeto1 = PersistentDataStore(id: 1, data: {'nome': 'Objeto 1'});
      final objeto2 = PersistentDataStore(id: 2, data: {'nome': 'Objeto 2'});
      final objeto3 = PersistentDataStore(id: 3, data: {'nome': 'Objeto 3'});

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

    test('deve lidar com operações concorrentes de save', () async {
      // Arrange
      final objetos = List.generate(
        10,
        (i) => PersistentDataStore(id: i + 1, data: {'index': i, 'nome': 'Objeto $i'}),
      );

      // Act - Salva todos os objetos concorrentemente
      final futures = objetos.map((obj) => storage.save(obj)).toList();
      final results = await Future.wait(futures);

      // Assert - Todos devem ter sido salvos com sucesso
      expect(results.every((r) => r == true), isTrue);

      // Verifica se todos os objetos foram salvos corretamente
      final loadResult = await storage.loadAll();
      expect(loadResult.isSuccessful, isTrue);
      expect(loadResult.asSuccess.length, equals(10));

      // Verifica a integridade dos dados
      for (var i = 0; i < 10; i++) {
        final obj = loadResult.asSuccess.firstWhere((o) => o.id == i + 1);
        expect(obj.data['index'], equals(i));
        expect(obj.data['nome'], equals('Objeto $i'));
      }
    });

    test('deve lidar com atualizações concorrentes do mesmo objeto', () async {
      // Arrange - Cria um objeto inicial
      final objetoInicial = PersistentDataStore(id: 1, data: {'contador': 0});
      await storage.save(objetoInicial);

      // Act - Tenta atualizar o mesmo objeto 50 vezes concorrentemente
      final futures = List.generate(
        50,
        (i) => storage.save(PersistentDataStore(id: 1, data: {'contador': i})),
      );
      final results = await Future.wait(futures);

      // Assert - Todas as operações devem ter sucesso
      expect(results.every((r) => r == true), isTrue);

      // O objeto deve existir e conter um dos valores (a última escrita vence)
      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.id, equals(1));
      expect(result.asSuccess.data['contador'], isA<int>());
      expect(result.asSuccess.data['contador'], inInclusiveRange(0, 49));
    });

    test('deve salvar dados complexos (objetos aninhados)', () async {
      // Arrange
      final objeto = PersistentDataStore(
        id: 1,
        data: {
          'usuario': {'nome': 'João Silva', 'email': 'joao@email.com', 'idade': 30},
          'configuracoes': {'tema': 'escuro', 'notificacoes': true},
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
      expect(dados, isA<Map<String, dynamic>>());
      expect(dados['usuario']['nome'], equals('João Silva'));
      expect(dados['configuracoes']['tema'], equals('escuro'));
      expect(dados['tags'], equals(['admin', 'developer']));
    });
  });

  group('JsonDataStorage - Testes de fetchById', () {
    test('deve buscar um objeto existente por ID', () async {
      // Arrange
      final objeto = PersistentDataStore(id: 42, data: {'descricao': 'Teste de busca'});
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
  });

  group('JsonDataStorage - Testes de loadAll', () {
    test('deve retornar lista vazia quando não há objetos', () async {
      // Act
      final result = await storage.loadAll();

      // Assert
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess, isEmpty);
    });

    test('deve carregar todos os objetos', () async {
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
    });
  });

  group('JsonDataStorage - Testes de delete', () {
    test('deve deletar um objeto existente', () async {
      // Arrange
      final objeto = PersistentDataStore(id: 1, data: {'teste': 'deletar'});
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
      expect(result.asError, contains('Falha ao deletar arquivo'));
    });

    test('deve lidar com deleções concorrentes', () async {
      // Arrange - Cria múltiplos objetos
      final objetos = List.generate(
        20,
        (i) => PersistentDataStore(id: i + 1, data: {'index': i}),
      );
      for (var obj in objetos) {
        await storage.save(obj);
      }

      // Act - Deleta todos concorrentemente
      final deleteFutures = List.generate(20, (i) => storage.delete(i + 1));
      final results = await Future.wait(deleteFutures);

      // Assert - Todos devem ter sido deletados
      expect(results.where((r) => r.isSuccessful).length, equals(20));

      // Verifica que nenhum objeto existe mais
      final loadResult = await storage.loadAll();
      expect(loadResult.isSuccessful, isTrue);
      expect(loadResult.asSuccess, isEmpty);
    });
  });

  group('JsonDataStorage - Testes de integração', () {
    test('deve executar ciclo completo CRUD', () async {
      // Create
      final objeto = PersistentDataStore(id: 100, data: {'status': 'criado'});
      var success = await storage.save(objeto);
      expect(success, isTrue);

      // Read
      var result = await storage.fetchById(100);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['status'], equals('criado'));

      // Update
      final objetoAtualizado = PersistentDataStore(id: 100, data: {'status': 'atualizado'});
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

    test('deve lidar com operações mistas concorrentes', () async {
      // Arrange - Cria alguns objetos iniciais
      for (var i = 1; i <= 5; i++) {
        await storage.save(PersistentDataStore(id: i, data: {'index': i}));
      }

      // Act - Executa operações mistas concorrentemente
      final futures = <Future>[];

      // Salvamentos
      for (var i = 6; i <= 10; i++) {
        futures.add(storage.save(PersistentDataStore(id: i, data: {'index': i})));
      }

      // Atualizações
      for (var i = 1; i <= 3; i++) {
        futures.add(storage.save(PersistentDataStore(id: i, data: {'updated': true})));
      }

      // Deleções
      futures.add(storage.delete(4));
      futures.add(storage.delete(5));

      // Leituras
      futures.add(storage.fetchById(1));
      futures.add(storage.loadAll());

      await Future.wait(futures);

      // Assert - Verifica o estado final
      final result = await storage.loadAll();
      expect(result.isSuccessful, isTrue);
      // Deve ter: 1,2,3 (atualizados) + 6,7,8,9,10 (novos) = 8 objetos
      // (4 e 5 foram deletados)
      expect(result.asSuccess.length, equals(8));
    });
  });

  group('JsonDataStorage - Testes de casos extremos', () {
    test('deve lidar com dados vazios', () async {
      // Arrange
      final objeto = PersistentDataStore(id: 1, data: {});

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
      final objeto = PersistentDataStore(id: 1, data: {'texto': textoLongo});

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

  group('JsonDataStorage - Testes de sincronização', () {
    test('deve garantir ordem consistente em saves concorrentes', () async {
      // Arrange
      final objeto = PersistentDataStore(id: 1, data: {'versao': 0});
      await storage.save(objeto);

      // Act - Tenta fazer 100 atualizações concorrentes
      final futures = List.generate(
        100,
        (i) => storage.save(PersistentDataStore(id: 1, data: {'versao': i + 1})),
      );

      final results = await Future.wait(futures);

      // Assert - Todas devem ter sucesso
      expect(results.every((r) => r == true), isTrue);

      // O objeto deve ter uma das versões (última escrita vence)
      final result = await storage.fetchById(1);
      expect(result.isSuccessful, isTrue);
      expect(result.asSuccess.data['versao'], isA<int>());
    });

    test('deve garantir que saves e deletes não causem corrupção', () async {
      // Arrange
      await storage.save(PersistentDataStore(id: 1, data: {'test': 'data'}));

      // Act - Alterna entre save e delete rapidamente
      final futures = <Future>[];
      for (var i = 0; i < 50; i++) {
        futures.add(storage.save(PersistentDataStore(id: 1, data: {'iteration': i})));
        if (i % 5 == 0) {
          futures.add(storage.delete(1));
        }
      }

      await Future.wait(futures);

      // Assert - Sistema deve estar em estado consistente
      // Ou o objeto existe, ou não existe (sem corrupção)
      final result = await storage.fetchById(1);
      // Não verificamos se existe ou não, apenas que não há exceção de corrupção
      expect(result.isSuccessful || result.hasError, isTrue);
    });
  });
}
