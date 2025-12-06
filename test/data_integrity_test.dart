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

/// Testes de integridade de dados
///
/// Valida que a remoção dos campos desnormalizados e o uso de JOINs
/// garantem que as notas fiscais sempre refletem os dados atuais
/// de clientes e produtos.
void main() {
  // Inicializa o FFI para testes em ambiente desktop
  sqfliteFfiInit();
  databaseFactory = databaseFactoryFfi;

  late ClienteSqlManager clienteManager;
  late ProdutoSqlManager produtoManager;
  late NotaFiscalSqlManager notaFiscalManager;

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

  group('Integridade de Dados - Cliente', () {
    test(
      'deve refletir alteração no nome do cliente nas notas fiscais',
      () async {
        // Arrange - Cria cliente
        final cliente = Customer(
          id: 0,
          nome: 'João Silva',
          cpf: '123.456.789-00',
          email: 'joao@email.com',
          telefone: '(11) 99999-9999',
          endereco: 'Rua Teste, 123',
        );
        final clienteId = await clienteManager.inserir(cliente);
        final clienteInserido = await clienteManager.consultarPorId(clienteId);

        // Arrange - Cria produto
        final produto = Produto(
          id: 0,
          nome: 'Notebook',
          codigo: 'NOTE-001',
          preco: 3500.00,
          estoque: 10,
          descricao: 'Notebook Dell',
          categoria: 'Eletrônicos',
        );
        final produtoId = await produtoManager.inserir(produto);
        final produtoInserido = await produtoManager.consultarPorId(produtoId);

        // Arrange - Cria nota fiscal
        final itens = [
          ItemNotaFiscal(
            produtoId: produtoInserido!.id,
            produtoNome: produtoInserido.nome,
            produtoCodigo: produtoInserido.codigo,
            quantidade: 1,
            precoUnitario: produtoInserido.preco,
          ),
        ];

        final notaFiscal = NotaFiscal(
          id: 0,
          numeroNota: 'NF-001',
          clienteId: clienteInserido!.id,
          clienteNome: clienteInserido.nome,
          clienteCpf: clienteInserido.cpf,
          itens: itens,
          formaPagamento: 'Cartão',
        );

        final notaId = await notaFiscalManager.atualizar(notaFiscal);

        // Act - Atualiza o nome do cliente
        final clienteAtualizado = Customer(
          id: clienteId,
          nome: 'João Silva Santos', // Nome alterado
          cpf: '123.456.789-00',
          email: 'joao@email.com',
          telefone: '(11) 99999-9999',
          endereco: 'Rua Teste, 123',
        );
        await clienteManager.atualizar(clienteAtualizado);

        // Assert - Busca a nota fiscal e verifica se o nome foi atualizado
        final notaConsultada = await notaFiscalManager.consultarPorId(notaId);
        expect(notaConsultada, isNotNull);
        expect(notaConsultada!.clienteNome, equals('João Silva Santos'));
        expect(notaConsultada.clienteCpf, equals('123.456.789-00'));
      },
    );

    test(
      'deve refletir alteração no CPF do cliente nas notas fiscais',
      () async {
        // Arrange - Cria cliente
        final cliente = Customer(
          id: 0,
          nome: 'Maria Santos',
          cpf: '987.654.321-00',
          email: 'maria@email.com',
          telefone: '(11) 88888-8888',
          endereco: 'Rua Outra, 456',
        );
        final clienteId = await clienteManager.inserir(cliente);
        final clienteInserido = await clienteManager.consultarPorId(clienteId);

        // Arrange - Cria produto
        final produto = Produto(
          id: 0,
          nome: 'Mouse',
          codigo: 'MOUSE-001',
          preco: 150.00,
          estoque: 50,
          descricao: 'Mouse sem fio',
          categoria: 'Periféricos',
        );
        final produtoId = await produtoManager.inserir(produto);
        final produtoInserido = await produtoManager.consultarPorId(produtoId);

        // Arrange - Cria nota fiscal
        final itens = [
          ItemNotaFiscal(
            produtoId: produtoInserido!.id,
            produtoNome: produtoInserido.nome,
            produtoCodigo: produtoInserido.codigo,
            quantidade: 2,
            precoUnitario: produtoInserido.preco,
          ),
        ];

        final notaFiscal = NotaFiscal(
          id: 0,
          numeroNota: 'NF-002',
          clienteId: clienteInserido!.id,
          clienteNome: clienteInserido.nome,
          clienteCpf: clienteInserido.cpf,
          itens: itens,
          formaPagamento: 'Pix',
        );

        final notaId = await notaFiscalManager.atualizar(notaFiscal);

        // Act - Atualiza o CPF do cliente
        final clienteAtualizado = Customer(
          id: clienteId,
          nome: 'Maria Santos',
          cpf: '111.222.333-44', // CPF alterado
          email: 'maria@email.com',
          telefone: '(11) 88888-8888',
          endereco: 'Rua Outra, 456',
        );
        await clienteManager.atualizar(clienteAtualizado);

        // Assert - Busca a nota fiscal e verifica se o CPF foi atualizado
        final notaConsultada = await notaFiscalManager.consultarPorId(notaId);
        expect(notaConsultada, isNotNull);
        expect(notaConsultada!.clienteNome, equals('Maria Santos'));
        expect(notaConsultada.clienteCpf, equals('111.222.333-44'));
      },
    );
  });

  group('Integridade de Dados - Produto', () {
    test(
      'deve refletir alteração no nome do produto nos itens da nota fiscal',
      () async {
        // Arrange - Cria cliente
        final cliente = Customer(
          id: 0,
          nome: 'Carlos Oliveira',
          cpf: '111.222.333-44',
          email: 'carlos@email.com',
          telefone: '(11) 77777-7777',
          endereco: 'Rua Nova, 789',
        );
        final clienteId = await clienteManager.inserir(cliente);
        final clienteInserido = await clienteManager.consultarPorId(clienteId);

        // Arrange - Cria produto
        final produto = Produto(
          id: 0,
          nome: 'Teclado Mecânico',
          codigo: 'TECLADO-001',
          preco: 500.00,
          estoque: 20,
          descricao: 'Teclado mecânico RGB',
          categoria: 'Periféricos',
        );
        final produtoId = await produtoManager.inserir(produto);
        final produtoInserido = await produtoManager.consultarPorId(produtoId);

        // Arrange - Cria nota fiscal
        final itens = [
          ItemNotaFiscal(
            produtoId: produtoInserido!.id,
            produtoNome: produtoInserido.nome,
            produtoCodigo: produtoInserido.codigo,
            quantidade: 1,
            precoUnitario: produtoInserido.preco,
          ),
        ];

        final notaFiscal = NotaFiscal(
          id: 0,
          numeroNota: 'NF-003',
          clienteId: clienteInserido!.id,
          clienteNome: clienteInserido.nome,
          clienteCpf: clienteInserido.cpf,
          itens: itens,
          formaPagamento: 'Dinheiro',
        );

        final notaId = await notaFiscalManager.atualizar(notaFiscal);

        // Act - Atualiza o nome do produto
        final produtoAtualizado = Produto(
          id: produtoId,
          nome: 'Teclado Mecânico Premium', // Nome alterado
          codigo: 'TECLADO-001',
          preco: 500.00,
          estoque: 20,
          descricao: 'Teclado mecânico RGB premium',
          categoria: 'Periféricos',
        );
        await produtoManager.atualizar(produtoAtualizado);

        // Assert - Busca a nota fiscal e verifica se o nome do produto foi atualizado
        final notaConsultada = await notaFiscalManager.consultarPorId(notaId);
        expect(notaConsultada, isNotNull);
        expect(notaConsultada!.itens.length, equals(1));
        expect(
          notaConsultada.itens[0].produtoNome,
          equals('Teclado Mecânico Premium'),
        );
        expect(notaConsultada.itens[0].produtoCodigo, equals('TECLADO-001'));
      },
    );

    test(
      'deve refletir alteração no código do produto nos itens da nota fiscal',
      () async {
        // Arrange - Cria cliente
        final cliente = Customer(
          id: 0,
          nome: 'Ana Costa',
          cpf: '555.666.777-88',
          email: 'ana@email.com',
          telefone: '(11) 66666-6666',
          endereco: 'Rua Principal, 100',
        );
        final clienteId = await clienteManager.inserir(cliente);
        final clienteInserido = await clienteManager.consultarPorId(clienteId);

        // Arrange - Cria produto
        final produto = Produto(
          id: 0,
          nome: 'Monitor LED',
          codigo: 'MON-001',
          preco: 1200.00,
          estoque: 15,
          descricao: 'Monitor LED 24 polegadas',
          categoria: 'Eletrônicos',
        );
        final produtoId = await produtoManager.inserir(produto);
        final produtoInserido = await produtoManager.consultarPorId(produtoId);

        // Arrange - Cria nota fiscal
        final itens = [
          ItemNotaFiscal(
            produtoId: produtoInserido!.id,
            produtoNome: produtoInserido.nome,
            produtoCodigo: produtoInserido.codigo,
            quantidade: 1,
            precoUnitario: produtoInserido.preco,
          ),
        ];

        final notaFiscal = NotaFiscal(
          id: 0,
          numeroNota: 'NF-004',
          clienteId: clienteInserido!.id,
          clienteNome: clienteInserido.nome,
          clienteCpf: clienteInserido.cpf,
          itens: itens,
          formaPagamento: 'Cartão',
        );

        final notaId = await notaFiscalManager.atualizar(notaFiscal);

        // Act - Atualiza o código do produto
        final produtoAtualizado = Produto(
          id: produtoId,
          nome: 'Monitor LED',
          codigo: 'MONITOR-LED-001', // Código alterado
          preco: 1200.00,
          estoque: 15,
          descricao: 'Monitor LED 24 polegadas',
          categoria: 'Eletrônicos',
        );
        await produtoManager.atualizar(produtoAtualizado);

        // Assert - Busca a nota fiscal e verifica se o código do produto foi atualizado
        final notaConsultada = await notaFiscalManager.consultarPorId(notaId);
        expect(notaConsultada, isNotNull);
        expect(notaConsultada!.itens.length, equals(1));
        expect(notaConsultada.itens[0].produtoNome, equals('Monitor LED'));
        expect(
          notaConsultada.itens[0].produtoCodigo,
          equals('MONITOR-LED-001'),
        );
      },
    );
  });

  group('Integridade de Dados - Consultas Múltiplas', () {
    test(
      'deve refletir dados atualizados em todas as consultas (por ID, número, cliente)',
      () async {
        // Arrange - Cria cliente
        final cliente = Customer(
          id: 0,
          nome: 'Pedro Alves',
          cpf: '999.888.777-66',
          email: 'pedro@email.com',
          telefone: '(11) 55555-5555',
          endereco: 'Rua Central, 200',
        );
        final clienteId = await clienteManager.inserir(cliente);
        final clienteInserido = await clienteManager.consultarPorId(clienteId);

        // Arrange - Cria produto
        final produto = Produto(
          id: 0,
          nome: 'Impressora',
          codigo: 'IMP-001',
          preco: 800.00,
          estoque: 8,
          descricao: 'Impressora multifuncional',
          categoria: 'Eletrônicos',
        );
        final produtoId = await produtoManager.inserir(produto);
        final produtoInserido = await produtoManager.consultarPorId(produtoId);

        // Arrange - Cria nota fiscal
        final itens = [
          ItemNotaFiscal(
            produtoId: produtoInserido!.id,
            produtoNome: produtoInserido.nome,
            produtoCodigo: produtoInserido.codigo,
            quantidade: 1,
            precoUnitario: produtoInserido.preco,
          ),
        ];

        final notaFiscal = NotaFiscal(
          id: 0,
          numeroNota: 'NF-005',
          clienteId: clienteInserido!.id,
          clienteNome: clienteInserido.nome,
          clienteCpf: clienteInserido.cpf,
          itens: itens,
          formaPagamento: 'Boleto',
        );

        final notaId = await notaFiscalManager.atualizar(notaFiscal);

        // Act - Atualiza cliente e produto
        final clienteAtualizado = Customer(
          id: clienteId,
          nome: 'Pedro Alves Junior',
          cpf: '000.111.222-33',
          email: 'pedro@email.com',
          telefone: '(11) 55555-5555',
          endereco: 'Rua Central, 200',
        );
        await clienteManager.atualizar(clienteAtualizado);

        final produtoAtualizado = Produto(
          id: produtoId,
          nome: 'Impressora HP',
          codigo: 'HP-IMP-001',
          preco: 800.00,
          estoque: 8,
          descricao: 'Impressora multifuncional HP',
          categoria: 'Eletrônicos',
        );
        await produtoManager.atualizar(produtoAtualizado);

        // Assert - Consulta por ID
        final notaPorId = await notaFiscalManager.consultarPorId(notaId);
        expect(notaPorId!.clienteNome, equals('Pedro Alves Junior'));
        expect(notaPorId.clienteCpf, equals('000.111.222-33'));
        expect(notaPorId.itens[0].produtoNome, equals('Impressora HP'));
        expect(notaPorId.itens[0].produtoCodigo, equals('HP-IMP-001'));

        // Assert - Consulta por número
        final notaPorNumero = await notaFiscalManager.consultarPorNumero(
          'NF-005',
        );
        expect(notaPorNumero!.clienteNome, equals('Pedro Alves Junior'));
        expect(notaPorNumero.clienteCpf, equals('000.111.222-33'));
        expect(notaPorNumero.itens[0].produtoNome, equals('Impressora HP'));
        expect(notaPorNumero.itens[0].produtoCodigo, equals('HP-IMP-001'));

        // Assert - Consulta por cliente
        final notasPorCliente = await notaFiscalManager.buscarPorCliente(
          clienteId,
        );
        expect(notasPorCliente.length, equals(1));
        expect(notasPorCliente[0].clienteNome, equals('Pedro Alves Junior'));
        expect(notasPorCliente[0].clienteCpf, equals('000.111.222-33'));
        expect(
          notasPorCliente[0].itens[0].produtoNome,
          equals('Impressora HP'),
        );
        expect(notasPorCliente[0].itens[0].produtoCodigo, equals('HP-IMP-001'));

        // Assert - Lista todas
        final todasNotas = await notaFiscalManager.listarTodas();
        expect(todasNotas.length, equals(1));
        expect(todasNotas[0].clienteNome, equals('Pedro Alves Junior'));
        expect(todasNotas[0].clienteCpf, equals('000.111.222-33'));
        expect(todasNotas[0].itens[0].produtoNome, equals('Impressora HP'));
        expect(todasNotas[0].itens[0].produtoCodigo, equals('HP-IMP-001'));
      },
    );
  });
}
