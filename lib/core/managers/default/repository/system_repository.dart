import 'package:system_loja/core/managers/default/repository/obejct_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';

class JsonSystemRepository extends SystemRepository {
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<ObejctRepositoryBase, String>> fetchById(int id) {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<bool> save(ObejctRepositoryBase object) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

class SqlSystemRepository extends SystemRepository {
  @override
  Future<bool> delete(int id) {
    // TODO: implement delete
    throw UnimplementedError();
  }

  @override
  Future<OperationResult<ObejctRepositoryBase, String>> fetchById(int id) {
    // TODO: implement getObject
    throw UnimplementedError();
  }

  @override
  Future<bool> save(ObejctRepositoryBase object) {
    // TODO: implement save
    throw UnimplementedError();
  }
}

sealed class SystemRepository {
  const SystemRepository();

  /// Deleta objeto pelo ID
  Future<bool> delete(int id);

  /// Busca objeto pelo ID
  Future<OperationResult<ObejctRepositoryBase, String>> fetchById(int id);

  /// Pode salvar novo objeto ou atualizar existente
  Future<bool> save(ObejctRepositoryBase object);
}
