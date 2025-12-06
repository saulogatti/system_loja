import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/database/produto_sql_manager.dart';

/// Testes simplificados do ProdutoSqlManager
///
/// Valida que a refatoração para usar toJson/fromJson funciona corretamente.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  TestWidgetsFlutterBinding.ensureInitialized();
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late ProdutoSqlManager produtoManager;

  setUp(() async {
    // Reset da instância do banco antes de cada teste
    DatabaseHelper.resetInstance();
    produtoManager = ProdutoSqlManager();
  });

  tearDown(() async {
    // Limpa o banco após cada teste
    final dbHelper = DatabaseHelper();
    try {
      await dbHelper.deleteDatabase();
    } catch (e) {
      // Ignora erros de limpeza
    }
    DatabaseHelper.resetInstance();
  });

  group('ProdutoSqlManager - Refatoração toJson/fromJson', () {
    test('deve inserir e recuperar produto usando toJson/fromJson', () async {
      // Arrange
      final produto = Produto(
        id: 0,
        nome: 'Notebook Dell',
        codigo: 'NOTE-001',
        preco: 3500.00,
        estoque: 10,
        descricao: 'Notebook Dell Inspiron 15',
        categoria: 'Eletrônicos',
      );

      // Act
      final id = await produtoManager.inserir(produto);
      final produtoRecuperado = await produtoManager.consultarPorId(id);

      // Assert
      expect(produtoRecuperado, isNotNull);
      expect(produtoRecuperado!.nome, equals('Notebook Dell'));
      expect(produtoRecuperado.codigo, equals('NOTE-001'));
      expect(produtoRecuperado.preco, equals(3500.00));
      expect(produtoRecuperado.estoque, equals(10));
      expect(produtoRecuperado.descricao, equals('Notebook Dell Inspiron 15'));
      expect(produtoRecuperado.categoria, equals('Eletrônicos'));
    });

    test('deve atualizar produto usando toJson', () async {
      // Arrange
      final produto = Produto(
        id: 0,
        nome: 'Mouse',
        codigo: 'MOUSE-001',
        preco: 100.00,
        estoque: 20,
        descricao: 'Mouse sem fio',
        categoria: 'Periféricos',
      );

      final id = await produtoManager.inserir(produto);
      final produtoInserido = await produtoManager.consultarPorId(id);

      // Act - Atualizar o produto
      final produtoAtualizado = Produto(
        id: produtoInserido!.id,
        nome: 'Mouse Gamer',
        codigo: 'MOUSE-001',
        preco: 150.00,
        estoque: 15,
        descricao: 'Mouse gamer RGB',
        categoria: 'Periféricos',
        dataCadastro: produtoInserido.dataCadastro,
      );

      await produtoManager.atualizar(produtoAtualizado);
      final produtoRecuperado = await produtoManager.consultarPorId(id);

      // Assert
      expect(produtoRecuperado, isNotNull);
      expect(produtoRecuperado!.nome, equals('Mouse Gamer'));
      expect(produtoRecuperado.preco, equals(150.00));
      expect(produtoRecuperado.estoque, equals(15));
      expect(produtoRecuperado.descricao, equals('Mouse gamer RGB'));
    });
  });
}
