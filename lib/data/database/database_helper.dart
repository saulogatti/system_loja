import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

import 'database_config.dart';
import 'database_scripts.dart';

/// Gerenciador do banco de dados SQLite
///
/// Implementa o padrão Singleton para garantir uma única instância
/// de conexão com o banco de dados em toda a aplicação.
///
/// Responsável por:
/// - Inicializar o banco de dados
/// - Criar as tabelas e índices
/// - Gerenciar migrações de versão
/// - Fornecer acesso à instância do banco
class DatabaseHelper {
  /// Instância singleton do DatabaseHelper
  static DatabaseHelper? _instance;

  /// Instância do banco de dados SQLite
  static Database? _database;

  /// Fábrica que retorna a instância singleton
  factory DatabaseHelper() {
    _instance ??= DatabaseHelper._internal();
    return _instance!;
  }

  /// Construtor privado para o padrão Singleton
  DatabaseHelper._internal();

  /// Obtém a instância do banco de dados
  ///
  /// Inicializa o banco se ainda não estiver aberto.
  /// Retorna a instância existente se já estiver inicializado.
  Future<Database> get database async {
    if (_database != null && _database!.isOpen) {
      return _database!;
    }
    _database = await _initDatabase();
    return _database!;
  }

  /// Inicializa o banco de dados FFI para desktop (Windows, Linux, macOS)
  ///
  /// Deve ser chamado antes de usar o banco em plataformas desktop.
  static void initializeFfi() {
    if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
      sqfliteFfiInit();
      databaseFactory = databaseFactoryFfi;
    }
  }

  /// Inicializa o banco de dados
  ///
  /// Cria o arquivo do banco de dados no diretório de documentos
  /// da aplicação e executa os scripts de criação de tabelas.
  Future<Database> _initDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(
      documentsDirectory.path,
      DatabaseConfig.databaseName,
    );

    return await openDatabase(
      path,
      version: DatabaseConfig.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  /// Configura o banco de dados
  ///
  /// Habilita as chaves estrangeiras para garantir integridade referencial.
  Future<void> _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  /// Cria as tabelas e índices do banco de dados
  ///
  /// Executado automaticamente quando o banco é criado pela primeira vez.
  Future<void> _onCreate(Database db, int version) async {
    // Cria todas as tabelas
    for (final script in DatabaseScripts.allCreateTableScripts) {
      await db.execute(script);
    }

    // Cria todos os índices
    for (final script in DatabaseScripts.allCreateIndexScripts) {
      await db.execute(script);
    }
  }

  /// Atualiza o banco de dados quando a versão muda
  ///
  /// Implementa a lógica de migração para cada versão do banco.
  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Implementar migrações futuras aqui
    // Exemplo:
    // if (oldVersion < 2) {
    //   await db.execute('ALTER TABLE clientes ADD COLUMN novo_campo TEXT');
    // }
  }

  /// Fecha a conexão com o banco de dados
  Future<void> close() async {
    if (_database != null && _database!.isOpen) {
      await _database!.close();
      _database = null;
    }
  }

  /// Limpa a instância do banco (para testes)
  ///
  /// Remove a referência ao banco atual, permitindo
  /// reinicialização com novas configurações.
  static void resetInstance() {
    _database = null;
    _instance = null;
  }

  /// Exclui o banco de dados
  ///
  /// Remove o arquivo do banco de dados do sistema de arquivos.
  /// Use com cuidado, pois todos os dados serão perdidos.
  Future<void> deleteDatabase() async {
    final Directory documentsDirectory =
        await getApplicationDocumentsDirectory();
    final String path = join(
      documentsDirectory.path,
      DatabaseConfig.databaseName,
    );
    await databaseFactory.deleteDatabase(path);
    resetInstance();
  }

  /// Verifica se uma tabela existe no banco de dados
  ///
  /// [tableName] Nome da tabela a ser verificada.
  /// Retorna true se a tabela existir, false caso contrário.
  Future<bool> tableExists(String tableName) async {
    final db = await database;
    final result = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name=?",
      [tableName],
    );
    return result.isNotEmpty;
  }

  /// Conta o número de registros em uma tabela
  ///
  /// [tableName] Nome da tabela para contagem.
  /// Retorna o número de registros na tabela.
  Future<int> countRecords(String tableName) async {
    final db = await database;
    final result = await db.rawQuery('SELECT COUNT(*) as count FROM $tableName');
    return result.first['count'] as int;
  }
}
