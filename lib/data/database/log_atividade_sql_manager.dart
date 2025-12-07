import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/models/log_atividade.dart';
import 'database_config.dart';
import 'database_helper.dart';

/// Gerenciador de operações SQL para Logs de Atividade
///
/// Esta classe é responsável por realizar operações CRUD
/// (Create, Read, Update, Delete) de logs de atividade no banco de dados SQLite.
///
/// Utiliza o padrão Repository para abstrair o acesso aos dados.
class LogAtividadeSqlManager {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Construtor que recebe opcionalmente uma instância do DatabaseHelper
  ///
  /// Se não for fornecido, usa a instância singleton padrão.
  LogAtividadeSqlManager({DatabaseHelper? dbHelper}) : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Insere um novo log de atividade no banco de dados
  ///
  /// [log] Objeto LogAtividade a ser inserido.
  /// Retorna o ID do log inserido.
  Future<int> inserir(LogAtividade log) async {
    final db = await _database;

    final Map<String, dynamic> dados = _logParaDadosDb(log);

    return await db.insert(DatabaseConfig.tableLogsAtividade, dados);
  }

  /// Consulta um log pelo ID
  ///
  /// [id] ID do log a ser consultado.
  /// Retorna o LogAtividade encontrado ou null se não existir.
  Future<LogAtividade?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableLogsAtividade,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToLogAtividade(resultado.first);
  }

  /// Lista todos os logs
  ///
  /// [orderBy] Campo para ordenação. Padrão: 'data_hora DESC'.
  /// [limit] Limite de registros retornados.
  /// Retorna uma lista com todos os logs cadastrados.
  Future<List<LogAtividade>> listarTodos({String orderBy = 'data_hora DESC', int? limit}) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableLogsAtividade,
      orderBy: orderBy,
      limit: limit,
    );

    return resultado.map(_mapToLogAtividade).toList();
  }

  /// Lista logs de um usuário específico
  ///
  /// [usuarioId] ID do usuário.
  /// [limit] Limite de registros retornados.
  /// Retorna uma lista de logs do usuário especificado.
  Future<List<LogAtividade>> listarPorUsuario(int usuarioId, {int? limit}) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableLogsAtividade,
      where: 'usuario_id = ?',
      whereArgs: [usuarioId],
      orderBy: 'data_hora DESC',
      limit: limit,
    );

    return resultado.map(_mapToLogAtividade).toList();
  }

  /// Lista logs de uma entidade específica
  ///
  /// [entidade] Nome da entidade.
  /// [entidadeId] ID da entidade (opcional).
  /// [limit] Limite de registros retornados.
  /// Retorna uma lista de logs da entidade especificada.
  Future<List<LogAtividade>> listarPorEntidade(String entidade, {int? entidadeId, int? limit}) async {
    final db = await _database;

    List<Map<String, dynamic>> resultado;
    if (entidadeId != null) {
      resultado = await db.query(
        DatabaseConfig.tableLogsAtividade,
        where: 'entidade = ? AND entidade_id = ?',
        whereArgs: [entidade, entidadeId],
        orderBy: 'data_hora DESC',
        limit: limit,
      );
    } else {
      resultado = await db.query(
        DatabaseConfig.tableLogsAtividade,
        where: 'entidade = ?',
        whereArgs: [entidade],
        orderBy: 'data_hora DESC',
        limit: limit,
      );
    }

    return resultado.map(_mapToLogAtividade).toList();
  }

  /// Lista logs por tipo de ação
  ///
  /// [tipoAcao] Tipo de ação para filtrar.
  /// [limit] Limite de registros retornados.
  /// Retorna uma lista de logs do tipo de ação especificado.
  Future<List<LogAtividade>> listarPorTipoAcao(TipoAcao tipoAcao, {int? limit}) async {
    final db = await _database;

    final String tipoAcaoStr = _tipoAcaoToString(tipoAcao);

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableLogsAtividade,
      where: 'tipo_acao = ?',
      whereArgs: [tipoAcaoStr],
      orderBy: 'data_hora DESC',
      limit: limit,
    );

    return resultado.map(_mapToLogAtividade).toList();
  }

  /// Lista logs por período
  ///
  /// [dataInicio] Data de início do período.
  /// [dataFim] Data de fim do período.
  /// [limit] Limite de registros retornados.
  /// Retorna uma lista de logs do período especificado.
  Future<List<LogAtividade>> listarPorPeriodo(DateTime dataInicio, DateTime dataFim, {int? limit}) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableLogsAtividade,
      where: 'data_hora >= ? AND data_hora <= ?',
      whereArgs: [dataInicio.toIso8601String(), dataFim.toIso8601String()],
      orderBy: 'data_hora DESC',
      limit: limit,
    );

    return resultado.map(_mapToLogAtividade).toList();
  }

  /// Conta o número total de logs
  ///
  /// Retorna o número total de logs no banco de dados.
  Future<int> contarTotal() async {
    final db = await _database;

    final resultado = await db.rawQuery('SELECT COUNT(*) as count FROM ${DatabaseConfig.tableLogsAtividade}');

    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  /// Conta logs por usuário
  ///
  /// [usuarioId] ID do usuário.
  /// Retorna o número de logs do usuário especificado.
  Future<int> contarPorUsuario(int usuarioId) async {
    final db = await _database;

    final resultado = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseConfig.tableLogsAtividade} WHERE usuario_id = ?',
      [usuarioId],
    );

    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  /// Deleta logs antigos
  ///
  /// [dataLimite] Data limite - logs anteriores serão deletados.
  /// Retorna o número de linhas afetadas.
  Future<int> deletarAntigos(DateTime dataLimite) async {
    final db = await _database;

    return await db.delete(
      DatabaseConfig.tableLogsAtividade,
      where: 'data_hora < ?',
      whereArgs: [dataLimite.toIso8601String()],
    );
  }

  /// Converte um Map do banco de dados para um objeto LogAtividade
  LogAtividade _mapToLogAtividade(Map<String, dynamic> map) {
    final tipoAcaoStr = map['tipo_acao'] as String;
    final tipoAcao = _stringToTipoAcao(tipoAcaoStr);

    return LogAtividade(
      id: map['id'] as int,
      tipoAcao: tipoAcao,
      entidade: map['entidade'] as String,
      entidadeId: map['entidade_id'] as int?,
      usuarioId: map['usuario_id'] as int,
      usuarioNome: map['usuario_nome'] as String,
      dataHora: DateTime.parse(map['data_hora'] as String),
      detalhes: map['detalhes'] as String? ?? '',
    );
  }

  /// Converte um objeto LogAtividade para um Map do banco de dados
  Map<String, dynamic> _logParaDadosDb(LogAtividade log) {
    return {
      'id': log.id,
      'tipo_acao': _tipoAcaoToString(log.tipoAcao),
      'entidade': log.entidade,
      'entidade_id': log.entidadeId,
      'usuario_id': log.usuarioId,
      'usuario_nome': log.usuarioNome,
      'data_hora': log.dataHora.toIso8601String(),
      'detalhes': log.detalhes,
    };
  }

  /// Converte TipoAcao para String
  String _tipoAcaoToString(TipoAcao tipoAcao) {
    switch (tipoAcao) {
      case TipoAcao.criar:
        return 'CRIAR';
      case TipoAcao.ler:
        return 'LER';
      case TipoAcao.atualizar:
        return 'ATUALIZAR';
      case TipoAcao.deletar:
        return 'DELETAR';
    }
  }

  /// Converte String para TipoAcao
  TipoAcao _stringToTipoAcao(String tipoAcaoStr) {
    switch (tipoAcaoStr) {
      case 'CRIAR':
        return TipoAcao.criar;
      case 'LER':
        return TipoAcao.ler;
      case 'ATUALIZAR':
        return TipoAcao.atualizar;
      case 'DELETAR':
        return TipoAcao.deletar;
      default:
        return TipoAcao.criar;
    }
  }
}
