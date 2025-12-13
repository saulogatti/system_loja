import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';
import 'package:system_loja/data/storage/sql_data_storage.dart';

abstract class BaseRepository {
  late BaseDataStorage _defaultDataStorage;
  BaseRepository() {
    _defaultDataStorage = SqlDataStorage(
      storageCategory: runtimeType.toString(),
    );
  }

  BaseDataStorage get defaultDataStorage => _defaultDataStorage;
  Future<int> obtainNextId() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationSuccess(result: final dataList):
        if (dataList.isEmpty) {
          return 1;
        }
        final ids = dataList.map((data) => data.id).toList();
        return (ids.reduce((a, b) => a > b ? a : b)) + 1;
      case OperationError(error: final errorMessage):
        throw Exception('Erro ao carregar clientes: $errorMessage');
    }
  }
}
