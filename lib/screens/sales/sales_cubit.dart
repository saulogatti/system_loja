import 'package:bloc/bloc.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/repository/cliente_repository.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/repository/sales_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/injection/app_injection.dart';
import 'package:system_loja/screens/sales/sales_state.dart';

class SalesCubit extends Cubit<SalesState> {
  late SalesRepository _salesRepository;
  late final ClienteRepository _customerRepository =
      AppInjection.instance.clienteRepository;
  SalesCubit() : super(SalesInitial()) {
    _salesRepository = SalesRepository();
  }
  Future<void> loadAllCustomers() async {
    // Implement loading customers logic here
    emit(SalesState.loading());
    // Assuming you have a method to load customers in SalesRepository
    final customers = await _customerRepository.listarMapeado();
    emit(SalesState.loadedCustomers(customers: customers));
  }

  Future<void> loadProducts() async {
    emit(SalesState.loadingProducts());
    final productRepository = ProductRepository();
    final result = await productRepository.getProdutos();
    switch (result) {
      case ExecutionSucess(result: final products):
        emit(SalesState.loadedProducts(products: products));
      case ExecutionError(failure: final errorMessage):
        emit(
          SalesState.loadProductsFailure(
            message: 'Erro ao carregar produtos: $errorMessage',
          ),
        );
    }
    // final products = await _productRepository.loadAllProducts();
    // emit(SalesState.loadedProducts(products: products));
  }

  Future<void> loadSales() async {
    // Implement loading sales logic here
    emit(SalesState.loading());
    final sales = await _salesRepository.loadAllSales();

    emit(SalesState.loaded(items: sales));
  }

  Future<void> registerSale(InvoiceData invoiceData) async {
    emit(SalesState.loading());
    final invoice = Invoice(
      id: await _salesRepository.getNextSaleId(),
      data: invoiceData,
    );
    await _salesRepository.saveSale(invoice);
    emit(SalesState.saved(items: await _salesRepository.loadAllSales()));
  }
}
