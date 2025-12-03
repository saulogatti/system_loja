import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/models/nota_fiscal.dart';
import 'database_config.dart';
import 'database_helper.dart';

/// Gerenciador de operações SQL para Notas Fiscais
///
/// Esta classe é responsável por realizar operações CRUD
/// (Create, Read, Update, Delete) de notas fiscais no banco de dados SQLite.
///
/// Utiliza o padrão Repository para abstrair o acesso aos dados.
/// Gerencia também os itens da nota fiscal em uma tabela relacionada.
class NotaFiscalSqlManager {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Construtor que recebe opcionalmente uma instância do DatabaseHelper
  ///
  /// Se não for fornecido, usa a instância singleton padrão.
  NotaFiscalSqlManager({DatabaseHelper? dbHelper})
    : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Atualiza uma nota fiscal existente no banco de dados
  ///
  /// [notaFiscal] Objeto NotaFiscal com os dados atualizados.
  /// A nota fiscal deve ter um ID válido.
  /// Retorna o número de linhas afetadas.
  ///
  /// A operação exclui os itens antigos e insere os novos
  /// dentro de uma transação.
  Future<int> atualizar(NotaFiscal notaFiscal) async {
    if (notaFiscal.id == null) {
      throw Exception('ID da nota fiscal não pode ser nulo para atualização');
    }

    final db = await _database;

    return await db.transaction((txn) async {
      // Atualiza a nota fiscal
      final Map<String, dynamic> dadosNota = {
        'numero_nota': notaFiscal.numeroNota,
        'cliente_id': notaFiscal.clienteId,
        'cliente_nome': notaFiscal.clienteNome,
        'cliente_cpf': notaFiscal.clienteCpf,
        'valor_total': notaFiscal.valorTotal,
        'forma_pagamento': notaFiscal.formaPagamento,
        'data_emissao': notaFiscal.dataEmissao.toIso8601String(),
      };

      final linhasAfetadas = await txn.update(
        DatabaseConfig.tableNotasFiscais,
        dadosNota,
        where: 'id = ?',
        whereArgs: [notaFiscal.id],
      );

      // Remove itens antigos
      await txn.delete(
        DatabaseConfig.tableItensNotaFiscal,
        where: 'nota_fiscal_id = ?',
        whereArgs: [notaFiscal.id],
      );

      // Insere novos itens
      for (final item in notaFiscal.itens) {
        final Map<String, dynamic> dadosItem = {
          'nota_fiscal_id': notaFiscal.id,
          'produto_id': item.produtoId,
          'produto_nome': item.produtoNome,
          'produto_codigo': item.produtoCodigo,
          'quantidade': item.quantidade,
          'preco_unitario': item.precoUnitario,
          'valor_total': item.valorTotal,
        };

        await txn.insert(
          DatabaseConfig.tableItensNotaFiscal,
          dadosItem,
          conflictAlgorithm: ConflictAlgorithm.abort,
        );
      }

      return linhasAfetadas;
    });
  }

  /// Busca notas fiscais por cliente
  ///
  /// [clienteId] ID do cliente.
  /// Retorna uma lista de notas fiscais do cliente especificado.
  Future<List<NotaFiscal>> buscarPorCliente(int clienteId) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNotas = await db.query(
      DatabaseConfig.tableNotasFiscais,
      where: 'cliente_id = ?',
      whereArgs: [clienteId],
      orderBy: 'data_emissao DESC',
    );

    final List<NotaFiscal> notas = [];

    for (final notaMap in resultadoNotas) {
      final int notaId = notaMap['id'] as int;

      final List<Map<String, dynamic>> resultadoItens = await db.query(
        DatabaseConfig.tableItensNotaFiscal,
        where: 'nota_fiscal_id = ?',
        whereArgs: [notaId],
      );

      notas.add(_mapToNotaFiscal(notaMap, resultadoItens));
    }

