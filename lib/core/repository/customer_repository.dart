import 'package:system_loja/core/managers/default/default_manager.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/storage_data.dart';

class CustomerRepository extends DefaultManager {
  CustomerRepository({required super.settingsApp});

  Future<bool> deleteWithId(int id) {
    final result = defaultDataStorage.delete(id);
    return result.then((operationResult) {
      switch (operationResult) {
        case OperationSuccess(result: final success):
          return success;
        case OperationError(error: final errorMessage):
          throw Exception('Erro ao deletar cliente com ID $id: $errorMessage');
      }
    });
  }

  Future<Customer?> findWith({required String cpf}) async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationSuccess(result: final dataList):
        for (var data in dataList) {
          final customer = Customer.fromJson(data.data);
          if (customer.cpf == cpf) {
            return customer;
          }
        }
        return null;
      case OperationError(error: final errorMessage):
        throw Exception('Erro ao carregar clientes: $errorMessage');
    }
  }

  Future<int> getNextId() async {
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

  Future<Map<int, Customer>> loadAll() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationSuccess(result: final dataList):
        Map<int, Customer> customers = {};
        for (var data in dataList) {
          final customer = Customer.fromJson(data.data);
          customers[customer.id] = customer;
        }
        return customers;
      case OperationError(error: final errorMessage):
        throw Exception('Erro ao carregar clientes: $errorMessage');
    }
  }

  // Salvar novo cliente e caso existir faz update
  Future<bool> saveNewCustomer(Customer customer) async {
    final data = customer.toJson();
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: customer.id, data: data),
    );
    return result;
  }

  /// Atualiza um cliente existente
  Future<bool> updateCustomer(Customer customer) async {
    final data = customer.toJson();
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: customer.id, data: data),
    );
    return result;
  }
}
