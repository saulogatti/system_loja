import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/database/produto_sql_manager.dart';

/// Testes do ProdutoSqlManager
///
/// Valida as operações de CRUD para produtos no banco de dados SQL.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late ProdutoSqlManager produtoManager;

  setUpAll(() async {
    // Configura um banco de dados em memória para testes
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Reset da instância do banco antes de cada teste
    DatabaseHelper.resetInstance();
    produtoManager = ProdutoSqlManager();
  });

  tearDown(() async {
    // Limpa o banco após cada teste
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteDatabase();
    DatabaseHelper.resetInstance();
  });

  group('ProdutoSqlManager - Testes de CRUD', () {
    test('deve inserir um produto com sucesso', () async {
      // Arrange
      final produto = Produto(
        nome: 'Notebook Dell',
        codigo: 'NOTE-001',
        preco: 3500.00,
        estoque: 10,
        descricao: 'Notebook Dell Inspiron 15',
        categoria: 'Eletrônicos',
      );

      // Act
      final id = await produtoManager.inserir(produto);

      // Assert
      expect(id, greaterThan(0));

      final produtoInserido = await produtoManager.consultarPorId(id);
      expect(produtoInserido, isNotNull);
      expect(produtoInserido!.nome, equals('Notebook Dell'));
      expect(produtoInserido.codigo, equals('NOTE-001'));
      expect(produtoInserido.preco, equals(3500.00));
    });

    test('deve lançar exceção ao inserir produto com código duplicado',
        () async {
      // Arrange
      final produto1 = Produto(
        nome: 'Notebook Dell',
        codigo: 'NOTE-001',
        preco: 3500.00,
        estoque: 10,
        descricao: 'Notebook Dell Inspiron 15',
        categoria: 'Eletrônicos',
      );

      final produto2 = Produto(
        nome: 'Notebook HP',
        codigo: 'NOTE-001', // Mesmo código
        preco: 4000.00,
        estoque: 5,
        descricao: 'Notebook HP Pavilion',
        categoria: 'Eletrônicos',
      );

      // Act & Assert
      await produtoManager.inserir(produto1);
      expect(
        () => produtoManager.inserir(produto2),
        throwsA(isA<Exception>()),
      );
    });

    test('deve consultar produto por código', () async {
      // Arrange
      final produto = Produto(
        nome: 'Mouse Logitech',
        codigo: 'MOUSE-001',
        preco: 150.00,
        estoque: 50,
        descricao: 'Mouse sem fio Logitech MX',
        categoria: 'Periféricos',
      );

      await produtoManager.inserir(produto);

      // Act
      final produtoEncontrado = await produtoManager.consultarPorCodigo(
        'MOUSE-001',
      );

      // Assert
      expect(produtoEncontrado, isNotNull);
      expect(produtoEncontrado!.nome, equals('Mouse Logitech'));
    });

    test('deve retornar null ao consultar código inexistente', () async {
      // Act
      final produto = await produtoManager.consultarPorCodigo('INEXISTENTE');

      // Assert
      expect(produto, isNull);
    });

    test('deve atualizar produto com sucesso', () async {
      // Arrange
      final produto = Produto(
        nome: 'Teclado Mecânico',
        codigo: 'TEC-001',
        preco: 300.00,
        estoque: 20,
        descricao: 'Teclado mecânico RGB',
        categoria: 'Periféricos',
      );

      final id = await produtoManager.inserir(produto);

      // Act
      final produtoAtualizado = Produto(
        id: id,
        nome: 'Teclado Mecânico Pro',
        codigo: 'TEC-001',
        preco: 350.00,
        estoque: 15,
        descricao: 'Teclado mecânico RGB Pro Edition',
        categoria: 'Periféricos',
      );

      final linhasAfetadas = await produtoManager.atualizar(produtoAtualizado);

      // Assert
      expect(linhasAfetadas, equals(1));

      final produtoConsultado = await produtoManager.consultarPorId(id);
      expect(produtoConsultado!.nome, equals('Teclado Mecânico Pro'));
      expect(produtoConsultado.preco, equals(350.00));
      expect(produtoConsultado.estoque, equals(15));
    });

    test('deve excluir produto com sucesso', () async {
      // Arrange
      final produto = Produto(
        nome: 'Monitor 24"',
        codigo: 'MON-001',
        preco: 800.00,
        estoque: 8,
        descricao: 'Monitor LED 24 polegadas',
        categoria: 'Eletrônicos',
      );

      final id = await produtoManager.inserir(produto);

      // Act
      final linhasAfetadas = await produtoManager.excluir(id);

      // Assert
      expect(linhasAfetadas, equals(1));

      final produtoExcluido = await produtoManager.consultarPorId(id);
      expect(produtoExcluido, isNull);
    });

    test('deve listar todos os produtos', () async {
      // Arrange
      final produto1 = Produto(
        nome: 'Produto A',
        codigo: 'PROD-A',
        preco: 100.00,
        estoque: 10,
        descricao: 'Descrição A',
        categoria: 'Categoria A',
      );

      final produto2 = Produto(
        nome: 'Produto B',
        codigo: 'PROD-B',
        preco: 200.00,
        estoque: 20,
        descricao: 'Descrição B',
        categoria: 'Categoria B',
      );

      await produtoManager.inserir(produto1);
      await produtoManager.inserir(produto2);

      // Act
      final produtos = await produtoManager.listarTodos();

      // Assert
      expect(produtos.length, equals(2));
      // Ordenado por nome
      expect(produtos[0].nome, equals('Produto A'));
      expect(produtos[1].nome, equals('Produto B'));
    });

    test('deve buscar produtos por categoria', () async {
      // Arrange
      final produto1 = Produto(
        nome: 'Mouse',
        codigo: 'MOUSE-001',
        preco: 100.00,
        estoque: 50,
        descricao: 'Mouse sem fio',
        categoria: 'Periféricos',
      );

      final produto2 = Produto(
        nome: 'Teclado',
        codigo: 'TEC-001',
        preco: 200.00,
        estoque: 30,
        descricao: 'Teclado USB',
        categoria: 'Periféricos',
      );

      final produto3 = Produto(
        nome: 'Notebook',
        codigo: 'NOTE-001',
        preco: 3500.00,
        estoque: 10,
        descricao: 'Notebook Dell',
        categoria: 'Eletrônicos',
      );

      await produtoManager.inserir(produto1);
      await produtoManager.inserir(produto2);
      await produtoManager.inserir(produto3);

      // Act
      final perifericos = await produtoManager.buscarPorCategoria('Periféricos');

      // Assert
      expect(perifericos.length, equals(2));
    });

    test('deve listar produtos com estoque baixo', () async {
      // Arrange
      final produto1 = Produto(
        nome: 'Produto com estoque alto',
        codigo: 'ALTO-001',
        preco: 100.00,
        estoque: 100,
        descricao: 'Estoque alto',
        categoria: 'Geral',
      );

      final produto2 = Produto(
        nome: 'Produto com estoque baixo',
        codigo: 'BAIXO-001',
        preco: 200.00,
        estoque: 5,
        descricao: 'Estoque baixo',
        categoria: 'Geral',
      );

      await produtoManager.inserir(produto1);
      await produtoManager.inserir(produto2);

      // Act
      final produtosEstoqueBaixo = await produtoManager.listarComEstoqueBaixo(10);

      // Assert
      expect(produtosEstoqueBaixo.length, equals(1));
      expect(produtosEstoqueBaixo[0].codigo, equals('BAIXO-001'));
    });

    test('deve atualizar estoque de produto', () async {
      // Arrange
      final produto = Produto(
        nome: 'Produto Teste',
        codigo: 'TESTE-001',
        preco: 100.00,
        estoque: 50,
        descricao: 'Produto para teste',
        categoria: 'Teste',
      );

      final id = await produtoManager.inserir(produto);

      // Act
      await produtoManager.atualizarEstoque(id, 75);

      // Assert
      final produtoAtualizado = await produtoManager.consultarPorId(id);
      expect(produtoAtualizado!.estoque, equals(75));
    });

    test('deve contar o total de produtos', () async {
      // Arrange
      final produto1 = Produto(
        nome: 'Produto 1',
        codigo: 'PROD-001',
        preco: 100.00,
        estoque: 10,
        descricao: 'Produto 1',
        categoria: 'Geral',
      );

      final produto2 = Produto(
        nome: 'Produto 2',
        codigo: 'PROD-002',
        preco: 200.00,
        estoque: 20,
        descricao: 'Produto 2',
        categoria: 'Geral',
      );

      await produtoManager.inserir(produto1);
      await produtoManager.inserir(produto2);

      // Act
      final total = await produtoManager.contarTotal();

      // Assert
      expect(total, equals(2));
    });
  });
}
