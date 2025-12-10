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

  JsonDataStorage({required super.storageCategory});
  @override
  Future<OperationResult<bool, String>> delete(int id) async {
    try {
      return await getLock().synchronized<OperationResult<bool, String>>(
        () async {
          // Sincroniza acesso ao arquivo

          final fileName = _fileNameId(id);
          final result = await deleteFile(fileName);
          if (result) {
            return OperationResult.success(true);
          } else {
            return OperationResult.failure(
              'Falha ao deletar arquivo com ID $id',
            );
          }
        },
        timeout: _timeOutMilliseconds,
      );
    } catch (e, stackTrace) {
      logError('Erro ao deletar arquivo com ID $id: $e', stackTrace);
      return OperationResult.failure('Erro ao deletar arquivo com ID $id: $e');
    }
  }

  @override
  Future<OperationResult<PersistentDataStore, String>> fetchById(int id) async {
    try {
      final fileName = _fileNameId(id);
      final result = await fetchDataFromFile(fileName);
      switch (result) {
        case OperationSuccess(result: final content):
          final data = _objectFromJson(content);
          return OperationResult.success(data);

        case OperationError(error: final errorMessage):
          return OperationResult.failure(errorMessage);
      }
    } catch (e) {
      return OperationResult.failure('Erro ao buscar arquivo com ID $id: $e');
    }
  }

  @override
  Future<OperationResult<List<PersistentDataStore>, String>> loadAll() async {
    OperationResult<List<String>, String> resultado = await fetchAllDataFiles();
    switch (resultado) {
      case OperationSuccess(result: final fileContents):
        final allData = <PersistentDataStore>[];
        for (var content in fileContents) {
          try {
            PersistentDataStore persistent = _objectFromJson(content);
            allData.add(persistent);
          } catch (e) {
            final j = jsonDecode(content);
            if (j is Map && j.containsKey('id')) {
              final idError = j['id'];
              if (idError is! int) {
                int? idErrorInt = int.tryParse(idError.toString());
                if (idErrorInt != null) {
                  await delete(idErrorInt);
                }
              } else {
                await delete(idError);
              }
            }
            logError(
              'Erro ao decodificar JSON durante loadAll: $e$j',
              StackTrace.current,
            );
            return OperationResult.failure(e.toString());
          }
        }
        return OperationResult.success(allData);
      case OperationError(error: final erro):
        return OperationResult.failure(erro);
    }
  }

  @override
  String retrieveDirectoryName() {
    return 'json_storage_$storageCategory';
  }

  @override
  Future<bool> save(PersistentDataStore object) async {
    try {
      return await getLock().synchronized<bool>(
        () async {
          final id = object.id;
          final fileName = _fileNameId(id);

          // Codifica com indentação para legibilidade
          final jsonString = const JsonEncoder.withIndent(
            '  ',
          ).convert(object.toJson());
          return await saveData(fileName, jsonString);
        },
        timeout: _timeOutMilliseconds,
      );
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

  PersistentDataStore _objectFromJson(String content) {
    final data = jsonDecode(content) as Map<String, dynamic>;
    final persistent = PersistentDataStore.fromJson(data);
    return persistent;
  }
}