    return notas;
  }

  /// Busca notas fiscais por período
  ///
  /// [dataInicio] Data inicial do período.
  /// [dataFim] Data final do período.
  /// Retorna uma lista de notas fiscais emitidas no período.
  Future<List<NotaFiscal>> buscarPorPeriodo(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNotas = await db.query(
      DatabaseConfig.tableNotasFiscais,
      where: 'data_emissao BETWEEN ? AND ?',
      whereArgs: [dataInicio.toIso8601String(), dataFim.toIso8601String()],
      orderBy: 'data_emissao DESC',
    );

    final List<NotaFiscal> notas = [];

    for (final notaMap in resultadoNotas) {
      final int notaId = notaMap['id'] as int;

      final List<Map<String, dynamic>> resultadoItens = await db.query(
        DatabaseConfig.tableItensNotaFiscal,
        where: 'nota_fiscal_id = ?',
        whereArgs: [notaId],
      );

      notas.add(_mapToNotaFiscal(notaMap, resultadoItens));
    }

    return notas;
  }

  /// Calcula o valor total de vendas em um período
  ///
  /// [dataInicio] Data inicial do período.
  /// [dataFim] Data final do período.
  /// Retorna o valor total de vendas no período.
  Future<double> calcularTotalVendasPeriodo(
    DateTime dataInicio,
    DateTime dataFim,
  ) async {
    final db = await _database;

    final result = await db.rawQuery(
      '''
      SELECT COALESCE(SUM(valor_total), 0) as total 
      FROM ${DatabaseConfig.tableNotasFiscais}
      WHERE data_emissao BETWEEN ? AND ?
      ''',
      [dataInicio.toIso8601String(), dataFim.toIso8601String()],
    );

    return (result.first['total'] as num).toDouble();
  }

  /// Consulta uma nota fiscal pelo ID
  ///
  /// [id] ID da nota fiscal a ser consultada.
  /// Retorna a NotaFiscal encontrada ou null se não existir.
  Future<NotaFiscal?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNota = await db.query(
      DatabaseConfig.tableNotasFiscais,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultadoNota.isEmpty) {
      return null;
    }

    // Busca os itens da nota fiscal
    final List<Map<String, dynamic>> resultadoItens = await db.query(
      DatabaseConfig.tableItensNotaFiscal,
      where: 'nota_fiscal_id = ?',
      whereArgs: [id],
    );

    return _mapToNotaFiscal(resultadoNota.first, resultadoItens);
  }

  /// Consulta uma nota fiscal pelo número
  ///
  /// [numeroNota] Número da nota fiscal a ser consultada.
  /// Retorna a NotaFiscal encontrada ou null se não existir.
  Future<NotaFiscal?> consultarPorNumero(String numeroNota) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNota = await db.query(
      DatabaseConfig.tableNotasFiscais,
      where: 'numero_nota = ?',
      whereArgs: [numeroNota],
    );

    if (resultadoNota.isEmpty) {
      return null;
    }

    final int notaId = resultadoNota.first['id'] as int;

    // Busca os itens da nota fiscal
    final List<Map<String, dynamic>> resultadoItens = await db.query(
      DatabaseConfig.tableItensNotaFiscal,
      where: 'nota_fiscal_id = ?',
      whereArgs: [notaId],
    );

    return _mapToNotaFiscal(resultadoNota.first, resultadoItens);
  }

  /// Conta o número total de notas fiscais cadastradas
  ///
  /// Retorna o número total de notas fiscais no banco de dados.
  Future<int> contarTotal() async {
    final db = await _database;

    final result = await db.rawQuery(
      'SELECT COUNT(*) as total FROM ${DatabaseConfig.tableNotasFiscais}',
    );

    return result.first['total'] as int;
  }

  ///
  /// [id] ID da nota fiscal a ser removida.
  /// Retorna o número de linhas afetadas.
  ///
  /// Os itens são removidos automaticamente pelo CASCADE definido na FK.
  Future<int> excluir(int id) async {
    final db = await _database;

    return await db.delete(
      DatabaseConfig.tableNotasFiscais,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  /// Insere uma nova nota fiscal no banco de dados
  ///
  /// [notaFiscal] Objeto NotaFiscal a ser inserido.
  /// Retorna o ID da nota fiscal inserida.
  ///
  /// A operação é realizada em uma transação para garantir
  /// que a nota e seus itens sejam inseridos de forma atômica.
  ///
  /// Lança uma exceção se o número da nota já existir.
  Future<int> inserir(NotaFiscal notaFiscal) async {
    final db = await _database;

    final notaExistente = await consultarPorNumero(notaFiscal.numeroNota);
    if (notaExistente != null) {
      throw Exception(
        'Número de nota fiscal já cadastrado: ${notaFiscal.numeroNota}',
      );
    }

    return await db.transaction((txn) async {
      // Insere a nota fiscal
      final Map<String, dynamic> dadosNota = {
        'numero_nota': notaFiscal.numeroNota,
        'cliente_id': notaFiscal.clienteId,
        'cliente_nome': notaFiscal.clienteNome,
        'cliente_cpf': notaFiscal.clienteCpf,
        'valor_total': notaFiscal.valorTotal,
        'forma_pagamento': notaFiscal.formaPagamento,
        'data_emissao': notaFiscal.dataEmissao.toIso8601String(),
      };

      final notaFiscalId = await txn.insert(
        DatabaseConfig.tableNotasFiscais,
        dadosNota,
        conflictAlgorithm: ConflictAlgorithm.abort,
      );

      // Insere os itens da nota fiscal
      for (final item in notaFiscal.itens) {
        final Map<String, dynamic> dadosItem = {
          'nota_fiscal_id': notaFiscalId,
          'produto_id': item.produtoId,
          'produto_nome': item.produtoNome,
          'produto_codigo': item.produtoCodigo,
          'quantidade': item.quantidade,
          'preco_unitario': item.precoUnitario,
          'valor_total': item.valorTotal,
        };

        await txn.insert(
          DatabaseConfig.tableItensNotaFiscal,
          dadosItem,
          conflictAlgorithm: ConflictAlgorithm.abort,
        );
      }

      return notaFiscalId;
    });
  }

  /// Lista todas as notas fiscais do banco de dados
  ///
  /// Retorna uma lista com todas as notas fiscais cadastradas.
  /// A lista pode estar vazia se não houver notas fiscais.
  Future<List<NotaFiscal>> listarTodas() async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNotas = await db.query(
      DatabaseConfig.tableNotasFiscais,
      orderBy: 'data_emissao DESC',
    );

    if (resultadoNotas.isEmpty) {
      return [];
    }

    final notaIds = resultadoNotas.map((n) => n['id'] as int).toList();

    final List<Map<String, dynamic>> resultadoItens = await db.query(
      DatabaseConfig.tableItensNotaFiscal,
      where:
          'nota_fiscal_id IN (${List.filled(notaIds.length, '?').join(',')})',
      whereArgs: notaIds,
    );

    final Map<int, List<Map<String, dynamic>>> itensPorNota = {};
    for (final item in resultadoItens) {
      final notaId = item['nota_fiscal_id'] as int;
      (itensPorNota[notaId] ??= []).add(item);
    }

    return resultadoNotas.map((notaMap) {
      final notaId = notaMap['id'] as int;
      final itens = itensPorNota[notaId] ?? [];
      return _mapToNotaFiscal(notaMap, itens);
    }).toList();
  }

  /// Converte um Map do banco de dados para um objeto NotaFiscal
  ///
  /// [notaMap] Map com os dados da nota fiscal do banco.
  /// [itensMap] Lista de Maps com os itens da nota fiscal.
  /// Retorna um objeto NotaFiscal com os dados do map.
  NotaFiscal _mapToNotaFiscal(
    Map<String, dynamic> notaMap,
    List<Map<String, dynamic>> itensMap,
  ) {
    final List<ItemNotaFiscal> itens = itensMap.map((itemMap) {
      return ItemNotaFiscal(
        produtoId: itemMap['produto_id'] as int,
        produtoNome: itemMap['produto_nome'] as String,
        produtoCodigo: itemMap['produto_codigo'] as String,
        quantidade: itemMap['quantidade'] as int,
        precoUnitario: (itemMap['preco_unitario'] as num).toDouble(),
      );
    }).toList();

    return NotaFiscal(
      id: notaMap['id'] as int,
      numeroNota: notaMap['numero_nota'] as String,
      clienteId: notaMap['cliente_id'] as int,
      clienteNome: notaMap['cliente_nome'] as String,
      clienteCpf: notaMap['cliente_cpf'] as String,
      itens: itens,
      formaPagamento: notaMap['forma_pagamento'] as String,
      dataEmissao: DateTime.parse(notaMap['data_emissao'] as String),
    );
  }
}
