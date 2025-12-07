import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/repository/customer_repository.dart';

import '../models/customer.dart';

/// Gerenciador de Clientes
///
/// Utiliza um mecanismo de sincronização para evitar condições de corrida
/// e recarrega dados antes de salvar para prevenir perda de dados.
class CustomerServiceManager with LoggerClassMixin {
  /// Lock estático por arquivo para serializar o acesso entre múltiplas instâncias
  static final Map<String, Lock> _fileLocks = {};
  //TODO: Deixar privado
  // Manter temporalmente público até implementar injeção de dependência
  List<Customer> clientes = [];
  late CustomerRepository repository;

  CustomerServiceManager() {
    // TODO: Injetar a dependência do repositório aqui
    // repository = CustomerRepository();
  }

  /// Obtém um cliente por ID
  Future<Customer?> obterClientePorId(int id) async {
    final clientes = await repository.loadAll();
    return clientes[id];
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(repository.toString(), Lock.new);
  }
}
