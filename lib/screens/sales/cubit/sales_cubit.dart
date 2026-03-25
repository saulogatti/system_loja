import 'package:bloc/bloc.dart';
import 'package:system_loja/core/interface/i_company_repository.dart';
import 'package:system_loja/core/interface/i_customer_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/interface/i_system_repository.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';

/// Cubit para gerenciamento de estado de vendas.
///
/// Coordena as operações de vendas usando os repositories
/// e emite estados apropriados para a UI.
class SalesCubit extends Cubit<SalesState> {
  final ISalesRepository _salesRepository;
  final ICustomerRepository _customerRepository;
  final IProductRepository _productRepository;
  final ISystemRepository _systemRepository;
  final ICompanyRepository _companyRepository;

  SalesCubit(
    this._salesRepository,
    this._customerRepository,
    this._productRepository,
    this._systemRepository,
    this._companyRepository,
  ) : super(SalesInitial());

  /// Deleta uma venda pelo ID.
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

  /// Carrega todos os clientes disponíveis.
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

  /// Carrega todos os produtos disponíveis, clientes, empresas e notas.
  Future<void> loadProducts() async {
    emit(SalesState.loadingProducts());
    final resultSales = await _salesRepository.loadAllSales();
    final result = await _productRepository.fetchProducts();
    final resultMap = await _customerRepository.fetchMappedCustomers();
    final resultCompanies = await _companyRepository.fetchMappedCompanies();
    final resultSystem = await _systemRepository.getSystemConfiguration();

    late final List<PaymentMethodType> paymentMethods;
    switch (resultSystem) {
      case ResultSuccess(result: final config):
        paymentMethods = config.priceConfiguration.types;
      case ResultError(resultError: final error):
        emit(SalesState.loadProductsFailure(message: error));
        return;
    }

    final Map<int, Customer> customers;
    switch (resultMap) {
      case ResultSuccess(result: final value):
        customers = value;
      case ResultError(resultError: final error):
        emit(SalesState.loadProductsFailure(message: 'Erro ao carregar clientes: $error'));
        return;
    }

    final Map<int, Invoice> invoices;
    switch (resultSales) {
      case ResultSuccess(result: final value):
        invoices = value;
      case ResultError(resultError: final error):
        emit(SalesState.loadProductsFailure(message: 'Erro ao carregar vendas: $error'));
        return;
    }

    final Map<int, Company> companies;
    switch (resultCompanies) {
      case ResultSuccess(result: final value):
        companies = value;
      case ResultError(resultError: final error):
        emit(SalesState.loadProductsFailure(message: 'Erro ao carregar empresas: $error'));
        return;
    }

    switch (result) {
      case ResultSuccess(result: final products):
        emit(
          SalesState.loadedAll(
            products: products,
            paymentMethods: paymentMethods,
            customers: customers,
            companies: companies,
            invoices: invoices,
          ),
        );
      case ResultError(resultError: final resultError):
        emit(SalesState.loadProductsFailure(message: 'Erro ao carregar produtos: $resultError'));
    }
  }

  /// Carrega todas as vendas cadastradas.
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

  /// Registra uma nova venda.
  ///
  /// Cria um novo invoice com ID gerado automaticamente
  /// e salva no banco de dados.
  Future<void> registerSale(InvoiceData invoiceData, bool enableCodeGeneration) async {
    emit(SalesState.loading());

    if (enableCodeGeneration) {
      final invoiceNumberResult = await _salesRepository.generateInvoiceNumber();
      switch (invoiceNumberResult) {
        case ResultSuccess(result: final invoiceNumber):
          invoiceData.invoiceNumber = invoiceNumber;
        case ResultError(resultError: final error):
          emit(SalesState.error(message: error));
          return;
      }
    }

    final nextIdResult = await _salesRepository.getNextSaleId();
    final int nextId;
    switch (nextIdResult) {
      case ResultSuccess(result: final id):
        nextId = id;
      case ResultError(resultError: final error):
        emit(SalesState.error(message: error));
        return;
    }

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

  /// Atualiza uma venda existente.
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
