import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract class BaseDataStorage {
  @protected
  final Map<String, Lock> fileLocks = {};
  BaseDataStorage();

  /// Deleta objeto pelo ID
  Future<bool> delete(int id);

  /// Busca objeto pelo ID
  /// Sucesso: Retorna o objeto encontrado
  /// Falha: Retorna mensagem de erro
  Future<OperationResult<Map<String, dynamic>, String>> fetchById(int id);

  @protected
  Lock getLock() {
    return fileLocks.putIfAbsent(runtimeType.toString(), Lock.new);
  }

  Future<OperationResult<List<Map<String, dynamic>>, String>> loadAll();

  /// Pode salvar novo objeto ou atualizar existente
  Future<bool> save(Map<String, dynamic> object);
}
