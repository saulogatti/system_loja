import 'package:flutter_test/flutter_test.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
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
  late InvoiceSqlManager notaFiscalManager;

  setUpAll(() async {
    // Configura um banco de dados em memória para testes
    databaseFactory = databaseFactoryFfi;
  });

  setUp(() async {
    // Reset da instância do banco antes de cada teste
    DatabaseHelper.resetInstance();
    clienteManager = ClienteSqlManager();
    produtoManager = ProdutoSqlManager();
    notaFiscalManager = InvoiceSqlManager();
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 2,
          unitPrice: produto1.preco,
        ),
        InvoiceItem(
          productId: produto2.id,
          productName: produto2.nome,
          productCode: produto2.codigo,
          quantity: 3,
          unitPrice: produto2.preco,
        ),
      ];

      final notaFiscal = Invoice(
        id: 0,
        data: InvoiceData(
          invoiceNumber: 'NF-001',
          customerId: cliente.id,
          customerName: cliente.name,
          customerCpf: cliente.cpf,
          items: itens,
          paymentMethod: 'Cartão',
        ),
      );

      // Act
      final id = await notaFiscalManager.atualizar(notaFiscal);

      // Assert
      expect(id, greaterThan(0));

      final notaInserida = await notaFiscalManager.consultarPorId(id);
      expect(notaInserida, isNotNull);
      expect(notaInserida!.data.invoiceNumber, equals('NF-001'));
      expect(notaInserida.data.items.length, equals(2));
      expect(
        notaInserida.data.totalValue,
        equals(7450.00),
      ); // (2*3500) + (3*150)
    });

    test(
      'deve lançar exceção ao atualizar nota com número duplicado',
      () async {
        // Arrange
        final dados = await criarDadosTeste();
        final cliente = dados['cliente'] as Customer;
        final produto1 = dados['produto1'] as Produto;

        final itens = [
          InvoiceItem(
            productId: produto1.id,
            productName: produto1.nome,
            productCode: produto1.codigo,
            quantity: 1,
            unitPrice: produto1.preco,
          ),
        ];

        final nota1 = Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-001',
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Dinheiro',
          ),
        );

        final nota2 = Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-001', // Mesmo número
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Pix',
          ),
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 1,
          unitPrice: produto1.preco,
        ),
      ];

      final notaFiscal = Invoice(
        id: 0,
        data: InvoiceData(
          invoiceNumber: 'NF-002',
          customerId: cliente.id,
          customerName: cliente.name,
          customerCpf: cliente.cpf,
          items: itens,
          paymentMethod: 'Cartão',
        ),
      );

      await notaFiscalManager.atualizar(notaFiscal);

      // Act
      final notaEncontrada = await notaFiscalManager.consultarPorNumero(
        'NF-002',
      );

      // Assert
      expect(notaEncontrada, isNotNull);
      expect(notaEncontrada!.data.paymentMethod, equals('Cartão'));
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 1,
          unitPrice: produto1.preco,
        ),
      ];

      final notaFiscal = Invoice(
        id: 0,
        data: InvoiceData(
          invoiceNumber: 'NF-003',
          customerId: cliente.id,
          customerName: cliente.name,
          customerCpf: cliente.cpf,
          items: itens,
          paymentMethod: 'Pix',
        ),
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 1,
          unitPrice: produto1.preco,
        ),
      ];

      final nota1 = Invoice(
        id: 0,
        data: InvoiceData(
          invoiceNumber: 'NF-001',
          customerId: cliente.id,
          customerName: cliente.name,
          customerCpf: cliente.cpf,
          items: itens,
          paymentMethod: 'Dinheiro',
        ),
      );

      final nota2 = Invoice(
        id: 0,
        data: InvoiceData(
          invoiceNumber: 'NF-002',
          customerId: cliente.id,
          customerName: cliente.name,
          customerCpf: cliente.cpf,
          items: itens,
          paymentMethod: 'Cartão',
        ),
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 1,
          unitPrice: produto1.preco,
        ),
      ];

      // Notas para cliente 1
      await notaFiscalManager.atualizar(
        Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-001',
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Dinheiro',
          ),
        ),
      );

      await notaFiscalManager.atualizar(
        Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-002',
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Cartão',
          ),
        ),
      );

      // Nota para cliente 2
      await notaFiscalManager.atualizar(
        Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-003',
            customerId: cliente2Inserido!.id,
            customerName: cliente2Inserido.name,
            customerCpf: cliente2Inserido.cpf,
            items: itens,
            paymentMethod: 'Pix',
          ),
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
        InvoiceItem(
          productId: produto1.id,
          productName: produto1.nome,
          productCode: produto1.codigo,
          quantity: 1,
          unitPrice: produto1.preco,
        ),
      ];

      await notaFiscalManager.atualizar(
        Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-001',
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Dinheiro',
          ),
        ),
      );

      await notaFiscalManager.atualizar(
        Invoice(
          id: 0,
          data: InvoiceData(
            invoiceNumber: 'NF-002',
            customerId: cliente.id,
            customerName: cliente.name,
            customerCpf: cliente.cpf,
            items: itens,
            paymentMethod: 'Cartão',
          ),
        ),
      );

      // Act
      final total = await notaFiscalManager.contarTotal();

      // Assert
      expect(total, equals(2));
    });
  });
}
