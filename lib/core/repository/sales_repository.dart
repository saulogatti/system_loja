import 'package:system_loja/core/managers/default/default_manager.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/data/storage/storage_data.dart';

class SalesRepository extends DefaultManager {
  SalesRepository({required super.settingsApp});
  Future<Map<int, NotaFiscal>> loadAllSales() async {
    final result = await defaultDataStorage.loadAll();
    switch (result) {
      case OperationSuccess(result: final dataList):
        Map<int, NotaFiscal> sales = {};
        for (var data in dataList) {
          final sale = NotaFiscal.fromJson(data.data);
          sales[sale.id] = sale;
        }
        return sales;
      case OperationError(error: final errorMessage):
        throw Exception('Erro ao carregar vendas: $errorMessage');
    }
  }

  Future<void> saveSale(NotaFiscal notaFiscal) async {
    final PersistentDataStore dataStore = PersistentDataStore(
      id: notaFiscal.id,
      data: notaFiscal.toJson(),
    );
    // Implement save sale logic here
    await defaultDataStorage.save(dataStore);
  }
  
}
