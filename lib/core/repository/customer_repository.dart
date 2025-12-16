import 'package:system_loja/core/managers/exceptions/customer_exception.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/repository/default/base_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';

/// Repositório para gerenciar operações com clientes.
///
/// Implementa o padrão Repository fornecendo uma camada de abstração
/// sobre o armazenamento de dados persistentes ([defaultDataStorage]).
/// Encapsula a lógica de negócio relacionada a clientes, como validações
/// de CPF duplicado e conversão de modelos.
///
/// ## Responsabilidades
/// - Recuperar clientes por ID ou CPF
/// - Listar todos os clientes
/// - Salvar novos clientes com validação de duplicata
/// - Atualizar clientes existentes com validação de CPF
/// - Deletar clientes pelo ID
/// - Lançar [CustomerException] em casos de erro de negócio
///
/// ## Exemplo de Uso
/// ```dart
/// final repository = CustomerRepository();
///
/// // Salvar novo cliente
/// try {
///   await repository.saveNewCustomer(
///     Customer(id: null, name: 'João Silva', cpf: '123.456.789-00'),
///   );
/// } on CustomerException catch (e) {
///   print('Erro: ${e.message}');
/// }
///
/// // Buscar por CPF
/// final cliente = await repository.findWith(cpf: '123.456.789-00');
/// ```
class CustomerRepository extends BaseRepository {
  /// Cria uma instância de [CustomerRepository].
  ///
  /// Herda [defaultDataStorage] da classe mãe [BaseRepository].
  CustomerRepository();

  /// Deleta um cliente pelo seu ID.
  ///
  /// Remove o cliente do armazenamento persistente pelo [id] fornecido.
  ///
  /// ## Parâmetros
  /// - [id]: ID único do cliente a ser deletado
  ///
  /// ## Retorno
  /// Retorna `true` se o cliente foi deletado com sucesso.
  ///
  /// ## Exceções
  /// Lança [CustomerException] se:
  /// - O ID não existe no armazenamento
  /// - Ocorrer erro de acesso ao banco de dados
  ///
  /// ## Exemplo
  /// ```dart
  /// try {
  ///   await repository.deleteWithId(1);
  ///   print('Cliente deletado com sucesso');
  /// } on CustomerException catch (e) {
  ///   print('Erro ao deletar: ${e.message}');
  /// }
  /// ```
  Future<bool> deleteWithId(int id) {
    final result = defaultDataStorage.delete(id);
    return result.then((operationResult) {
      switch (operationResult) {
        case ExecutionSucess(result: final success):
          return success;
        case ExecutionError(failure: final errorMessage):
          throw CustomerException(
            'Erro ao deletar cliente com ID $id: $errorMessage',
          );
      }
    });
  }

