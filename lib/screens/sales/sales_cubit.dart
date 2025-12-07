import 'package:bloc/bloc.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/repository/customer_repository.dart';
import 'package:system_loja/core/repository/sales_repository.dart';
import 'package:system_loja/screens/sales/sales_state.dart';
import 'package:system_loja/screens/settings/settings_service.dart';

class SalesCubit extends Cubit<SalesState> {
  late SalesRepository _salesRepository;
  late CustomerRepository _customerRepository;
  SalesCubit() : super(SalesInitial()) {
    _salesRepository = SalesRepository(
      settingsApp: SettingsService()
          .currentSettings, // Provide appropriate SettingsApp instance
    );
    _customerRepository = CustomerRepository(
      settingsApp: SettingsService().currentSettings,
    );
  }
  void loadAllCustomers() async {
    // Implement loading customers logic here
    emit(SalesState.loading());
    // Assuming you have a method to load customers in SalesRepository
    final customers = await _customerRepository.loadAll();
    emit(SalesState.loadedCustomers(customers: customers));
  }

  void loadSales() async {
    // Implement loading sales logic here
    emit(SalesState.loading());
    final sales = await _salesRepository.loadAllSales();

    emit(SalesState.loaded(items: sales));
  }

  void registerSale(InvoiceData invoiceData) async {
    emit(SalesState.loading());
    final invoice = Invoice(
      id: _salesRepository.getNextSaleId(),
      data: invoiceData,
    );
    await _salesRepository.saveSale(invoice);
    loadSales();
  }
}
