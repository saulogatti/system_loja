import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/aplication/system_error_manager.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/domain/code_generator_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/database/dao/invoice_dao.dart';

/// Repositório para gerenciamento de vendas usando Drift
///
/// Responsável por coordenar operações de CRUD de vendas (invoices)
/// utilizando os DAOs do Drift.
class SalesRepository implements ISalesRepository {
  final InvoiceDao _invoiceDao;
  final CodeGeneratorService _codeGeneratorService;

  SalesRepository({
    required InvoiceDao invoiceDao,
    required CodeGeneratorService codeGeneratorService,
  }) : _codeGeneratorService = codeGeneratorService,
       _invoiceDao = invoiceDao;

  /// Deleta uma venda pelo ID
  ///
  /// Remove a nota fiscal e seus itens (cascade).
  /// Retorna sucesso ou erro.
  @override
  Future<ResultStatus<bool, String>> deleteSale(int id) async {
    try {
      await _invoiceDao.deleteInvoice(id);
      return ResultSuccess(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao deletar venda.');
    }
  }

  /// Gera um número único para uma nova nota fiscal.
  ///
  /// Retorna um número no formato NF-YYYYMMDD-NNNN que não existe no banco.
  @override
  Future<ResultStatus<String, String>> generateInvoiceNumber() async {
    try {
      final invoiceNumber = await _codeGeneratorService.generateInvoiceNumber();
      return ResultSuccess(invoiceNumber);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao gerar número de nota fiscal.');
    }
  }

  /// Obtém o próximo ID disponível para uma nova venda
  ///
  /// Retorna 1 se não houver vendas, caso contrário retorna o maior ID + 1.
  @override
  Future<ResultStatus<int, String>> getNextSaleId() async {
    try {
      final result = await loadAllSales();
      if (result.hasError) {
        return ResultError(result.asError);
      }
      final allInvoices = result.asSuccess;
      if (allInvoices.isEmpty) {
        return ResultSuccess(1);
      }
      final maxId = allInvoices.keys.reduce((a, b) => a > b ? a : b);
      return ResultSuccess(maxId + 1);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao obter próximo ID.');
    }
  }

  /// Busca uma venda por ID
  ///
  /// Retorna a venda encontrada ou erro se não existir.
  @override
  Future<ResultStatus<Invoice, String>> getSaleById(int id) async {
    try {
      final invoice = await _invoiceDao.getById(id);
      if (invoice != null) {
        return ResultSuccess(invoice);
      }
      return ResultError('Venda com ID $id não encontrada');
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao buscar venda.');
    }
  }

  /// Carrega todas as vendas do banco de dados
  ///
  /// Retorna um Map com ID como chave e Invoice como valor.
  /// Retorna sucesso com o mapa ou erro se houver falha no carregamento.
  @override
  Future<ResultStatus<Map<int, Invoice>, String>> loadAllSales() async {
    try {
      final invoices = await _invoiceDao.getAll();
      final Map<int, Invoice> sales = {};

      for (final invoice in invoices) {
        sales[invoice.id] = invoice;
      }

      return ResultSuccess(sales);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao carregar vendas.');
    }
  }

  /// Carrega apenas notas fiscais de entrada.
  @override
  Future<ResultStatus<Map<int, Invoice>, String>> loadEntryInvoices() async {
    try {
      final invoices = await _invoiceDao.getEntryInvoices();
      return ResultSuccess({for (final i in invoices) i.id: i});
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao carregar notas de entrada.');
    }
  }

  /// Carrega apenas notas fiscais de saída.
  @override
  Future<ResultStatus<Map<int, Invoice>, String>> loadExitInvoices() async {
    try {
      final invoices = await _invoiceDao.getExitInvoices();
      return ResultSuccess({for (final i in invoices) i.id: i});
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao carregar notas de saída.');
    }
  }

  /// Salva uma nova venda no banco de dados
  ///
  /// Salva tanto a nota fiscal quanto seus itens em uma transação.
  /// Retorna sucesso ou erro.
  @override
  Future<ResultStatus<bool, String>> saveSale(Invoice invoice) async {
    try {
      await _invoiceDao.insertInvoiceWithItems(invoice);
      return ResultSuccess(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao salvar venda.');
    }
  }

  /// Atualiza uma venda existente
  ///
  /// Atualiza a nota fiscal e seus itens.
  /// Remove itens antigos e insere os novos dentro de uma transação.
  /// Retorna sucesso ou erro.
  @override
  Future<ResultStatus<bool, String>> updateSale(Invoice invoice) async {
    try {
      await _invoiceDao.updateInvoiceWithItems(invoice);
      return ResultSuccess(true);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao atualizar venda.');
    }
  }

  /// Valida um número de nota fiscal fornecido pelo usuário.
  ///
  /// [invoiceNumber] Número da nota a ser validado.
  /// Retorna sucesso se válido ou erro com mensagem descritiva.
  @override
  Future<ResultStatus<bool, String>> validateInvoiceNumber(
    String invoiceNumber,
  ) async {
    try {
      final validationResult = await _codeGeneratorService
          .validateInvoiceNumber(invoiceNumber);

      if (validationResult.isValid) {
        return ResultSuccess(true);
      } else {
        return ResultError(validationResult.message);
      }
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultError('Erro ao validar número de nota fiscal.');
    }
  }
}
