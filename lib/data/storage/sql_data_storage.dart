import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/storage_data.dart';

class SqlDataStorage extends BaseDataStorage {
  @override
  Future<OperationResult<bool, String>> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<PersistentDataStore, String>> fetchById(int id) {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<List<PersistentDataStore>, String>> loadAll() {
    // TODO: implement loadAll
    throw UnimplementedError();
  }

  @override
  Future<bool> save(PersistentDataStore object) {
    // TODO: implement save
    throw UnimplementedError();
  }
}
