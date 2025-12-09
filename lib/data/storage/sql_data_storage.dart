import 'dart:convert';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/database_config.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/storage/storage_data.dart';

/// Armazenamento de dados em banco de dados SQLite.
///
/// Implementa persistência usando SQLite com a tabela `persistent_data_store`.
/// Cada objeto é armazenado com seu ID e categoria, permitindo organização
/// e busca eficiente de dados genéricos.
///
/// Esta implementação usa o padrão Singleton do [DatabaseHelper] para
/// gerenciar a conexão com o banco de dados.
class SqlDataStorage extends BaseDataStorage with LoggerClassMixin {
  /// Instância do helper do banco de dados
  final DatabaseHelper _dbHelper;

  /// Timeout para operações com lock
  static const Duration _timeOutMilliseconds = Duration(milliseconds: 5000);

  /// Construtor que permite injeção de dependência do DatabaseHelper
  ///
  /// [storageCategory] Categoria de armazenamento para organizar dados.
  /// [dbHelper] Instância opcional do DatabaseHelper (usa singleton se não fornecido).
  SqlDataStorage({
    required super.storageCategory,
    DatabaseHelper? dbHelper,
  }) : _dbHelper = dbHelper ?? DatabaseHelper();

  /// Obtém a instância do banco de dados
  Future<Database> get _database => _dbHelper.database;

  /// Deleta um objeto pelo ID do banco de dados.
  ///
  /// Remove o registro da tabela `persistent_data_store` que corresponde
  /// ao [id] fornecido e à categoria de armazenamento desta instância.
  ///
  /// [id] Identificador único do objeto a ser deletado.
  ///
  /// Retorna [OperationResult] com:
  /// - Sucesso: `true` se o objeto foi deletado
  /// - Falha: Mensagem de erro se não foi possível deletar
  ///
  /// Exemplo:
  /// ```dart
  /// final storage = SqlDataStorage(storageCategory: 'UserData');
  /// final result = await storage.delete(123);
  /// switch (result) {
  ///   case OperationSuccess():
  ///     print('Objeto deletado com sucesso');
  ///   case OperationError(error: final erro):
  ///     print('Erro ao deletar: $erro');
  /// }
  /// ```
  @override
  Future<OperationResult<bool, String>> delete(int id) async {
    try {
      return await getLock().synchronized<OperationResult<bool, String>>(
        () async {
          final db = await _database;
          final rowsAffected = await db.delete(
            DatabaseConfig.tablePersistentDataStore,
            where: 'id = ? AND storage_category = ?',
            whereArgs: [id, storageCategory],
          );

          if (rowsAffected > 0) {
            return OperationResult.success(true);
          } else {
            return OperationResult.failure(
              'Nenhum objeto encontrado com ID $id na categoria $storageCategory',
            );
          }
        },
        timeout: _timeOutMilliseconds,
      );
    } catch (e, stackTrace) {
      logError('Erro ao deletar objeto com ID $id: $e', stackTrace);
      return OperationResult.failure('Erro ao deletar objeto com ID $id: $e');
    }
  }

  /// Busca um objeto pelo ID no banco de dados.
  ///
  /// Consulta a tabela `persistent_data_store` para recuperar o objeto
  /// com o [id] fornecido que pertence à categoria de armazenamento
  /// desta instância.
  ///
  /// [id] Identificador único do objeto a ser buscado.
  ///
  /// Retorna [OperationResult] com:
  /// - Sucesso: Objeto [PersistentDataStore] encontrado
  /// - Falha: Mensagem de erro se não encontrado ou erro na busca
  ///
  /// Exemplo:
  /// ```dart
  /// final storage = SqlDataStorage(storageCategory: 'UserData');
  /// final result = await storage.fetchById(123);
  /// switch (result) {
  ///   case OperationSuccess(result: final objeto):
  ///     print('Dados: ${objeto.data}');
  ///   case OperationError(error: final erro):
  ///     print('Erro ao buscar: $erro');
  /// }
  /// ```
  @override
  Future<OperationResult<PersistentDataStore, String>> fetchById(int id) async {
    try {
      final db = await _database;
      final List<Map<String, dynamic>> results = await db.query(
        DatabaseConfig.tablePersistentDataStore,
        where: 'id = ? AND storage_category = ?',
        whereArgs: [id, storageCategory],
      );

      if (results.isEmpty) {
        return OperationResult.failure(
          'Objeto com ID $id não encontrado na categoria $storageCategory',
        );
      }

      final row = results.first;
      final dataJson = jsonDecode(row['data'] as String) as Map<String, dynamic>;
      final persistentData = PersistentDataStore(
        id: row['id'] as int,
        data: dataJson,
      );

      return OperationResult.success(persistentData);
    } catch (e, stackTrace) {
      logError('Erro ao buscar objeto com ID $id: $e', stackTrace);
      return OperationResult.failure('Erro ao buscar objeto com ID $id: $e');
    }
  }

