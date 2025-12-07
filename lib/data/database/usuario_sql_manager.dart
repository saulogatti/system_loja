import 'package:sqflite/sqflite.dart';

import '../../core/models/extensions/nivel_permissao_extension.dart';
import '../../core/models/usuario.dart';
import 'database_config.dart';
import 'database_helper.dart';

/// Gerenciador de operações SQL para Usuários
///
/// Esta classe é responsável por realizar operações CRUD
/// (Create, Read, Update, Delete) de usuários no banco de dados SQLite.
///
/// Utiliza o padrão Repository para abstrair o acesso aos dados.
class UsuarioSqlManager {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Construtor que recebe opcionalmente uma instância do DatabaseHelper
  ///
  /// Se não for fornecido, usa a instância singleton padrão.
  UsuarioSqlManager({DatabaseHelper? dbHelper})
      : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Atualiza um usuário existente no banco de dados
  ///
  /// [usuario] Objeto Usuario com os dados atualizados.
  /// O usuário deve ter um ID válido.
  /// Retorna o número de linhas afetadas.
  Future<int> atualizar(Usuario usuario) async {
    final db = await _database;

    final Map<String, dynamic> dados = _usuarioParaDadosDb(usuario);

    return await db.update(DatabaseConfig.tableUsuarios, dados,
        where: 'id = ?', whereArgs: [usuario.id]);
  }

  /// Consulta um usuário pelo email
  ///
  /// [email] Email do usuário a ser consultado.
  /// Retorna o Usuario encontrado ou null se não existir.
  Future<Usuario?> consultarPorEmail(String email) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableUsuarios,
      where: 'LOWER(email) = LOWER(?)',
      whereArgs: [email],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToUsuario(resultado.first);
  }

  /// Consulta um usuário pelo ID
  ///
  /// [id] ID do usuário a ser consultado.
  /// Retorna o Usuario encontrado ou null se não existir.
  Future<Usuario?> consultarPorId(int id) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableUsuarios,
      where: 'id = ?',
      whereArgs: [id],
    );

    if (resultado.isEmpty) {
      return null;
    }

    return _mapToUsuario(resultado.first);
  }

  /// Conta o número de usuários por nível de permissão
  ///
  /// [nivelPermissao] Nível de permissão para filtrar.
  /// Retorna o número de usuários com o nível de permissão especificado.
  Future<int> contarPorNivelPermissao(NivelPermissao nivelPermissao) async {
    final db = await _database;

    final resultado = await db.rawQuery(
      'SELECT COUNT(*) as count FROM ${DatabaseConfig.tableUsuarios} WHERE nivel_permissao = ?',
      [nivelPermissao.toStringValue()],
    );

    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  /// Conta o número total de usuários cadastrados
  ///
  /// Retorna o número total de usuários no banco de dados.
  Future<int> contarTotal() async {
    final db = await _database;

    final resultado = await db.rawQuery(
        'SELECT COUNT(*) as count FROM ${DatabaseConfig.tableUsuarios}');

    return Sqflite.firstIntValue(resultado) ?? 0;
  }

  /// Deleta um usuário do banco de dados
  ///
  /// [id] ID do usuário a ser deletado.
  /// Retorna o número de linhas afetadas.
  Future<int> deletar(int id) async {
    final db = await _database;

    return await db
        .delete(DatabaseConfig.tableUsuarios, where: 'id = ?', whereArgs: [id]);
  }

  /// Insere um novo usuário no banco de dados
  ///
  /// [usuario] Objeto Usuario a ser inserido.
  /// Retorna o ID do usuário inserido.
  Future<int> inserir(Usuario usuario) async {
    final db = await _database;

    final Map<String, dynamic> dados = _usuarioParaDadosDb(usuario);

    return await db.insert(DatabaseConfig.tableUsuarios, dados);
  }

  /// Lista usuários por nível de permissão
  ///
  /// [nivelPermissao] Nível de permissão para filtrar.
  /// Retorna uma lista de usuários com o nível de permissão especificado.
  Future<List<Usuario>> listarPorNivelPermissao(
      NivelPermissao nivelPermissao) async {
    final db = await _database;

    final List<Map<String, dynamic>> resultado = await db.query(
      DatabaseConfig.tableUsuarios,
      where: 'nivel_permissao = ?',
      whereArgs: [nivelPermissao.toStringValue()],
      orderBy: 'nome ASC',
    );

    return resultado.map(_mapToUsuario).toList();
  }

  /// Converte um Map do banco de dados para um objeto Usuario
  Usuario _mapToUsuario(Map<String, dynamic> map) {
    return Usuario(
      id: map['id'] as int,
      nome: map['nome'] as String,
      email: map['email'] as String,
      senhaHash: map['senha_hash'] as String,
      nivelPermissao:
          NivelPermissaoExtension.fromString(map['nivel_permissao'] as String),
      dataCadastro: DateTime.parse(map['data_cadastro'] as String),
      dataUltimaAtualizacao:
          DateTime.parse(map['data_ultima_atualizacao'] as String),
    );
  }

  /// Converte um objeto Usuario para um Map do banco de dados
  Map<String, dynamic> _usuarioParaDadosDb(Usuario usuario) {
    return {
      'id': usuario.id,
      'nome': usuario.nome,
      'email': usuario.email,
      'senha_hash': usuario.senhaHash,
      'nivel_permissao': usuario.nivelPermissao.toStringValue(),
      'data_cadastro': usuario.dataCadastro.toIso8601String(),
      'data_ultima_atualizacao':
          usuario.dataUltimaAtualizacao.toIso8601String(),
    };
  }
}
