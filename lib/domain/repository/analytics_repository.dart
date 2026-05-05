import 'package:system_loja/application/system_error_manager.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';
import 'package:system_loja/core/models/analytics_point.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/utils/result_status.dart';
import 'package:system_loja/data/database/dao/invoice_dao.dart';

/// Repositório de analytics de vendas e compras.
///
/// Agrega dados de [InvoiceDao] para produzir listas de [AnalyticsPoint]
/// agrupadas por data ou por produto, sem lógica de negócio na camada de UI.
class AnalyticsRepository implements IAnalyticsRepository {
  final InvoiceDao _invoiceDao;

  AnalyticsRepository({required InvoiceDao invoiceDao})
    : _invoiceDao = invoiceDao;

  /// Agrupamento por data de emissão (DD/MM).
  ///
  /// Carrega notas de saída (vendas) e entrada (compras) separadamente
  /// e as combina num mapa por data para compor os pontos do gráfico.
  @override
  Future<ResultStatus<List<AnalyticsPoint>, String>>
  getAnalyticsByDate() async {
    try {
      final exits = await _invoiceDao.getExitInvoices();
      final entries = await _invoiceDao.getEntryInvoices();

      final salesByDate = <String, _Accumulator>{};
      final purchasesByDate = <String, _Accumulator>{};

      for (final invoice in exits) {
        final label = _dateLabel(invoice.data.issueDate);
        final acc = salesByDate.putIfAbsent(label, _Accumulator.new);
        acc.add(invoice.data.totalValue, _itemCount(invoice));
      }

      for (final invoice in entries) {
        final label = _dateLabel(invoice.data.issueDate);
        final acc = purchasesByDate.putIfAbsent(label, _Accumulator.new);
        acc.add(invoice.data.totalValue, _itemCount(invoice));
      }

      final allDates = {...salesByDate.keys, ...purchasesByDate.keys}.toList()
        ..sort();

      final points = [
        for (final date in allDates)
          AnalyticsPoint(
            label: date,
            salesValue: salesByDate[date]?.value ?? 0.0,
            purchaseValue: purchasesByDate[date]?.value ?? 0.0,
            productsCount:
                (salesByDate[date]?.count ?? 0) +
                (purchasesByDate[date]?.count ?? 0),
          ),
      ];

      return ResultStatus.success(points);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao carregar analytics por data.');
    }
  }

  /// Agrupamento por nome do produto.
  ///
  /// Itera sobre os itens de todas as notas de saída (vendas) e entrada
  /// (compras) e agrupa os totais por nome de produto.
  @override
  Future<ResultStatus<List<AnalyticsPoint>, String>>
  getAnalyticsByProduct() async {
    try {
      final exits = await _invoiceDao.getExitInvoices();
      final entries = await _invoiceDao.getEntryInvoices();

      final salesByProduct = <String, _Accumulator>{};
      final purchasesByProduct = <String, _Accumulator>{};

      for (final invoice in exits) {
        for (final item in invoice.data.items) {
          final acc = salesByProduct.putIfAbsent(
            item.productName,
            _Accumulator.new,
          );
          acc.add(item.totalValue, item.quantity);
        }
      }

      for (final invoice in entries) {
        for (final item in invoice.data.items) {
          final acc = purchasesByProduct.putIfAbsent(
            item.productName,
            _Accumulator.new,
          );
          acc.add(item.totalValue, item.quantity);
        }
      }

      final allProducts = {
        ...salesByProduct.keys,
        ...purchasesByProduct.keys,
      }.toList()..sort();

      final points = [
        for (final product in allProducts)
          AnalyticsPoint(
            label: product,
            salesValue: salesByProduct[product]?.value ?? 0.0,
            purchaseValue: purchasesByProduct[product]?.value ?? 0.0,
            productsCount:
                (salesByProduct[product]?.count ?? 0) +
                (purchasesByProduct[product]?.count ?? 0),
          ),
      ];

      return ResultStatus.success(points);
    } catch (e, stackTrace) {
      await reportError(e, stackTrace);
      return ResultStatus.error('Erro ao carregar analytics por produto.');
    }
  }

  /// Formata a data de emissão como DD/MM para uso como rótulo.
  String _dateLabel(DateTime date) {
    final day = date.day.toString().padLeft(2, '0');
    final month = date.month.toString().padLeft(2, '0');
    return '$day/$month';
  }

  /// Soma as quantidades de todos os itens de uma nota.
  int _itemCount(Invoice invoice) {
    return invoice.data.items.fold(0, (sum, item) => sum + item.quantity);
  }
}

/// Acumulador interno para valor monetário e contagem de itens.
class _Accumulator {
  double value = 0.0;
  int count = 0;

  void add(double v, int c) {
    value += v;
    count += c;
  }
}
