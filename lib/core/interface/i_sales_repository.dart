import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/utils/command_result.dart';

abstract interface class ISalesRepository {
  Future<ResultStatus<bool, String>> deleteSale(int id);
  Future<ResultStatus<String, String>> generateInvoiceNumber();
  Future<ResultStatus<int, String>> getNextSaleId();
  Future<ResultStatus<Invoice, String>> getSaleById(int id);
  Future<ResultStatus<Map<int, Invoice>, String>> loadAllSales();
  Future<ResultStatus<bool, String>> saveSale(Invoice invoice);
  Future<ResultStatus<bool, String>> updateSale(Invoice invoice);
  Future<ResultStatus<bool, String>> validateInvoiceNumber(String invoiceNumber);
}