  /// Carrega todos os objetos da categoria de armazenamento.
  ///
  /// Busca todos os registros da tabela `persistent_data_store` que
  /// pertencem à categoria de armazenamento desta instância.
  ///
  /// Retorna [OperationResult] com:
  /// - Sucesso: Lista de objetos [PersistentDataStore] (pode estar vazia)
  /// - Falha: Mensagem de erro se houver problema na consulta
  ///
  /// Exemplo:
  /// ```dart
  /// final storage = SqlDataStorage(storageCategory: 'UserData');
  /// final result = await storage.loadAll();
  /// switch (result) {
  ///   case OperationSuccess(result: final objetos):
  ///     print('Encontrados ${objetos.length} objetos');
  ///     for (var obj in objetos) {
  ///       print('ID: ${obj.id}, Dados: ${obj.data}');
  ///     }
  ///   case OperationError(error: final erro):
  ///     print('Erro ao carregar: $erro');
  /// }
  /// ```
  @override
  Future<OperationResult<List<PersistentDataStore>, String>> loadAll() async {
    try {
      final db = await _database;
      final List<Map<String, dynamic>> results = await db.query(
        DatabaseConfig.tablePersistentDataStore,
        where: 'storage_category = ?',
        whereArgs: [storageCategory],
        orderBy: 'id ASC',
      );

      final allData = <PersistentDataStore>[];
      for (var row in results) {
        try {
          final dataJson = jsonDecode(row['data'] as String) as Map<String, dynamic>;
          final persistentData = PersistentDataStore(
            id: row['id'] as int,
            data: dataJson,
          );
          allData.add(persistentData);
        } catch (e, stackTrace) {
          // Registra erro mas continua processando outros registros
          logError(
            'Erro ao decodificar registro com ID ${row['id']}: $e',
            stackTrace,
          );
          // Opcionalmente, pode deletar o registro corrompido
          // await delete(row['id'] as int);
        }
      }

      return OperationResult.success(allData);
    } catch (e, stackTrace) {
      logError('Erro ao carregar todos os objetos: $e', stackTrace);
      return OperationResult.failure('Erro ao carregar todos os objetos: $e');
    }
  }

  /// Salva ou atualiza um objeto no banco de dados.
  ///
  /// Se um objeto com o mesmo [object.id] já existir na categoria,
  /// ele será atualizado. Caso contrário, um novo registro será inserido.
  ///
  /// O método usa sincronização para garantir operações thread-safe.
  ///
  /// [object] Objeto [PersistentDataStore] a ser salvo.
  ///
  /// Retorna `true` se a operação foi bem-sucedida, `false` caso contrário.
  ///
  /// Exemplo:
  /// ```dart
  /// final storage = SqlDataStorage(storageCategory: 'UserData');
  /// final objeto = PersistentDataStore(
  ///   id: 123,
  ///   data: {'nome': 'João', 'idade': 30},
  /// );
  /// final success = await storage.save(objeto);
  /// if (success) {
  ///   print('Objeto salvo com sucesso');
  /// } else {
  ///   print('Erro ao salvar objeto');
  /// }
  /// ```
  @override
  Future<bool> save(PersistentDataStore object) async {
    try {
      return await getLock().synchronized<bool>(
        () async {
          final db = await _database;
          final dataJson = jsonEncode(object.data);

          final Map<String, dynamic> row = {
            'id': object.id,
            'storage_category': storageCategory,
            'data': dataJson,
          };

          // Tenta inserir ou atualizar usando conflictAlgorithm.replace
          // Com a chave primária composta (id, storage_category), isso fará
          // um UPDATE se o par (id, categoria) já existir, ou INSERT caso contrário.
          // Isso garante isolamento entre categorias.
          final result = await db.insert(
            DatabaseConfig.tablePersistentDataStore,
            row,
            conflictAlgorithm: ConflictAlgorithm.replace,
          );

          return result > 0;
        },
        timeout: _timeOutMilliseconds,
      );
    } catch (e, stackTrace) {
      logError('Erro ao salvar objeto com ID ${object.id}: $e', stackTrace);
      return false;
    }
  }
}
