import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class ICustomerRepository {
  Future<ResultStatus<bool, String>> deleteClient(int id);
  Future<ResultStatus<Map<int, Customer>, String>> fetchMappedCustomers();
  Future<ResultStatus<Customer?, String>> findCustomerById(int id);
  Future<ResultStatus<Customer?, String>> findWith({required String cpf});
  Future<ResultStatus<List<Customer>, String>> getAllCustomers();
  Future<ResultStatus<bool, String>> saveCustomer(Customer customer);
  Future<ResultStatus<bool, String>> updateCustomer(Customer customer);
}
