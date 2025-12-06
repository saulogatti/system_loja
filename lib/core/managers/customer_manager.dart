import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:synchronized/synchronized.dart';
import 'package:system_loja/core/cliente_repository/cliente_repository.dart';
import 'package:system_loja/core/managers/exceptions/cliente_exception.dart';
import 'package:system_loja/core/utils/resultado.dart';
import 'package:system_loja/core/utils/utils_extensions.dart';

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
    final clientes = await repository.carregarClientes();
    return clientes[id];
  }

  /// Obtém todos os clientes
  /// Caso nenhum cliente esteja cadastrado, retorna uma lista vazia.
  Future<Map<int, Customer>> obterTodosClientes() {
    return repository.carregarClientes();
  }

  /// Salva dados de forma segura e sincronizada (para Flutter GUI)
  ///
  /// Utiliza um lock para serializar o acesso ao arquivo e recarrega
  /// os dados antes de salvar para mesclar alterações de outras instâncias.
  /// Resolve conflitos de ID atribuindo novos IDs para itens novos.
  Future<OperationResult<Customer, CustomerException>> addNewCustomer({
    required CustomerInfo customerInfo,
  }) async {
    return await _getLock()
        .synchronized<OperationResult<Customer, CustomerException>>(() async {
          // Recarrega dados do arquivo para obter a versão mais recente
          final dadosAtuais = await repository.carregarClientes();
          int novoId = dadosAtuais.novoId;
          Customer customer = Customer.withData(
            id: novoId,
            customerInfo: customerInfo,
          );
          // Verifica se o cliente já existe (por ID)
          if (dadosAtuais.containsKey(customer.id)) {
            throw CustomerException(
              'Conflito de ID ao salvar cliente: ID ${customer.id} já existe.',
            );
          }
          bool sucesso = await repository.salvarNovoCliente(customer);
          if (!sucesso) {
            logError(
              'Falha ao salvar novo cliente: $customer',
              StackTrace.current,
            );
            return OperationError(
              CustomerException('Falha ao salvar novo cliente'),
            );
          }

          return OperationSuccess(customer);
        });
  }

  /// Obtém ou cria um lock para o arquivo específico
  Lock _getLock() {
    return _fileLocks.putIfAbsent(repository.toString(), Lock.new);
  }
}
