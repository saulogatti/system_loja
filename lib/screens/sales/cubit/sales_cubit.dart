import 'package:bloc/bloc.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/repository/customer_repository.dart';
import 'package:system_loja/core/repository/product_repository.dart';
import 'package:system_loja/core/repository/sales_repository.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/injection/app_injection.dart';
import 'package:system_loja/screens/sales/sales_state.dart';

/// Cubit para gerenciamento de estado de vendas
///
/// Coordena as operações de vendas usando os repositories
/// e emite estados apropriados para a UI.
class SalesCubit extends Cubit<SalesState> {
  late SalesRepository _salesRepository;
  late final CustomerRepository _customerRepository = CustomerRepository();

  final _productRepository = ProductRepository();

  SalesCubit() : super(SalesInitial()) {
    _salesRepository = SalesRepository(

    );
  }

  /// Deleta uma venda pelo ID
  Future<void> deleteSale(int id) async {
    emit(SalesState.loading());
    final result = await _salesRepository.deleteSale(id);

    switch (result) {
      case ResultSuccess():
        final updatedSalesResult = await _salesRepository.loadAllSales();
        switch (updatedSalesResult) {
          case ResultSuccess(result: final sales):
            emit(SalesState.loaded(items: sales));
          case ResultError(resultError: final error):
            emit(SalesState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
    }
  }

  /// Carrega todos os clientes disponíveis
  Future<void> loadAllCustomers() async {
    emit(SalesState.loading());
    final resultMap = await _customerRepository.fetchMappedCustomers();
    switch (resultMap) {
      case ResultSuccess(result: final customers):
        emit(SalesState.loadedCustomers(customers: customers));
      case ResultError(resultError: final error):
        emit(SalesState.error(message: 'Erro ao carregar clientes: $error'));
    }
  }

  /// Carrega todos os produtos disponíveis
  Future<void> loadProducts() async {
    emit(SalesState.loadingProducts());
    final result = await _productRepository.fetchProducts();

    switch (result) {
      case ResultSuccess(result: final products):
        emit(SalesState.loadedProducts(products: products));
      case ResultError(resultError: final resultError):
        emit(
          SalesState.loadProductsFailure(
            message: 'Erro ao carregar produtos: $resultError',
          ),
        );
    }
  }

  /// Carrega todas as vendas cadastradas
  Future<void> loadSales() async {
    emit(SalesState.loading());
    final result = await _salesRepository.loadAllSales();

    switch (result) {
      case ResultSuccess(result: final sales):
        emit(SalesState.loaded(items: sales));
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
    }
  }

  /// Registra uma nova venda
  ///
  /// Cria um novo invoice com ID gerado automaticamente
  /// e salva no banco de dados.
  Future<void> registerSale(
    InvoiceData invoiceData,
    bool enableCodeGeneration,
  ) async {
    emit(SalesState.loading());

    // Gerar número da nota se necessário
    if (enableCodeGeneration) {
      final invoiceNumberResult = await _salesRepository
          .generateInvoiceNumber();
      switch (invoiceNumberResult) {
        case ResultSuccess(result: final invoiceNumber):
          invoiceData.invoiceNumber = invoiceNumber;
        case ResultError(resultError: final error):
          emit(SalesState.error(message: error));
          return;
      }
    }

    // Obter próximo ID
    final nextIdResult = await _salesRepository.getNextSaleId();
    final int nextId;
    switch (nextIdResult) {
      case ResultSuccess(result: final id):
        nextId = id;
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
        return;
    }

    // Criar e salvar invoice
    final invoice = Invoice(id: nextId, data: invoiceData);

    final saveResult = await _salesRepository.saveSale(invoice);
    switch (saveResult) {
      case ResultSuccess():
        final updatedSalesResult = await _salesRepository.loadAllSales();
        switch (updatedSalesResult) {
          case ResultSuccess(result: final sales):
            emit(SalesState.saved(items: sales));
          case ResultError(resultError: final error):
            emit(SalesState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
    }
  }

  /// Atualiza uma venda existente
  Future<void> updateSale(Invoice invoice) async {
    emit(SalesState.loading());
    final result = await _salesRepository.updateSale(invoice);

    switch (result) {
      case ResultSuccess():
        final updatedSalesResult = await _salesRepository.loadAllSales();
        switch (updatedSalesResult) {
          case ResultSuccess(result: final sales):
            emit(SalesState.loaded(items: sales));
          case ResultError(resultError: final error):
            emit(SalesState.error(message: error));
        }
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
    }
  }
}
