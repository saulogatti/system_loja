import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import '../../core/models/cliente.dart';
import 'database_config.dart';
import 'database_helper.dart';

/// Gerenciador de operações SQL para Clientes
///
/// Esta classe é responsável por realizar operações CRUD
/// (Create, Read, Update, Delete) de clientes no banco de dados SQLite.
///
/// Utiliza o padrão Repository para abstrair o acesso aos dados.
class ClienteSqlManager {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Construtor que recebe opcionalmente uma instância do DatabaseHelper
  ///
  /// Se não for fornecido, usa a instância singleton padrão.
  ClienteSqlManager({DatabaseHelper? dbHelper}) : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Atualiza um cliente existente no banco de dados
  ///
  /// [cliente] Objeto Cliente com os dados atualizados.
  /// O cliente deve ter um ID válido.
  /// Retorna o número de linhas afetadas.
  Future<int> atualizar(Cliente cliente) async {
    final db = await _database;

    final Map<String, dynamic> dados = {
      'nome': cliente.nome,
      'cpf': cliente.cpf,
      'email': cliente.email,
      'telefone': cliente.telefone,
      'endereco': cliente.endereco,
      'data_cadastro': cliente.dataCadastro.toIso8601String(),
    };

    return await db.update(DatabaseConfig.tableClientes, dados, where: 'id = ?', whereArgs: [cliente.id]);
  }

  /// Busca clientes por nome (busca parcial)
  ///
  /// [nome] Texto a ser buscado no nome do cliente.
  /// Retorna uma lista de clientes cujo nome contém o texto buscado.
  Future<List<Cliente>> buscarPorNome(String nome) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableClientes,
      where: 'nome LIKE ?',
      whereArgs: ['%$nome%'],
      orderBy: 'nome ASC',
    );

    return resultado.map(_mapToCliente).toList();
  }

  /// Consulta um cliente pelo CPF
  ///
  /// [cpf] CPF do cliente a ser consultado.
  /// Retorna o Cliente encontrado ou null se não existir.
  Future<Cliente?> consultarPorCpf(String cpf) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableClientes,
      where: 'cpf = ?',
      whereArgs: [cpf],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToCliente(resultado.first);
  }

  /// Consulta um cliente pelo ID
  ///
  /// [id] ID do cliente a ser consultado.
  /// Retorna o Cliente encontrado ou null se não existir.
  Future<Cliente?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableClientes,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToCliente(resultado.first);
  }

  /// Conta o número total de clientes cadastrados
  ///
  /// Retorna o número total de clientes no banco de dados.
  Future<int> contarTotal() async {
    final db = await _database;

    final result = await db.rawQuery('SELECT COUNT(*) as total FROM ${DatabaseConfig.tableClientes}');

    return result.first['total'] as int;
  }

  /// Remove um cliente do banco de dados
  ///
  /// [id] ID do cliente a ser removido.
  /// Retorna o número de linhas afetadas.
  Future<int> excluir(int id) async {
    final db = await _database;

    return await db.delete(DatabaseConfig.tableClientes, where: 'id = ?', whereArgs: [id]);
  }

  /// Insere um novo cliente no banco de dados
  ///
  /// [cliente] Objeto Cliente a ser inserido.
  /// Retorna o ID do cliente inserido.
  ///
  /// Lança uma exceção se o CPF já existir no banco.
  Future<int> inserir(Cliente cliente) async {
    final db = await _database;

    final clienteExistente = await consultarPorCpf(cliente.cpf);
    if (clienteExistente != null) {
      throw Exception('CPF já cadastrado: ${cliente.cpf}');
    }

    final Map<String, dynamic> dados = {
      'nome': cliente.nome,
      'cpf': cliente.cpf,
      'email': cliente.email,
      'telefone': cliente.telefone,
      'endereco': cliente.endereco,
      'data_cadastro': cliente.dataCadastro.toIso8601String(),
    };

    return await db.insert(DatabaseConfig.tableClientes, dados, conflictAlgorithm: ConflictAlgorithm.abort);
  }

  /// Lista todos os clientes do banco de dados
  ///
  /// Retorna uma lista com todos os clientes cadastrados.
  /// A lista pode estar vazia se não houver clientes.
  Future<List<Cliente>> listarTodos() async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableClientes,
      orderBy: 'nome ASC',
    );

    return resultado.map(_mapToCliente).toList();
  }

  /// Converte um Map do banco de dados para um objeto Cliente
  ///
  /// [map] Map com os dados do cliente do banco.
  /// Retorna um objeto Cliente com os dados do map.
  Cliente _mapToCliente(Map<String, dynamic> map) {
    return Cliente(
      id: map['id'] as int,
      nome: map['nome'] as String,
      cpf: map['cpf'] as String,
      email: (map['email'] as String?) ?? '',
      telefone: (map['telefone'] as String?) ?? '',
      endereco: (map['endereco'] as String?) ?? '',
      dataCadastro: DateTime.parse(map['data_cadastro'] as String),
    );
  }
}
