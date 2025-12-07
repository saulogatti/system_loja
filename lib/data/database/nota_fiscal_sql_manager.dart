import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/models/item_nota_fiscal.dart';

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
  /// [clienteId] ID do cliente.
  /// Retorna uma lista de notas fiscais do cliente especificado.
  ///
  /// A operação exclui os itens antigos e insere os novos
  /// dentro de uma transação.
  Future<int> atualizar(NotaFiscal notaFiscal) async {
    final db = await _database;

    return await db.transaction((txn) async {
      // Atualiza a nota fiscal
      final Map<String, dynamic> dadosNota = notaFiscal.toJson();
      // Remove campos que não devem ser atualizados
      dadosNota.remove('id');
      dadosNota.remove('itens');
      // Adiciona o valor_total calculado
      dadosNota['valor_total'] = notaFiscal.valorTotal;

      return 1;
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
  ///
  /// Utiliza JOIN para buscar dados do cliente associado.
  Future<NotaFiscal?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNota = await db.rawQuery(
      '''
      SELECT 
        nf.*, 
        c.nome as cliente_nome, 
        c.cpf as cliente_cpf
      FROM ${DatabaseConfig.tableNotasFiscais} nf
      INNER JOIN ${DatabaseConfig.tableClientes} c ON nf.cliente_id = c.id
      WHERE nf.id = ?
      ''',
      [id],
    );

    if (resultadoNota.isEmpty) {
      return null;
    }

    // Busca os itens da nota fiscal com JOIN para dados do produto
    final List<Map<String, dynamic>> resultadoItens = await db.rawQuery(
      '''
      SELECT 
        i.*, 
        p.nome as produto_nome, 
        p.codigo as produto_codigo
      FROM ${DatabaseConfig.tableItensNotaFiscal} i
      INNER JOIN ${DatabaseConfig.tableProdutos} p ON i.produto_id = p.id
      WHERE i.nota_fiscal_id = ?
      ''',
      [id],
    );

    return _mapToNotaFiscal(resultadoNota.first, resultadoItens);
  }

  /// Consulta uma nota fiscal pelo número
  ///
  /// [numeroNota] Número da nota fiscal a ser consultada.
  /// Retorna a NotaFiscal encontrada ou null se não existir.
  ///
  /// Utiliza JOIN para buscar dados do cliente associado.
  Future<NotaFiscal?> consultarPorNumero(String numeroNota) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultadoNota = await db.rawQuery(
      '''
      SELECT 
        nf.*, 
        c.nome as cliente_nome, 
        c.cpf as cliente_cpf
      FROM ${DatabaseConfig.tableNotasFiscais} nf
      INNER JOIN ${DatabaseConfig.tableClientes} c ON nf.cliente_id = c.id
      WHERE nf.numero_nota = ?
      ''',
      [numeroNota],
    );

    if (resultadoNota.isEmpty) {
      return null;
    }

    final int notaId = resultadoNota.first['id'] as int;

    // Busca os itens da nota fiscal com JOIN para dados do produto
    final List<Map<String, dynamic>> resultadoItens = await db.rawQuery(
      '''
      SELECT 
        i.*, 
        p.nome as produto_nome, 
        p.codigo as produto_codigo
      FROM ${DatabaseConfig.tableItensNotaFiscal} i
      INNER JOIN ${DatabaseConfig.tableProdutos} p ON i.produto_id = p.id
      WHERE i.nota_fiscal_id = ?
      ''',
      [notaId],
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

  /// Remove uma nota fiscal do banco de dados
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

    // Busca todos os itens de uma vez para evitar N+1 queries
    // Este é o método mais eficiente quando precisamos de TODOS os dados
    final List<Map<String, dynamic>> todosItens = await db.rawQuery('''
      SELECT 
        i.*, 
        p.nome as produto_nome, 
        p.codigo as produto_codigo
      FROM ${DatabaseConfig.tableItensNotaFiscal} i
      INNER JOIN ${DatabaseConfig.tableProdutos} p ON i.produto_id = p.id
      ORDER BY i.nota_fiscal_id, i.id
      ''');

    // Agrupa itens por nota_fiscal_id
    final Map<int, List<Map<String, dynamic>>> itensPorNota = {};
    for (final itemMap in todosItens) {
      final notaId = itemMap['nota_fiscal_id'] as int;
      itensPorNota.putIfAbsent(notaId, () => []).add(itemMap);
    }

    // Cria as notas fiscais com seus itens
    final List<NotaFiscal> notas = [];
    for (final notaMap in resultadoNotas) {
      final notaId = notaMap['id'] as int;
      final itens = itensPorNota[notaId] ?? [];
      notas.add(_mapToNotaFiscal(notaMap, itens));
    }

    return notas;
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
      return ItemNotaFiscal.fromJson(itemMap);
    }).toList();

    // Prepara o map da nota com os itens para desserialização
    final notaComItens = {
      ...notaMap,
      'itens': itens.map((item) => item.toJson()).toList(),
    };

    return NotaFiscal.fromJson(notaComItens);
  }
}
