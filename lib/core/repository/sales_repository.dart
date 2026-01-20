import 'package:system_loja/core/models/invoice.dart';
 import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/base_data_storage.dart';

class SalesRepository extends BaseRepository {
  SalesRepository();
  
  Future<int> getNextSaleId() async {
    final allInvoices = await loadAllSales();
    if (allInvoices.isEmpty) {
      return 1;
    }
    final maxId = allInvoices.keys.reduce((a, b) => a > b ? a : b);
    return maxId + 1;
  }

  Future<Map<int, Invoice>> loadAllSales() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case ExecutionSucess(result: final dataList):
        final Map<int, Invoice> sales = {};
        for (var data in dataList) {
          final sale = Invoice.fromJson(data.data);
          sales[sale.id] = sale;
        }
        return sales;
      case ExecutionError(failure: final errorMessage):
        throw Exception('Erro ao carregar vendas: $errorMessage');
    }
  }

  // TODO: Analisar como salvar itens relacionados à venda e decrementar estoque dos produtos vendidos.
  Future<void> saveSale(Invoice invoice) async {
    final PersistentDataStore dataStore = PersistentDataStore(
      id: invoice.id,
      data: invoice.toJson(),
    );
    // Implement save sale logic here
    await defaultDataStorage.save(dataStore);
  }
}
