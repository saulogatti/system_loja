import 'package:bloc/bloc.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/repository/cliente_repository.dart';
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
  late final ClienteRepository _customerRepository =
      AppInjection.instance.clienteRepository;

  SalesCubit() : super(SalesInitial()) {
    _salesRepository = AppInjection.instance.salesRepository;
  }

  /// Deleta uma venda pelo ID
  Future<void> deleteSale(int id) async {
    try {
      emit(SalesState.loading());
      await _salesRepository.deleteSale(id);

      final updatedSales = await _salesRepository.loadAllSales();
      emit(SalesState.loaded(items: updatedSales));
    } catch (e) {
      emit(SalesState.error(message: 'Erro ao deletar venda: $e'));
    }
  }

  /// Carrega todos os clientes disponíveis
  Future<void> loadAllCustomers() async {
    try {
      emit(SalesState.loading());
      final customers = await _customerRepository.listarMapeado();
      emit(SalesState.loadedCustomers(customers: customers));
    } catch (e) {
      emit(SalesState.error(message: 'Erro ao carregar clientes: $e'));
    }
  }

  /// Carrega todos os produtos disponíveis
  Future<void> loadProducts() async {
    try {
      emit(SalesState.loadingProducts());
      final productRepository = AppInjection.instance.productRepository;
      final result = await productRepository.getProdutos();

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
    } catch (e) {
      emit(
        SalesState.loadProductsFailure(
          message: 'Erro ao carregar produtos: $e',
        ),
      );
    }
  }

  /// Carrega todas as vendas cadastradas
  Future<void> loadSales() async {
    try {
      emit(SalesState.loading());
      final sales = await _salesRepository.loadAllSales();
      emit(SalesState.loaded(items: sales));
    } catch (e) {
      emit(SalesState.error(message: 'Erro ao carregar vendas: $e'));
    }
  }

  /// Registra uma nova venda
  ///
  /// Cria um novo invoice com ID gerado automaticamente
  /// e salva no banco de dados.
  Future<void> registerSale(InvoiceData invoiceData) async {
    try {
      emit(SalesState.loading());
      if (invoiceData.invoiceNumber == kStringGenerate) {
        invoiceData.invoiceNumber = await _salesRepository
            .generateInvoiceNumber();
      }
      final invoice = Invoice(
        id: await _salesRepository.getNextSaleId(),
        data: invoiceData,
      );

      await _salesRepository.saveSale(invoice);

      final updatedSales = await _salesRepository.loadAllSales();
      emit(SalesState.saved(items: updatedSales));
    } catch (e) {
      emit(SalesState.error(message: 'Erro ao registrar venda: $e'));
    }
  }

  /// Atualiza uma venda existente
  Future<void> updateSale(Invoice invoice) async {
    try {
      emit(SalesState.loading());
      await _salesRepository.updateSale(invoice);

      final updatedSales = await _salesRepository.loadAllSales();
      emit(SalesState.loaded(items: updatedSales));
    } catch (e) {
      emit(SalesState.error(message: 'Erro ao atualizar venda: $e'));
    }
  }
}
