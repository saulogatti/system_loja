import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/command_result.dart';

/// Interface que define o contrato para operações de repositório de clientes.
///
/// Esta interface abstrai as operações CRUD (Create, Read, Update, Delete)
/// para entidades [Customer], permitindo diferentes implementações de
/// persistência (Drift, JSON, etc.).
///
/// As operações incluem busca por CPF, mapeamento de clientes por ID,
/// e gerenciamento completo do cadastro de clientes.
///
/// Exemplo de uso:
/// ```dart
/// final repository = AppInjection.instance.customerRepository;
/// final resultado = await repository.findWith(cpf: '12345678900');
/// if (resultado.isSuccessful && resultado.asSuccess != null) {
///   final customer = resultado.asSuccess!;
///   print('Cliente: ${customer.name}');
/// }
/// ```
///
/// Veja também:
/// - [Customer] - modelo de domínio de cliente
/// - [ResultStatus] - tipo de retorno para operações
abstract interface class ICustomerRepository {
  /// Remove um cliente do sistema pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do cliente a ser removido
  ///
  /// Retorna:
  /// - [ResultStatus] com true se removido com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> deleteClient(int id);

  /// Retorna todos os clientes mapeados por ID.
  ///
  /// Útil para acesso rápido a clientes por ID sem necessidade de busca.
  ///
  /// Retorna:
  /// - [ResultStatus] com `Map<int, Customer>` ou mensagem de erro
  Future<ResultStatus<Map<int, Customer>, String>> fetchMappedCustomers();

  /// Busca um cliente específico pelo ID.
  ///
  /// Parâmetros:
  /// - [id]: ID único do cliente
  ///
  /// Retorna:
  /// - [ResultStatus] com o cliente encontrado (ou null) ou mensagem de erro
  Future<ResultStatus<Customer?, String>> findCustomerById(int id);

  /// Busca um cliente pelo CPF.
  ///
  /// Útil para validação e verificação de duplicidade de CPF.
  ///
  /// Parâmetros:
  /// - [cpf]: CPF do cliente no formato com ou sem formatação
  ///
  /// Retorna:
  /// - [ResultStatus] com o cliente encontrado (ou null) ou mensagem de erro
  Future<ResultStatus<Customer?, String>> findWith({required String cpf});

  /// Retorna todos os clientes cadastrados no sistema.
  ///
  /// Retorna:
  /// - [ResultStatus] com lista de clientes ou mensagem de erro
  Future<ResultStatus<List<Customer>, String>> getAllCustomers();

  /// Salva um novo cliente no sistema.
  ///
  /// Para clientes sem ID ou com ID = 0, será criado um novo registro.
  ///
  /// Parâmetros:
  /// - [customer]: Objeto Customer a ser salvo
  ///
  /// Retorna:
  /// - [ResultStatus] com true se salvo com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> saveCustomer(Customer customer);

  /// Atualiza os dados de um cliente existente.
  ///
  /// O cliente deve ter um ID válido.
  ///
  /// Parâmetros:
  /// - [customer]: Objeto Customer com dados atualizados
  ///
  /// Retorna:
  /// - [ResultStatus] com true se atualizado com sucesso ou mensagem de erro
  Future<ResultStatus<bool, String>> updateCustomer(Customer customer);
}
