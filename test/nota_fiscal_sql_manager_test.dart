import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/item_nota_fiscal.dart';
import 'package:system_loja/core/models/nota_fiscal.dart';
import 'package:system_loja/core/models/produto.dart';
import 'package:system_loja/data/database/cliente_sql_manager.dart';
import 'package:system_loja/data/database/database_helper.dart';
import 'package:system_loja/data/database/nota_fiscal_sql_manager.dart';
import 'package:system_loja/data/database/produto_sql_manager.dart';

/// Testes do NotaFiscalSqlManager
///
/// Valida as operações de CRUD para notas fiscais no banco de dados SQL.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late ClienteSqlManager clienteManager;
  late ProdutoSqlManager produtoManager;
  late NotaFiscalSqlManager notaFiscalManager;

  setUpAll(() async {
    // Configura um banco de dados em memória para testes
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Reset da instância do banco antes de cada teste
    DatabaseHelper.resetInstance();
    clienteManager = ClienteSqlManager();
    produtoManager = ProdutoSqlManager();
    notaFiscalManager = NotaFiscalSqlManager();
  });

  tearDown(() async {
    // Limpa o banco após cada teste
    final dbHelper = DatabaseHelper();
    await dbHelper.deleteDatabase();
    DatabaseHelper.resetInstance();
  });

  /// Cria dados de teste (cliente e produtos)
  Future<Map<String, dynamic>> criarDadosTeste() async {
    final cliente = Customer(
      id: 0,
      name: 'João Silva',
      cpf: '123.456.789-00',
      email: 'joao@email.com',
      phone: '(11) 99999-9999',
      address: 'Rua Teste, 123',
    );
    final clienteId = await clienteManager.atualizar(cliente);
    final clienteInserido = await clienteManager.consultarPorId(clienteId);

    final produto1 = Produto(
      id: 0,
      nome: 'Notebook',
      codigo: 'NOTE-001',
      preco: 3500.00,
      estoque: 10,
      descricao: 'Notebook Dell',
      categoria: 'Eletrônicos',
    );
    final produto1Id = await produtoManager.atualizar(produto1);
    final produto1Inserido = await produtoManager.consultarPorId(produto1Id);

    final produto2 = Produto(
      id: 0,
      nome: 'Mouse',
      codigo: 'MOUSE-001',
      preco: 150.00,
      estoque: 50,
      descricao: 'Mouse sem fio',
      categoria: 'Periféricos',
    );
    final produto2Id = await produtoManager.atualizar(produto2);
    final produto2Inserido = await produtoManager.consultarPorId(produto2Id);

    return {
      'cliente': clienteInserido,
      'produto1': produto1Inserido,
      'produto2': produto2Inserido,
    };
  }

  group('NotaFiscalSqlManager - Testes de CRUD', () {
    test('deve atualizar uma nota fiscal com sucesso', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;
      final produto2 = dados['produto2'] as Produto;

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 2,
          precoUnitario: produto1.preco,
        ),
        ItemNotaFiscal(
          produtoId: produto2.id,
          produtoNome: produto2.nome,
          produtoCodigo: produto2.codigo,
          quantidade: 3,
          precoUnitario: produto2.preco,
        ),
      ];

      final notaFiscal = NotaFiscal(
        id: 0,
        numeroNota: 'NF-001',
        clienteId: cliente.id,
        clienteNome: cliente.name,
        clienteCpf: cliente.cpf,
        itens: itens,
        formaPagamento: 'Cartão',
      );

      // Act
      final id = await notaFiscalManager.atualizar(notaFiscal);

      // Assert
      expect(id, greaterThan(0));

      final notaInserida = await notaFiscalManager.consultarPorId(id);
      expect(notaInserida, isNotNull);
      expect(notaInserida!.numeroNota, equals('NF-001'));
      expect(notaInserida.itens.length, equals(2));
      expect(notaInserida.valorTotal, equals(7450.00)); // (2*3500) + (3*150)
    });

    test(
      'deve lançar exceção ao atualizar nota com número duplicado',
      () async {
        // Arrange
        final dados = await criarDadosTeste();
        final cliente = dados['cliente'] as Customer;
        final produto1 = dados['produto1'] as Produto;

        final itens = [
          ItemNotaFiscal(
            produtoId: produto1.id,
            produtoNome: produto1.nome,
            produtoCodigo: produto1.codigo,
            quantidade: 1,
            precoUnitario: produto1.preco,
          ),
        ];

        final nota1 = NotaFiscal(
          id: 0,
          numeroNota: 'NF-001',
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Dinheiro',
        );

        final nota2 = NotaFiscal(
          id: 0,
          numeroNota: 'NF-001', // Mesmo número
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Pix',
        );

        // Act & Assert
        await notaFiscalManager.atualizar(nota1);
        expect(
          () => notaFiscalManager.atualizar(nota2),
          throwsA(isA<Exception>()),
        );
      },
    );

    test('deve consultar nota fiscal por número', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 1,
          precoUnitario: produto1.preco,
        ),
      ];

      final notaFiscal = NotaFiscal(
        id: 0,
        numeroNota: 'NF-002',
        clienteId: cliente.id,
        clienteNome: cliente.name,
        clienteCpf: cliente.cpf,
        itens: itens,
        formaPagamento: 'Cartão',
      );

      await notaFiscalManager.atualizar(notaFiscal);

      // Act
      final notaEncontrada = await notaFiscalManager.consultarPorNumero(
        'NF-002',
      );

      // Assert
      expect(notaEncontrada, isNotNull);
      expect(notaEncontrada!.formaPagamento, equals('Cartão'));
    });

    test('deve retornar null ao consultar número inexistente', () async {
      // Act
      final nota = await notaFiscalManager.consultarPorNumero('NF-INEXISTENTE');

      // Assert
      expect(nota, isNull);
    });

    test('deve excluir nota fiscal com sucesso', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 1,
          precoUnitario: produto1.preco,
        ),
      ];

      final notaFiscal = NotaFiscal(
        id: 0,
        numeroNota: 'NF-003',
        clienteId: cliente.id,
        clienteNome: cliente.name,
        clienteCpf: cliente.cpf,
        itens: itens,
        formaPagamento: 'Pix',
      );

      final id = await notaFiscalManager.atualizar(notaFiscal);

      // Act
      final linhasAfetadas = await notaFiscalManager.excluir(id);

      // Assert
      expect(linhasAfetadas, equals(1));

      final notaExcluida = await notaFiscalManager.consultarPorId(id);
      expect(notaExcluida, isNull);
    });

    test('deve listar todas as notas fiscais', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 1,
          precoUnitario: produto1.preco,
        ),
      ];

      final nota1 = NotaFiscal(
        id: 0,
        numeroNota: 'NF-001',
        clienteId: cliente.id,
        clienteNome: cliente.name,
        clienteCpf: cliente.cpf,
        itens: itens,
        formaPagamento: 'Dinheiro',
      );

      final nota2 = NotaFiscal(
        id: 0,
        numeroNota: 'NF-002',
        clienteId: cliente.id,
        clienteNome: cliente.name,
        clienteCpf: cliente.cpf,
        itens: itens,
        formaPagamento: 'Cartão',
      );

      await notaFiscalManager.atualizar(nota1);
      await notaFiscalManager.atualizar(nota2);

      // Act
      final notas = await notaFiscalManager.listarTodas();

      // Assert
      expect(notas.length, equals(2));
    });

    test('deve buscar notas fiscais por cliente', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;

      // Cria outro cliente
      final cliente2 = Customer(
        id: 0,
        name: 'Maria Santos',
        cpf: '987.654.321-00',
        email: 'maria@email.com',
        phone: '(11) 88888-8888',
        address: 'Rua Outra, 456',
      );
      final cliente2Id = await clienteManager.atualizar(cliente2);
      final cliente2Inserido = await clienteManager.consultarPorId(cliente2Id);

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 1,
          precoUnitario: produto1.preco,
        ),
      ];

      // Notas para cliente 1
      await notaFiscalManager.atualizar(
        NotaFiscal(
          id: 0,
          numeroNota: 'NF-001',
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Dinheiro',
        ),
      );

      await notaFiscalManager.atualizar(
        NotaFiscal(
          id: 0,
          numeroNota: 'NF-002',
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Cartão',
        ),
      );

      // Nota para cliente 2
      await notaFiscalManager.atualizar(
        NotaFiscal(
          id: 0,
          numeroNota: 'NF-003',
          clienteId: cliente2Inserido!.id,
          clienteNome: cliente2Inserido.name,
          clienteCpf: cliente2Inserido.cpf,
          itens: itens,
          formaPagamento: 'Pix',
        ),
      );

      // Act
      final notasCliente1 = await notaFiscalManager.buscarPorCliente(
        cliente.id,
      );

      // Assert
      expect(notasCliente1.length, equals(2));
    });

    test('deve contar o total de notas fiscais', () async {
      // Arrange
      final dados = await criarDadosTeste();
      final cliente = dados['cliente'] as Customer;
      final produto1 = dados['produto1'] as Produto;

      final itens = [
        ItemNotaFiscal(
          produtoId: produto1.id,
          produtoNome: produto1.nome,
          produtoCodigo: produto1.codigo,
          quantidade: 1,
          precoUnitario: produto1.preco,
        ),
      ];

      await notaFiscalManager.atualizar(
        NotaFiscal(
          id: 0,
          numeroNota: 'NF-001',
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Dinheiro',
        ),
      );

      await notaFiscalManager.atualizar(
        NotaFiscal(
          id: 0,
          numeroNota: 'NF-002',
          clienteId: cliente.id,
          clienteNome: cliente.name,
          clienteCpf: cliente.cpf,
          itens: itens,
          formaPagamento: 'Cartão',
        ),
      );

      // Act
      final total = await notaFiscalManager.contarTotal();

      // Assert
      expect(total, equals(2));
    });
  });
}
