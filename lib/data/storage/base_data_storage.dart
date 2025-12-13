import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta.dart';
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/utils/command_result.dart';

part 'base_data_storage.g.dart';

abstract class BaseDataStorage {
  @protected
  final Map<String, Lock> fileLocks = {};

  /// Categoria de armazenamento (usada para diferenciar tipos de dados)
  /// Exemplo: "UserData", "ProductData", etc.
  final String storageCategory;
  BaseDataStorage({required this.storageCategory});

  /// Deleta objeto pelo ID
  Future<OperationResult<bool, String>> delete(int id);

  /// Busca objeto pelo ID
  /// Sucesso: Retorna o objeto encontrado
  /// Falha: Retorna mensagem de erro
  Future<OperationResult<PersistentDataStore, String>> fetchById(int id);

  @protected
  Lock getLock() {
    return fileLocks.putIfAbsent(runtimeType.toString(), Lock.new);
  }

  Future<OperationResult<List<PersistentDataStore>, String>> loadAll();

  /// Pode salvar novo objeto ou atualizar existente
  Future<bool> save(PersistentDataStore object);
}
/// Representa um objeto persistente armazenado.
/// Contém um ID único e um mapa de dados genéricos.
@JsonSerializable()
class PersistentDataStore {
  final int id;
  final Map<String, dynamic> data;
  const PersistentDataStore({required this.id, required this.data});
  factory PersistentDataStore.fromJson(Map<String, dynamic> json) =>
      _$PersistentDataStoreFromJson(json);
  Map<String, dynamic> toJson() => _$PersistentDataStoreToJson(this);
}
