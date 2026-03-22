import 'dart:developer';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:system_loja/core/models/system_errors/system_error.dart';
import 'package:system_loja/data/cache/models/system_model/system_error_model.dart';
import 'package:system_loja/data/cache/system_cache_manager.dart';

Future<void> reportError(Object error, StackTrace stackTrace) async {
  final systemError = SystemErrorModel(
    message: error.toString(),
    code: error.hashCode,
    stackTrace: stackTrace,
  );
  await SystemErrorManager.instance.saveErrorToCache(systemError);
}
// TODO: Avaliar a necessidade de usar o SystemErrorManager

class SystemErrorManager {
  static final SystemErrorManager instance = SystemErrorManager._();
  final SystemCacheManager _cacheManager = SystemCacheManager();
  SystemErrorManager._() {
    FlutterError.onError = (FlutterErrorDetails details) {
      reportError(details.exception, details.stack ?? StackTrace.current);
    };
    PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
      reportError(error, stack);
      return true;
    };
  }
  Future<void> clearAllErrors() async {
    await _cacheManager.clearErrors();
  }

  Future<List<SystemError>> getAllErrors() async {
    final listLogs = await _cacheManager.retrieveAllErrors();
    final list = listLogs.map((logError) => logError.toDomain()).toList();
    return list;
  }

  Future<List<SystemErrorModel>> getErrorsByCode(int code) async {
    return await _cacheManager.retrieveErrorsByCode(code);
  }

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
