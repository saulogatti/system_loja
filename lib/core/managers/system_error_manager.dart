import 'dart:developer';

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

class SystemErrorManager {
  static final SystemErrorManager instance = SystemErrorManager._();
  final SystemCacheManager _cacheManager = SystemCacheManager();
  SystemErrorManager._();
  Future<List<SystemErrorModel>> getAllErrors() async {
    return await _cacheManager.retrieveAllErrors();
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
    await _cacheManager.saveError(error);
  }
}
