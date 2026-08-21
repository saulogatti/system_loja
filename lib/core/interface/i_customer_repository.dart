import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/utils/result_status.dart';

/// Contrato de persistência de clientes exposto à UI.
///
/// {@category contratos}
/// {@subCategory Cadastros}
///
/// Operações CRUD de [Customer] via Drift. Erros voltam como
/// [ResultStatus.error] — a apresentação não usa `try/catch` nestas chamadas.
///
/// Resolver com `appInjection.get<ICustomerRepository>()`.
///
/// ```dart
/// final repository = appInjection.get<ICustomerRepository>();
/// final resultado = await repository.findWith(cpf: '12345678900');
/// resultado.when(
///   onSuccess: (customer) => print(customer?.name),
///   onError: (mensagem) => print(mensagem),
/// );
/// ```
///
/// Veja também:
/// - [Customer] — modelo de domínio
/// - [ResultStatus] — retorno das operações
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