  /// Busca um cliente pelo seu CPF.
  ///
  /// Carrega todos os clientes do armazenamento e retorna o primeiro que
  /// corresponda ao CPF fornecido. A busca é case-sensitive.
  ///
  /// ## Parâmetros
  /// - [cpf]: CPF do cliente a ser buscado (sem formatação)
  ///
  /// ## Retorno
  /// Retorna o [Customer] encontrado ou `null` se não existir.
  ///
  /// ## Exceções
  /// Lança [CustomerException] se ocorrer erro ao carregar os dados.
  ///
  /// ## Exemplo
  /// ```dart
  /// final cliente = await repository.findWith(cpf: '123.456.789-00');
  /// if (cliente != null) {
  ///   print('Cliente encontrado: ${cliente.name}');
  /// } else {
  ///   print('Cliente não encontrado');
  /// }
  /// ```
  Future<Customer?> findWith({required String cpf}) async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case ExecutionSucess(result: final dataList):
        for (var data in dataList) {
          final customer = Customer.fromJson(data.data);
          if (customer.cpf == cpf) {
            return customer;
          }
        }
        return null;
      case ExecutionError(failure: final errorMessage):
        throw CustomerException('Erro ao carregar clientes: $errorMessage');
    }
  }

  /// Carrega todos os clientes do armazenamento.
  ///
  /// Recupera todos os clientes persistidos e os organiza em um mapa
  /// onde a chave é o ID do cliente. Retorna um mapa vazio se nenhum
  /// cliente estiver registrado.
  ///
  /// ## Retorno
  /// Mapa com ID como chave e [Customer] como valor.
  /// ```dart
  /// {
  ///   1: Customer(id: 1, name: 'João', cpf: '123...'),
  ///   2: Customer(id: 2, name: 'Maria', cpf: '456...'),
  /// }
  /// ```
  ///
  /// ## Exceções
  /// Lança [CustomerException] se ocorrer erro ao carregar os dados.
  ///
  /// ## Exemplo
  /// ```dart
  /// final clientes = await repository.loadAll();
  /// print('Total de clientes: ${clientes.length}');
  /// clientes.forEach((id, cliente) {
  ///   print('$id: ${cliente.name}');
  /// });
  /// ```
  ///
  /// ## Performance
  /// Este método carrega TODOS os clientes em memória. Para aplicações
  /// com grande volume de dados, considere implementar paginação.
  Future<Map<int, Customer>> loadAll() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case ExecutionSucess(result: final dataList):
        Map<int, Customer> customers = {};
        for (var data in dataList) {
          final customer = Customer.fromJson(data.data);
          customers[customer.id] = customer;
        }
        return customers;
      case ExecutionError(failure: final errorMessage):
        throw CustomerException('Erro ao carregar clientes: $errorMessage');
    }
  }

  /// Salva um novo cliente no armazenamento.
  ///
  /// Cria um novo registro de cliente validando previamente que não existe
  /// outro cliente com o mesmo CPF. Se o cliente já estiver registrado,
  /// lança uma exceção sem modificar o armazenamento.
  ///
  /// ## Parâmetros
  /// - [customer]: O cliente a ser salvo. O ID deve ser `null` para novos clientes.
  ///
  /// ## Retorno
  /// Retorna `true` se o cliente foi salvo com sucesso.
  ///
  /// ## Exceções
  /// Lança [CustomerException] se:
  /// - Já existe um cliente com o mesmo CPF
  /// - Ocorrer erro ao salvar no banco de dados
  ///
  /// ## Validações
  /// - Verifica se o CPF já está registrado
  /// - Serializa o cliente para JSON antes de persistir
  ///
  /// ## Exemplo
  /// ```dart
  /// try {
  ///   final novoCliente = Customer(
  ///     id: null,
  ///     name: 'João Silva',
  ///     cpf: '123.456.789-00',
  ///   );
  ///   await repository.saveNewCustomer(novoCliente);
  ///   print('Cliente salvo com sucesso');
  /// } on CustomerException catch (e) {
  ///   if (e.message.contains('já existe')) {
  ///     print('Este CPF já está cadastrado');
  ///   }
  /// }
  /// ```
  Future<bool> saveNewCustomer(Customer customer) async {
    final exists = await findWith(cpf: customer.cpf);
    if (exists != null) {
      throw CustomerException('Cliente com CPF ${customer.cpf} já existe.');
    }
    final data = customer.toJson();
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: customer.id, data: data),
    );
    return result;
  }

  /// Atualiza um cliente existente no armazenamento.
  ///
  /// Modifica um cliente já registrado validando que:
  /// 1. O CPF buscado existe no banco de dados
  /// 2. O CPF pertence ao mesmo cliente (ID coincide)
  ///
  /// Previne a mudança acidental de CPF para um valor já associado a
  /// outro cliente, mantendo a integridade dos dados.
  ///
  /// ## Parâmetros
  /// - [customer]: O cliente com dados atualizados. Deve ter um ID válido (> 0).
  ///
  /// ## Retorno
  /// Retorna `true` se o cliente foi atualizado com sucesso.
  ///
  /// ## Exceções
  /// Lança [CustomerException] se:
  /// - O CPF do cliente não existe no banco (cliente removido)
  /// - O CPF pertence a outro cliente (CPF em uso)
  /// - Ocorrer erro ao atualizar no banco de dados
  ///
  /// ## Validações
  /// - Busca o cliente pelo CPF no armazenamento
  /// - Verifica se o ID do cliente encontrado corresponde ao do cliente a atualizar
  /// - Serializa o cliente para JSON antes de persistir
  ///
  /// ## Exemplo
  /// ```dart
  /// try {
  ///   final clienteAtualizado = Customer(
  ///     id: 1,
  ///     name: 'João Silva Santos',  // nome modificado
  ///     cpf: '123.456.789-00',      // CPF não muda
  ///   );
  ///   await repository.updateCustomer(clienteAtualizado);
  ///   print('Cliente atualizado com sucesso');
  /// } on CustomerException catch (e) {
  ///   print('Erro: ${e.message}');
  /// }
  /// ```
  ///
  /// ## Comportamento ao Mudar CPF
  /// ```dart
  /// // Se tentar mudar o CPF para um que já existe:
  /// final cliente = Customer(id: 1, name: 'João', cpf: '999.999.999-99');
  /// await repository.updateCustomer(cliente);
  /// // Lança: 'CPF 999.999.999-99 já está associado a outro cliente.'
  /// ```
  Future<bool> updateCustomer(Customer customer) async {
    final exists = await findWith(cpf: customer.cpf);
    if (exists == null) {
      throw CustomerException(
        'Cliente com CPF ${customer.cpf} não encontrado para atualização.',
      );
    } else if (exists.id != customer.id) {
      throw CustomerException(
        'CPF ${customer.cpf} já está associado a outro cliente.',
      );
    }
    final data = customer.toJson();
    final result = await defaultDataStorage.save(
      PersistentDataStore(id: customer.id, data: data),
    );
    return result;
  }
}
