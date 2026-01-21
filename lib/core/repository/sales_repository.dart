import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/data/database/dao/invoice_dao.dart';

/// Repositório para gerenciamento de vendas usando Drift
///
/// Responsável por coordenar operações de CRUD de vendas (invoices)
/// utilizando os DAOs do Drift.
class SalesRepository {
  final InvoiceDao _invoiceDao;

  SalesRepository({required InvoiceDao invoiceDao}) : _invoiceDao = invoiceDao;

  /// Deleta uma venda pelo ID
  ///
  /// Remove a nota fiscal e seus itens (cascade).
  Future<void> deleteSale(int id) async {
    try {
      await _invoiceDao.deleteInvoice(id);
    } catch (e) {
      throw Exception('Erro ao deletar venda: $e');
    }
  }

  /// Obtém o próximo ID disponível para uma nova venda
  ///
  /// Retorna 1 se não houver vendas, caso contrário retorna o maior ID + 1.
  Future<int> getNextSaleId() async {
    final allInvoices = await loadAllSales();
    if (allInvoices.isEmpty) {
      return 1;
    }
    final maxId = allInvoices.keys.reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  /// Busca uma venda por ID
  ///
  /// Retorna null se não encontrar.
  Future<Invoice?> getSaleById(int id) async {
    try {
      return await _invoiceDao.getById(id);
    } catch (e) {
      throw Exception('Erro ao buscar venda: $e');
    }
  }

  /// Carrega todas as vendas do banco de dados
  ///
  /// Retorna um Map com ID como chave e Invoice como valor.
  /// Lança exceção se houver erro no carregamento.
  Future<Map<int, Invoice>> loadAllSales() async {
    try {
      final invoices = await _invoiceDao.getAll();
      final Map<int, Invoice> sales = {};

      for (final invoice in invoices) {
        sales[invoice.id] = invoice;
      }

      return sales;
    } catch (e) {
      throw Exception('Erro ao carregar vendas: $e');
    }
  }

  /// Salva uma nova venda no banco de dados
  ///
  /// Salva tanto a nota fiscal quanto seus itens em uma transação.
  /// Lança exceção se houver erro ao salvar.
  Future<void> saveSale(Invoice invoice) async {
    try {
      await _invoiceDao.insertInvoiceWithItems(invoice);
    } catch (e) {
      throw Exception('Erro ao salvar venda: $e');
    }
  }

  /// Atualiza uma venda existente
  ///
  /// Atualiza a nota fiscal e seus itens.
  /// Remove itens antigos e insere os novos dentro de uma transação.
  Future<void> updateSale(Invoice invoice) async {
    try {
      await _invoiceDao.updateInvoiceWithItems(invoice);
    } catch (e) {
      throw Exception('Erro ao atualizar venda: $e');
    }
  }
}
