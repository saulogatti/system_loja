import 'dart:async';
import 'dart:developer';
import 'dart:ui';

import 'package:material_ui/material_ui.dart';
import 'package:system_loja/core/interface/i_system_error_manager.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';
import 'package:system_loja/data/cache/models/system_model/system_error_model.dart';
import 'package:system_loja/data/cache/system_cache_manager.dart';

/// Grava um erro inesperado no cache de arquivo JSON.
///
/// {@category servicos}
/// {@subCategory Sistema}
Future<void> reportError(Object error, StackTrace stackTrace) async {
  final systemError = SystemErrorModel(
    message: error.toString(),
    code: error.hashCode,
    stackTrace: stackTrace,
  );
  await SystemErrorManager().saveErrorToCache(systemError);
}

/// Captura erros de Flutter/plataforma e persiste no cache de arquivo.
///
/// {@category servicos}
/// {@subCategory Sistema}
///
/// Implementa [ISystemErrorManager]. Persistência principal da loja é Drift;
/// este serviço só grava [SystemErrorModel] em arquivo JSON.
// TODO: Avaliar a necessidade de usar o SystemErrorManager
class SystemErrorManager implements ISystemErrorManager {
  /// Instala handlers de [FlutterError] e [PlatformDispatcher] e grava no cache.
  SystemErrorManager() {
    FlutterError.onError = (details) async {
      await reportError(details.exception, details.stack ?? StackTrace.current);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      unawaited(reportError(error, stack));
      return true;
    };
  }
  final SystemCacheManager _cacheManager = SystemCacheManager();

  @override
  Future<void> clearAllErrors() async {
    await _cacheManager.clearErrors();
  }

  @override
  Future<List<SystemError>> getAllErrors() async {
    final listLogs = await _cacheManager.retrieveAllErrors();
    final list = listLogs.map((logError) => logError.toDomain()).toList();
    return list;
  }

  /// Retorna erros de cache cujo código coincide com [code].
  Future<List<SystemErrorModel>> getErrorsByCode(int code) =>
      _cacheManager.retrieveErrorsByCode(code);

  /// Persiste [error] no cache de arquivo JSON.
  Future<void> saveErrorToCache(SystemErrorModel error) async {
    log(
      'Saving error to cache: ${error.message}',
      time: DateTime.now(),
      name: 'SystemErrorManager',
      stackTrace: error.stackTrace,
    );
    await _cacheManager.saveErrorModel(error);
  }
}
