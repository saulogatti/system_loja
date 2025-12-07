import 'dart:convert';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'package:system_loja/data/files_utility/file_storage_utility.dart';
import 'package:system_loja/data/storage/storage_data.dart';

/// Armazenamento de dados em arquivos JSON.
///
/// Implementa persistência usando o sistema de arquivos com formato JSON.
/// Cada objeto é salvo em um arquivo separado nomeado por ID.
class JsonDataStorage extends BaseDataStorage
    with FileStorageUtility, LoggerClassMixin {
  static const String _fileNameMask = 'json_storage_';
  static const int _maxFileNameLength = 200;
  static const Duration _timeOutMilliseconds = Duration(milliseconds: 5000);
  @override
  Future<bool> delete(int id) async {
    try {
      return await getLock().synchronized<bool>(() async {
        // Sincroniza acesso ao arquivo

        final fileName = _fileNameId(id);
        return await deleteFile(fileName);
      }, timeout: _timeOutMilliseconds);
    } catch (e, stackTrace) {
      logError('Erro ao deletar arquivo com ID $id: $e', stackTrace);
      return false;
    }
  }

  @override
  Future<OperationResult<Map<String, dynamic>, String>> fetchById(
    int id,
  ) async {
    try {
      final fileName = _fileNameId(id);
      final result = await fetchDataFromFile(fileName);

      if (result.isSuccessful) {
        final content = result.asSuccess;
        try {
          final data = jsonDecode(content) as Map<String, dynamic>;
          return OperationResult.success(data);
        } catch (e) {
          return OperationResult.failure('Erro ao decodificar JSON: $e');
        }
      } else {
        return OperationResult.failure(result.asError);
      }
    } catch (e, stackTrace) {
      logError('Erro ao buscar objeto com ID $id: $e', stackTrace);
      return OperationResult.failure('Erro ao buscar objeto: $e');
    }
  }

  @override
  Future<OperationResult<List<Map<String, dynamic>>, String>> loadAll() async {
    OperationResult<List<String>, String> resultado = await fetchAllDataFiles();
    switch (resultado) {
      case OperationSuccess(result: final fileContents):
        final allData = <Map<String, dynamic>>[];
        for (var content in fileContents) {
          try {
            final data = jsonDecode(content) as Map<String, dynamic>;
            allData.add(data);
          } catch (e) {
            logError(
              'Erro ao decodificar JSON durante loadAll: $e',
              StackTrace.current,
            );
          }
        }
        return OperationResult.success(allData);
      case OperationError(error: final erro):
        return OperationResult.failure(erro);
    }
  }

  @override
  String retrieveDirectoryName() {
    return 'json_data_storage';
  }

  @override
  Future<bool> save(Map<String, dynamic> object) async {
    try {
      if (!object.containsKey('id')) {
        logError('Objeto sem ID não pode ser salvo', StackTrace.current);
        return false;
      }

      final id = object['id'] as int;
      final fileName = _fileNameId(id);

      // Codifica com indentação para legibilidade
      final jsonString = const JsonEncoder.withIndent('  ').convert(object);

      return await saveData(fileName, jsonString);
    } catch (e, stackTrace) {
      logError('Erro ao salvar objeto: $e', stackTrace);
      return false;
    }
  }

  /// Gera um nome de arquivo seguro baseado no ID.
  ///
  /// Aplica sanitização e proteções para garantir compatibilidade
  /// entre diferentes sistemas operacionais.
  ///
  /// Formato: `json_storage_{id}.json`
  String _fileNameId(int id) {
    final baseName = '$_fileNameMask$id.json';
    return baseName.toSafeFileName(maxLength: _maxFileNameLength);
  }
}
