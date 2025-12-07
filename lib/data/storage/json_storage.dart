import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/files_system/file_system_manager.dart';
import 'package:system_loja/data/storage/storage_data.dart';

class JsonDataStorage extends BaseDataStorage with FileSystemManager {
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<Map<String, dynamic>, String>> fetchById(int id) {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<List<Map<String, dynamic>>, String>> loadAll() {
    // TODO: implement loadAll
    throw UnimplementedError();
  }

  @override
  void logError(String message, StackTrace stackTrace) {
    // TODO: implement logError
  }

  @override
  Future<bool> save(Map<String, dynamic> object) {
    // TODO: implement save
    throw UnimplementedError();
  }

  @override
  String systemNameDirectory() {
    return 'json_data_storage';
  }
}
