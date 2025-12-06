import 'package:system_loja/core/models/customer.dart';

abstract class CustomerRepository {
  Future<bool> atualizarCliente(Customer cliente);
  Future<Customer?> buscarClientePorCpf(String cpf);
  Future<Map<int, Customer>> carregarClientes();
  Future<bool> deletarCliente(int id);
  Future<bool> salvarNovoCliente(Customer cliente);
}
