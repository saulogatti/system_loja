// import 'package:flutter_test/flutter_test.dart';
// import 'package:system_loja/core/models/customer.dart';
// import 'package:system_loja/data/database/cliente_sql_manager.dart';
// import 'package:system_loja/data/database/database_helper.dart';

// /// Testes do ClienteSqlManager
// ///
// /// Valida as operações de CRUD para clientes no banco de dados SQL.
// void main() {
//   // Inicializa o FFI para testes em ambiente desktop

//   late ClienteSqlManager clienteManager;

//   setUpAll(()  {
//     // Configura um banco de dados em memória para testes
//     databaseFactory = databaseFactoryFfi;
//   });

//   setUp(()  {
//     // Reset da instância do banco antes de cada teste
//     DatabaseHelper.resetInstance();
//     clienteManager = ClienteSqlManager();
//   });

//   tearDown(() async {
//     // Limpa o banco após cada teste
//     final dbHelper = DatabaseHelper();
//     await dbHelper.deleteDatabase();
//     DatabaseHelper.resetInstance();
//   });

//   group('ClienteSqlManager - Testes de CRUD', () {
//     test('deve inserir um cliente com sucesso', () async {
//       // Arrange
//       final cliente = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 99999-9999',
//         address: 'Rua Teste, 123',
//       );

//       // Act
//       final id = await clienteManager.inserir(cliente);

//       // Assert
//       expect(id, greaterThan(0));

//       final clienteInserido = await clienteManager.consultarPorId(id);
//       expect(clienteInserido, isNotNull);
//       expect(clienteInserido!.name, equals('João Silva'));
//       expect(clienteInserido.cpf, equals('123.456.789-00'));
//     });

//     test('deve lançar exceção ao inserir cliente com CPF duplicado', () async {
//       // Arrange
//       final cliente1 = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 99999-9999',
//         address: 'Rua Teste, 123',
//       );

//       final cliente2 = Customer(
//         id: 0,
//         name: 'Maria Santos',
//         cpf: '123.456.789-00', // Mesmo CPF
//         email: 'maria@email.com',
//         phone: '(11) 88888-8888',
//         address: 'Rua Outra, 456',
//       );

//       // Act & Assert
//       await clienteManager.inserir(cliente1);
//       expect(() => clienteManager.inserir(cliente2), throwsA(isA<Exception>()));
//     });

//     test('deve consultar cliente por CPF', () async {
//       // Arrange
//       final cliente = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 99999-9999',
//         address: 'Rua Teste, 123',
//       );

//       await clienteManager.inserir(cliente);

//       // Act
//       final clienteEncontrado = await clienteManager.consultarPorCpf(
//         '123.456.789-00',
//       );

//       // Assert
//       expect(clienteEncontrado, isNotNull);
//       expect(clienteEncontrado!.name, equals('João Silva'));
//     });

//     test('deve retornar null ao consultar CPF inexistente', () async {
//       // Act
//       final cliente = await clienteManager.consultarPorCpf('000.000.000-00');

//       // Assert
//       expect(cliente, isNull);
//     });

//     test('deve atualizar cliente com sucesso', () async {
//       // Arrange
//       final cliente = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 99999-9999',
//         address: 'Rua Teste, 123',
//       );

//       final id = await clienteManager.inserir(cliente);

//       // Act
//       final clienteAtualizado = Customer(
//         id: id,
//         name: 'João Silva Santos',
//         cpf: '123.456.789-00',
//         email: 'joao.santos@email.com',
//         phone: '(11) 77777-7777',
//         address: 'Rua Nova, 789',
//       );

//       final linhasAfetadas = await clienteManager.atualizar(clienteAtualizado);

//       // Assert
//       expect(linhasAfetadas, equals(1));

//       final clienteConsultado = await clienteManager.consultarPorId(id);
//       expect(clienteConsultado!.name, equals('João Silva Santos'));
//       expect(clienteConsultado.email, equals('joao.santos@email.com'));
//     });

//     test('deve excluir cliente com sucesso', () async {
//       // Arrange
//       final cliente = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '123.456.789-00',
//         email: 'joao@email.com',
//         phone: '(11) 99999-9999',
//         address: 'Rua Teste, 123',
//       );

//       final id = await clienteManager.inserir(cliente);

//       // Act
//       final linhasAfetadas = await clienteManager.excluir(id);

//       // Assert
//       expect(linhasAfetadas, equals(1));

//       final clienteExcluido = await clienteManager.consultarPorId(id);
//       expect(clienteExcluido, isNull);
//     });

//     test('deve listar todos os clientes', () async {
//       // Arrange
//       final cliente1 = Customer(
//         id: 0,
//         name: 'Ana Costa',
//         cpf: '111.111.111-11',
//         email: 'ana@email.com',
//         phone: '(11) 11111-1111',
//         address: 'Rua A, 1',
//       );

//       final cliente2 = Customer(
//         id: 0,
//         name: 'Bruno Lima',
//         cpf: '222.222.222-22',
//         email: 'bruno@email.com',
//         phone: '(11) 22222-2222',
//         address: 'Rua B, 2',
//       );

//       await clienteManager.inserir(cliente1);
//       await clienteManager.inserir(cliente2);

//       // Act
//       final clientes = await clienteManager.listarTodos();

//       // Assert
//       expect(clientes.length, equals(2));
//       // Ordenado por nome
//       expect(clientes[0].name, equals('Ana Costa'));
//       expect(clientes[1].name, equals('Bruno Lima'));
//     });

//     test('deve buscar clientes por nome', () async {
//       // Arrange
//       final cliente1 = Customer(
//         id: 0,
//         name: 'João Silva',
//         cpf: '111.111.111-11',
//         email: 'joao@email.com',
//         phone: '(11) 11111-1111',
//         address: 'Rua A, 1',
//       );

//       final cliente2 = Customer(
//         id: 0,
//         name: 'João Santos',
//         cpf: '222.222.222-22',
//         email: 'joaos@email.com',
//         phone: '(11) 22222-2222',
//         address: 'Rua B, 2',
//       );

//       final cliente3 = Customer(
//         id: 0,
//         name: 'Maria Lima',
//         cpf: '333.333.333-33',
//         email: 'maria@email.com',
//         phone: '(11) 33333-3333',
//         address: 'Rua C, 3',
//       );

//       await clienteManager.inserir(cliente1);
//       await clienteManager.inserir(cliente2);
//       await clienteManager.inserir(cliente3);

//       // Act
//       final clientesJoao = await clienteManager.buscarPorNome('João');

//       // Assert
//       expect(clientesJoao.length, equals(2));
//     });

//     test('deve contar o total de clientes', () async {
//       // Arrange
//       final cliente1 = Customer(
//         id: 0,
//         name: 'Cliente 1',
//         cpf: '111.111.111-11',
//         email: 'c1@email.com',
//         phone: '(11) 11111-1111',
//         address: 'Rua 1',
//       );

//       final cliente2 = Customer(
//         id: 0,
//         name: 'Cliente 2',
//         cpf: '222.222.222-22',
//         email: 'c2@email.com',
//         phone: '(11) 22222-2222',
//         address: 'Rua 2',
//       );

//       await clienteManager.inserir(cliente1);
//       await clienteManager.inserir(cliente2);

//       // Act
//       final total = await clienteManager.contarTotal();

//       // Assert
//       expect(total, equals(2));
//     });
//   });
// }
