import 'package:bloc/bloc.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/report/product_details_report_data.dart';
import 'package:system_loja/core/services/product_movement_report_service.dart';
import 'package:system_loja/core/services/relatorio_overview_service.dart';
import 'package:system_loja/core/utils/command_result.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_state.dart';

/// Cubit para gerenciamento de estado dos relatórios.
///
/// Coordena o carregamento de dados de notas fiscais (entrada/saída)
/// e estoque de produtos para exibição nos relatórios.
class RelatorioCubit extends Cubit<RelatorioState> {
  final ICategoryRepository _categoryRepository;
  final ISalesRepository _salesRepository;
  final IProductRepository _productRepository;
  final ProductMovementReportService _movementReportService;
  final RelatorioOverviewService _overviewService;

  /// Cria o cubit e inicia o carregamento dos dados.
  RelatorioCubit(
    this._salesRepository,
    this._productRepository,
    this._categoryRepository,
    this._movementReportService,
    this._overviewService,
  ) : super(RelatorioState.initial()) {
    carregarRelatorios();
  }

  /// Carrega todos os dados necessários para os relatórios.
  Future<void> carregarRelatorios() async {
    emit(RelatorioState.loading());

    final categoriesResult = await _categoryRepository.getAllCategories();
    final entryResult = await _salesRepository.loadEntryInvoices();
    final exitResult = await _salesRepository.loadExitInvoices();
    final productsResult = await _productRepository.fetchProducts();

    Map<int, String> categoryNamesById = {};
    Map<int, Invoice> entryInvoices = {};
    Map<int, Invoice> exitInvoices = {};
    List<Product> products = [];

    switch (categoriesResult) {
      case ResultSuccess(result: final data):
        categoryNamesById = _toCategoryMap(data);
      case ResultError(resultError: final error):
        emit(
          RelatorioState.error(message: 'Erro ao carregar categorias: $error'),
        );
        return;
    }

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
        categoryNamesById: categoryNamesById,
        entryInvoices: entryInvoices,
        exitInvoices: exitInvoices,
        products: products,
        estoqueOverview: _overviewService.buildEstoqueOverview(products),
        notasOverview: _overviewService.buildNotasOverview(
          entryInvoices: entryInvoices,
          exitInvoices: exitInvoices,
        ),
        selectedProductDetails: null,
      ),
    );
  }

  /// Prepara os dados de detalhe do produto no estado carregado.
  void prepareProductDetails(Product product) {
    final currentState = state;
    if (currentState is! RelatorioLoaded) {
      return;
    }

    emit(
      currentState.copyWith(
        selectedProductDetails: _buildProductDetails(currentState, product),
      ),
    );
  }

  ProductDetailsReportData _buildProductDetails(
    RelatorioLoaded currentState,
    Product product,
  ) {
    final entries = _movementReportService.buildMovements(
      currentState.entryInvoices,
      product,
    );
    final exits = _movementReportService.buildMovements(
      currentState.exitInvoices,
      product,
    );
    final summary = _movementReportService.summarize(
      entries: entries,
      exits: exits,
    );

    return ProductDetailsReportData(
      categoryName: _resolveCategoryName(
        currentState.categoryNamesById,
        product.categoryId,
      ),
      entries: entries,
      exits: exits,
      summary: summary,
    );
  }

  String _resolveCategoryName(
    Map<int, String> categoryNamesById,
    int? categoryId,
  ) {
    if (categoryId == null) {
      return 'Sem categoria';
    }
    return categoryNamesById[categoryId] ?? 'Categoria #$categoryId';
  }

  Map<int, String> _toCategoryMap(List<Category> categories) {
    return {for (final category in categories) category.id: category.name};
  }
}
