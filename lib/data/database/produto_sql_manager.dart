import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/models/produto.dart';
import 'database_config.dart';
import 'database_helper.dart';

/// Gerenciador de operações SQL para Produtos
///
/// Esta classe é responsável por realizar operações CRUD
/// (Create, Read, Update, Delete) de produtos no banco de dados SQLite.
///
/// Utiliza o padrão Repository para abstrair o acesso aos dados.
class ProdutoSqlManager {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Construtor que recebe opcionalmente uma instância do DatabaseHelper
  ///
  /// Se não for fornecido, usa a instância singleton padrão.
  ProdutoSqlManager({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Insere um novo produto no banco de dados
  ///
  /// [produto] Objeto Produto a ser inserido.
  /// Retorna o ID do produto inserido.
  ///
  /// Lança uma exceção se o código já existir no banco.
  Future<int> inserir(Produto produto) async {
    final db = await _database;

    final produtoExistente = await consultarPorCodigo(produto.codigo);
    if (produtoExistente != null) {
      throw Exception('Código de produto já cadastrado: ${produto.codigo}');
    }

    final Map<String, dynamic> dados = {
      'nome': produto.nome,
      'codigo': produto.codigo,
      'preco': produto.preco,
      'estoque': produto.estoque,
      'descricao': produto.descricao,
      'categoria': produto.categoria,
      'data_cadastro': produto.dataCadastro.toIso8601String(),
    };

    return await db.insert(
      DatabaseConfig.tableProdutos,
      dados,
      conflictAlgorithm: ConflictAlgorithm.abort,
    );
  }

  /// Atualiza um produto existente no banco de dados
  ///
  /// [produto] Objeto Produto com os dados atualizados.
  /// O produto deve ter um ID válido.
  /// Retorna o número de linhas afetadas.
  Future<int> atualizar(Produto produto) async {
    if (produto.id == null) {
      throw Exception('ID do produto não pode ser nulo para atualização');
    }

    final db = await _database;

    final Map<String, dynamic> dados = {
      'nome': produto.nome,
      'codigo': produto.codigo,
      'preco': produto.preco,
      'estoque': produto.estoque,
      'descricao': produto.descricao,
      'categoria': produto.categoria,
      'data_cadastro': produto.dataCadastro.toIso8601String(),
    };

    return await db.update(
      DatabaseConfig.tableProdutos,
      dados,
      where: 'id = ?',
      whereArgs: [produto.id],
    );
  }

  /// Remove um produto do banco de dados
  ///
  /// [id] ID do produto a ser removido.
  /// Retorna o número de linhas afetadas.
  Future<int> excluir(int id) async {
    final db = await _database;

    return await db.delete(
      DatabaseConfig.tableProdutos,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Consulta um produto pelo ID
  ///
  /// [id] ID do produto a ser consultado.
  /// Retorna o Produto encontrado ou null se não existir.
  Future<Produto?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToProduto(resultado.first);
  }

  /// Consulta um produto pelo código
  ///
  /// [codigo] Código do produto a ser consultado.
  /// Retorna o Produto encontrado ou null se não existir.
  Future<Produto?> consultarPorCodigo(String codigo) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      where: 'codigo = ?',
      whereArgs: [codigo],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToProduto(resultado.first);
  }

  /// Lista todos os produtos do banco de dados
  ///
  /// Retorna uma lista com todos os produtos cadastrados.
  /// A lista pode estar vazia se não houver produtos.
  Future<List<Produto>> listarTodos() async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      orderBy: 'nome ASC',
    );

    return resultado.map((map) => _mapToProduto(map)).toList();
  }

  /// Busca produtos por nome (busca parcial)
  ///
  /// [nome] Texto a ser buscado no nome do produto.
  /// Retorna uma lista de produtos cujo nome contém o texto buscado.
  Future<List<Produto>> buscarPorNome(String nome) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      where: 'nome LIKE ?',
      whereArgs: ['%$nome%'],
      orderBy: 'nome ASC',
    );

    return resultado.map((map) => _mapToProduto(map)).toList();
  }

  /// Busca produtos por categoria
  ///
  /// [categoria] Categoria dos produtos a serem buscados.
  /// Retorna uma lista de produtos da categoria especificada.
  Future<List<Produto>> buscarPorCategoria(String categoria) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      where: 'categoria = ?',
      whereArgs: [categoria],
      orderBy: 'nome ASC',
    );

    return resultado.map((map) => _mapToProduto(map)).toList();
  }

  /// Lista produtos com estoque abaixo de um valor mínimo
  ///
  /// [quantidadeMinima] Quantidade mínima de estoque.
  /// Retorna uma lista de produtos com estoque abaixo do mínimo.
  Future<List<Produto>> listarComEstoqueBaixo(int quantidadeMinima) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableProdutos,
      where: 'estoque < ?',
      whereArgs: [quantidadeMinima],
      orderBy: 'estoque ASC',
    );

    return resultado.map((map) => _mapToProduto(map)).toList();
  }

  /// Atualiza o estoque de um produto
  ///
  /// [id] ID do produto.
  /// [quantidade] Nova quantidade de estoque.
  /// Retorna o número de linhas afetadas.
  Future<int> atualizarEstoque(int id, int quantidade) async {
    final db = await _database;

    return await db.update(
      DatabaseConfig.tableProdutos,
      {'estoque': quantidade},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Conta o número total de produtos cadastrados
  ///
  /// Retorna o número total de produtos no banco de dados.
  Future<int> contarTotal() async {
    final db = await _database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM ${DatabaseConfig.tableProdutos}',
    );

    return result.first['total'] as int;
  }

  /// Converte um Map do banco de dados para um objeto Produto
  ///
  /// [map] Map com os dados do produto do banco.
  /// Retorna um objeto Produto com os dados do map.
  Produto _mapToProduto(Map<String, dynamic> map) {
    return Produto(
      id: map['id'] as int,
      nome: map['nome'] as String,
      codigo: map['codigo'] as String,
      preco: (map['preco'] as num).toDouble(),
      estoque: map['estoque'] as int,
      descricao: (map['descricao'] as String?) ?? '',
      categoria: (map['categoria'] as String?) ?? '',
      dataCadastro: DateTime.parse(map['data_cadastro'] as String),
    );
  }
}
