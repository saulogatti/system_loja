import 'package:system_loja/core/models/customer.dart';

 class CustomerRepository {
  
  Future<Customer?> findWith({required String cpf}){
    // Implementar busca de cliente por CPF no repositório
    throw UnimplementedError();
  }
  Future<Map<int, Customer>> loadAll(){
    // Implementar carregamento de clientes do repositório
    throw UnimplementedError();
  }
  Future<bool> deleteWithId(int id){
    // Implementar deleção de cliente no repositório
    throw UnimplementedError();
  }
  // Salvar novo cliente e caso existir faz update
  Future<bool> saveNewCustomer(Customer customer){
    // Implementar salvamento de novo cliente no repositório
    throw UnimplementedError();
  }
}
