import 'package:bloc/bloc.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_state.dart';

/// Cubit para gerenciamento de estado dos relatórios.
///
/// Coordena o carregamento de dados de notas fiscais (entrada/saída)
/// e estoque de produtos para exibição nos relatórios.
class RelatorioCubit extends Cubit<RelatorioState> {
  final ISalesRepository _salesRepository;
  final IProductRepository _productRepository;

  /// Cria o cubit e inicia o carregamento dos dados.
  RelatorioCubit(this._salesRepository, this._productRepository)
    : super(RelatorioState.initial()) {
    carregarRelatorios();
  }

  /// Carrega todos os dados necessários para os relatórios.
  Future<void> carregarRelatorios() async {
    emit(RelatorioState.loading());

    final entryResult = await _salesRepository.loadEntryInvoices();
    final exitResult = await _salesRepository.loadExitInvoices();
    final productsResult = await _productRepository.fetchProducts();

    Map<int, Invoice> entryInvoices = {};
    Map<int, Invoice> exitInvoices = {};
    List<Product> products = [];

    switch (entryResult) {
      case ResultSuccess(result: final data):
        entryInvoices = data;
      case ResultError(resultError: final error):
        emit(
          RelatorioState.error(
            message: 'Erro ao carregar notas de entrada: $error',
          ),
        );
        return;
    }

    switch (exitResult) {
      case ResultSuccess(result: final data):
        exitInvoices = data;
      case ResultError(resultError: final error):
        emit(
          RelatorioState.error(
            message: 'Erro ao carregar notas de saída: $error',
          ),
        );
        return;
    }

    switch (productsResult) {
      case ResultSuccess(result: final data):
        products = data;
      case ResultError(resultError: final error):
        emit(
          RelatorioState.error(message: 'Erro ao carregar produtos: $error'),
        );
        return;
    }

    emit(
      RelatorioState.loaded(
        entryInvoices: entryInvoices,
        exitInvoices: exitInvoices,
        products: products,
      ),
    );
  }
}
