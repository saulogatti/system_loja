import 'dart:convert';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/database_config.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';

/// Implementação de armazenamento de dados utilizando SQL.
///
/// Esta classe fornece persistência genérica de dados em banco SQLite,
/// permitindo armazenar qualquer objeto que implemente [PersistentDataStore].
///
/// ## Arquitetura
/// - Estende [BaseDataStorage] para fornecer operações CRUD básicas padronizadas
/// - Utiliza categorias de armazenamento para diferenciar e organizar tipos de dados
/// - Suporta múltiplas entidades (clientes, produtos, pedidos, etc.) com uma única implementação
///
/// ## Implementação Esperada
///
/// ### Método [save]
/// - Valida se o objeto implementa [PersistentDataStore]
/// - Se o objeto tem `id == null` ou `id == 0`: insere novo registro retornando `true`
/// - Se o objeto tem `id > 0`: atualiza registro existente retornando `true`
/// - Em caso de erro (constraint violation, I/O error): retorna `false`
/// - Não deve retornar [ExecutionResult], apenas bool (como definido na assinatura)
///
/// ### Método [delete]
/// - Remove um registro pelo [id] do banco de dados
/// - Retorna [ExecutionSucess] com `true` se deletado com sucesso
/// - Retorna [ExecutionError] com mensagem descritiva se falhar (ID não existe, erro SQL, etc.)
///
/// ### Método [fetchById]
/// - Recupera um registro específico pelo [id]
/// - Retorna [ExecutionSucess] contendo o objeto [PersistentDataStore] se encontrado
/// - Retorna [ExecutionError] se ID não existe, erro de banco ou falha de desserialização
/// - Usa [fromJson] do objeto para converter dados SQL em objeto Dart
///
/// ### Método [loadAll]
/// - Carrega todos os registros da categoria de armazenamento
/// - Retorna [ExecutionSucess] com lista (vazia se nenhum registro)
/// - Retorna [ExecutionError] em caso de erro de acesso ao banco
/// - Cada item da lista deve ser validado e convertido via [fromJson]
///
/// ## Padrões de Erro
/// - Use [ExecutionSucess] para operações bem-sucedidas
/// - Use [ExecutionError] com mensagem clara do erro (ex: "Cliente com ID 123 não encontrado")
/// - Não lance exceções; encapsule erros em [ExecutionResult]
///
/// ## Dependências Externas
/// - Acesse o banco via `DatabaseHelper.instance` ou similar
/// - Use `toJson()` do objeto para serialização
/// - Use [PersistentDataStore.fromJson] para desserialização
/// - Utilize [storageCategory] para filtrar registros na tabela correta
///
/// ## Exemplo de Uso Esperado
/// ```dart
/// final storage = SqlDataStorage(storageCategory: 'clientes');
/// final cliente = Cliente(id: null, nome: 'João', cpf: '123.456.789-00');
/// final sucesso = await storage.save(cliente);
///
/// final resultado = await storage.fetchById(1);
/// switch (resultado) {
///   case OperationSuccess(value: final cliente):
///     print('Cliente encontrado: ${cliente.nome}');
///   case OperationError(error: final erro):
///     print('Erro: $erro');
/// }
/// ```
class SqlDataStorage extends BaseDataStorage with LoggerClassMixin {
  static const Duration _timeOutMilliseconds = Duration(seconds: 5);

  /// Deleta um objeto pelo ID do banco de dados.
  ///
  /// Remove o registro da tabela `persistent_data_store` que corresponde
  /// ao [id] fornecido e à categoria de armazenamento desta instância.
  ///
  /// [id] Identificador único do objeto a ser deletado.
  ///
  /// Retorna [ExecutionResult] com:
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
  final _dbHelper = DatabaseHelper();
  SqlDataStorage({required super.storageCategory});
  Future<Database> get _database => _dbHelper.database;
  @override
  Future<ExecutionResult<bool, String>> delete(int id) async {
    try {
      return await getLock().synchronized<
        ExecutionResult<bool, String>
      >(() async {
        final db = await _database;
        final rowsAffected = await db.delete(
          DatabaseConfig.tablePersistentDataStore,
          where: 'id = ? AND storage_category = ?',
          whereArgs: [id, storageCategory],
        );

        if (rowsAffected > 0) {
          return ExecutionResult.success(true);
        } else {
          return ExecutionResult.error(
            'Nenhum objeto encontrado com ID $id na categoria $storageCategory',
          );
        }
      }, timeout: _timeOutMilliseconds);
    } catch (e, stackTrace) {
      logError('Erro ao deletar objeto com ID $id: $e', stackTrace);
      return ExecutionResult.error('Erro ao deletar objeto com ID $id: $e');
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
  /// Retorna [ExecutionResult] com:
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
  Future<ExecutionResult<PersistentDataStore, String>> fetchById(int id) async {
    try {
      final db = await _database;
      final List<Map<String, dynamic>> results = await db.query(
        DatabaseConfig.tablePersistentDataStore,
        where: 'id = ? AND storage_category = ?',
        whereArgs: [id, storageCategory],
      );

      if (results.isEmpty) {
        return ExecutionResult.error(
          'Objeto com ID $id não encontrado na categoria $storageCategory',
        );
      }

      final row = results.first;
      final dataJson =
          jsonDecode(row['data'] as String) as Map<String, dynamic>;
      final persistentData = PersistentDataStore(
        id: row['id'] as int,
        data: dataJson,
      );

      return ExecutionResult.success(persistentData);
    } catch (e, stackTrace) {
      logError('Erro ao buscar objeto com ID $id: $e', stackTrace);
      return ExecutionResult.error('Erro ao buscar objeto com ID $id: $e');
    }
  }

  /// Carrega todos os objetos da categoria de armazenamento.
  ///
  /// Busca todos os registros da tabela `persistent_data_store` que
  /// pertencem à categoria de armazenamento desta instância.
  ///
  /// Retorna [ExecutionResult] com:
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
  Future<ExecutionResult<List<PersistentDataStore>, String>> loadAll() async {
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
          final dataJson =
              jsonDecode(row['data'] as String) as Map<String, dynamic>;
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

      return ExecutionResult.success(allData);
    } catch (e, stackTrace) {
      logError('Erro ao carregar todos os objetos: $e', stackTrace);
      return ExecutionResult.error('Erro ao carregar todos os objetos: $e');
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
      return await getLock().synchronized<bool>(() async {
        final db = await _database;
        // final dataExkists = await fetchById(object.id);
        // switch (dataExkists) {
        //   case OperationSuccess():
        //     // Já existe, será atualizado
        //     break;
        //   case OperationError():
        //     // Não existe, será inserido
        //     break;
        // }
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
      }, timeout: _timeOutMilliseconds);
    } catch (e, stackTrace) {
      logError('Erro ao salvar objeto com ID ${object.id}: $e', stackTrace);
      return false;
    }
  }
}
