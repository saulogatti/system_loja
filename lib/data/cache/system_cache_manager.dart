import 'dart:convert';

import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/cache/models/system_model/system_error_model.dart';
import 'package:system_loja/data/files_utility/file_storage_utility.dart';

/// Cache em arquivo JSON dos erros capturados pelo sistema.
///
/// {@category dados}
/// {@subCategory Sistema}
///
/// Não substitui o Drift; serve só para persistir [SystemErrorModel] em disco.
class SystemCacheManager with FileStorageUtility, LoggerClassMixin {
  final Map<String, String> _fileStorageOptions = {};

  /// Remove todos os arquivos de erro do cache.
  Future<void> clearErrors() async {
    await retrieveAllErrors();
    if (_fileStorageOptions.isEmpty) {
      logInfo('No errors to clear from cache.');
      return;
    }
    for (final cacheKey in _fileStorageOptions.values) {
      await deleteFile(cacheKey);
    }
    _fileStorageOptions.clear();
    logInfo('All errors cleared from cache.');
  }

  /// Lê todos os erros persistidos em arquivo.
  Future<List<SystemErrorModel>> retrieveAllErrors() async {
    final errors = <SystemErrorModel>[];
    try {
      final result = await fetchAllDataFiles();
      switch (result) {
        case ResultSuccess(result: final dataMap):
          for (final dataString in dataMap) {
            final jsonData = jsonDecode(dataString);
            if (jsonData != null && jsonData is Map) {
              final dataMap = Map<String, dynamic>.from(jsonData);
              final errorModel = SystemErrorModel.fromJson(dataMap);
              errors.add(errorModel);
              _fileStorageOptions['${errorModel.code}_error'] =
                  errorModel.cacheKey;
            }
          }
        case ResultError(resultError: final error):
          logError('Error retrieving files: $error', StackTrace.current);
      }

      logInfo('Retrieved ${errors.length} errors from cache.');
    } catch (e, stackTrace) {
      logError('Failed to retrieve errors from cache: $e', stackTrace);
    }
    return errors;
  }

  @override
  String retrieveDirectoryName() => 'system_cache';

  /// Retorna erros cujo código coincide com [code].
  Future<List<SystemErrorModel>> retrieveErrorsByCode(int code) async {
    final errors = <SystemErrorModel>[];

    try {
      final keyCode = '${code}_error';
      final cacheKey = _fileStorageOptions[keyCode];
      if (cacheKey != null) {
        final result = await fetchDataFromFile(cacheKey);
        switch (result) {
          case ResultSuccess(result: final dataString):
            final jsonData = jsonDecode(dataString);
            if (jsonData != null && jsonData is Map) {
              final dataMap = Map<String, dynamic>.from(jsonData);
              final errorModel = SystemErrorModel.fromJson(dataMap);
              errors.add(errorModel);
            }
          case ResultError(resultError: final error):
            logError('Error retrieving file: $error', StackTrace.current);
        }
      } else {
        logInfo('No cached error found for code: $code');
      }
      logInfo('Retrieved ${errors.length} errors for code $code from cache.');
    } catch (e, stackTrace) {
      logError('Failed to retrieve errors by code from cache: $e', stackTrace);
    }
    return errors;
  }

  /// Persiste um [SystemError] de domínio no cache de arquivo.
  Future<void> saveError(SystemError error) async {
    await saveErrorModel(SystemErrorModel.fromDomain(error));
  }

  /// Persiste um [SystemErrorModel] já montado (ex.: vindo de reportError).
  Future<void> saveErrorModel(SystemErrorModel errorModel) async {
    try {
      final keyCode = '${errorModel.code}_error';
      errorModel.cacheKey = '$keyCode.json';
      _fileStorageOptions[keyCode] = errorModel.cacheKey;
      final jsonData = jsonEncode(errorModel.toJson());
      await saveData(errorModel.cacheKey, jsonData);
      logInfo('Error saved to cache: ${errorModel.cacheKey}');
    } catch (e, stackTrace) {
      logError('Failed to save error to cache: $e', stackTrace);
    }
  }
}
