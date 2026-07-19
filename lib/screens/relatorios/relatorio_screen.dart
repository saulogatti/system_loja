import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/application/app_injection.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/report/product_invoice_movement.dart';
import 'package:system_loja/core/models/report/product_movement_summary.dart';
import 'package:system_loja/core/models/report/relatorio_overview_data.dart';
import 'package:system_loja/core/services/product_movement_report_service.dart';
import 'package:system_loja/core/services/relatorio_overview_service.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_cubit.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_state.dart';
import 'package:system_loja/screens/sales/widgets/invoice_overview_bottom_sheet.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';
import 'package:system_loja/screens/widgets/empty_widget.dart';

/// Tela de relatórios com abas para notas fiscais (entrada/saída) e estoque.
@RoutePage()
class RelatoriosScreen extends StatelessWidget implements AutoRouteWrapper {

  /// Cria uma instância de [RelatoriosScreen].
  const RelatoriosScreen({
    super.key,
    this.salesRepository,
    this.productRepository,
    this.categoryRepository,
  });
  final ISalesRepository? salesRepository;
  final IProductRepository? productRepository;
  final ICategoryRepository? categoryRepository;

  @override
  Widget build(BuildContext context) => DefaultTabController(
      length: 2,
      child: Column(
        children: [
          const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.receipt_long), text: 'Notas Fiscais'),
              Tab(icon: Icon(Icons.inventory_2), text: 'Estoque'),
            ],
          ),
          Expanded(
            child: BlocBuilder<RelatorioCubit, RelatorioState>(
              builder: (context, state) => switch (state) {
                  RelatorioInitial() ||
                  RelatorioLoading() => const Center(child: CircularProgressIndicator()),
                  RelatorioError(:final message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Theme.of(context).colorScheme.error,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          message,
                          style: TextStyle(color: Theme.of(context).colorScheme.error),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton.icon(
                          onPressed: () => context.read<RelatorioCubit>().carregarRelatorios(),
                          icon: const Icon(Icons.refresh),
                          label: const Text('Tentar novamente'),
                        ),
                      ],
                    ),
                  ),
                  RelatorioLoaded(
                    :final categoryNamesById,
                    :final entryInvoices,
                    :final exitInvoices,
                    :final estoqueOverview,
                    :final notasOverview,
                    :final products,
                  ) =>
                    TabBarView(
                      children: [
                        _NotasFiscaisTab(
                          entryInvoices: entryInvoices,
                          exitInvoices: exitInvoices,
                          notasOverview: notasOverview,
                        ),
                        _EstoqueTab(
                          categoryNamesById: categoryNamesById,
                          products: products,
                          estoqueOverview: estoqueOverview,
                        ),
                      ],
                    ),
                },
            ),
          ),
        ],
      ),
    );

  @override
  Widget wrappedRoute(BuildContext context) => BlocProvider<RelatorioCubit>(
      create: (_) => RelatorioCubit(
        salesRepository ?? appInjection.get<ISalesRepository>(),
        productRepository ?? appInjection.get<IProductRepository>(),
        categoryRepository ?? appInjection.get<ICategoryRepository>(),
        appInjection.get<ProductMovementReportService>(),
        appInjection.get<RelatorioOverviewService>(),
      ),
      child: this,
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ISalesRepository?>('salesRepository', salesRepository));
    properties.add(DiagnosticsProperty<IProductRepository?>('productRepository', productRepository));
    properties.add(DiagnosticsProperty<ICategoryRepository?>('categoryRepository', categoryRepository));
  }
}

/// Aba de relatório de estoque de produtos.
class _EstoqueTab extends StatelessWidget {

  const _EstoqueTab({
    required this.categoryNamesById,
    required this.products,
    required this.estoqueOverview,
  });
  static const SliverGridDelegateWithMaxCrossAxisExtent _productGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 128,
      );

  final Map<int, String> categoryNamesById;
  final List<Product> products;
  final RelatorioEstoqueOverviewData estoqueOverview;

  @override
  Widget build(BuildContext context) {
    final sorted = estoqueOverview.produtosOrdenadosPorEstoque;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ResumoEstoqueRow(
            total: estoqueOverview.totalProdutos,
            semEstoque: estoqueOverview.produtosSemEstoque,
            estoqueBaixo: estoqueOverview.produtosComEstoqueBaixo,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: _SectionHeader(
            title: 'Produtos (${products.length})',
            icon: Icons.inventory_2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => context.read<RelatorioCubit>().carregarRelatorios(),
            child: sorted.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: const [
                      EmptyWidget(
                        message: 'Nenhum produto cadastrado',
                        icon: Icons.inventory_2_outlined,
                      ),
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: _EstoqueTab._productGridDelegate,
                    itemCount: sorted.length,
                    itemBuilder: (context, index) {
                      final product = sorted[index];
                      return _ProdutoTile(
                        product: product,
                        categoryName: _resolveCategoryName(product, categoryNamesById),
                        onTap: () => _openProductDetails(context, product),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  void _openProductDetails(BuildContext context, Product product) {
    final cubit = context.read<RelatorioCubit>();
    cubit.prepareProductDetails(product);

    final currentState = cubit.state;
    if (currentState is! RelatorioLoaded || currentState.selectedProductDetails == null) {
      return;
    }

    final details = currentState.selectedProductDetails!;
    _ProductDetailsBottomSheet.show(
      context,
      product: product,
      categoryName: details.categoryName,
      entries: details.entries,
      exits: details.exits,
      summary: details.summary,
    );
  }

  String _resolveCategoryName(Product product, Map<int, String> categoryNamesById) {
    final categoryId = product.categoryId;
    if (categoryId == null) {
      return 'Sem categoria';
    }
    return categoryNamesById[categoryId] ?? 'Categoria #$categoryId';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Map<int, String>>('categoryNamesById', categoryNamesById));
    properties.add(IterableProperty<Product>('products', products));
    properties.add(DiagnosticsProperty<RelatorioEstoqueOverviewData>('estoqueOverview', estoqueOverview));
  }
}

enum _InvoiceFilterType { entrada, saida }

/// Item de lista para uma nota fiscal.
class _InvoiceTile extends StatelessWidget {

  const _InvoiceTile({required this.invoice, required this.color});
  final Invoice invoice;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final data = invoice.data;
    final destino = data.personDisplayName;
    final formattedValue = data.totalValue.toStringAsFixed(2);
    final semanticLabel =
        'Nota Fiscal ${data.invoiceNumber}, '
        'Destino: $destino, '
        'Data: ${data.issueDate.toFormattedDate()}, '
        'Valor total: R\$ $formattedValue';

    return Card(
      margin: EdgeInsets.zero,
      child: Semantics(
        button: true,
        label: semanticLabel,
        onTap: () => InvoiceOverviewBottomSheet.show(context, invoice),
        onTapHint: 'Ver detalhes da nota fiscal',
        excludeSemantics: true,
        child: InkWell(
          onTap: () => InvoiceOverviewBottomSheet.show(context, invoice),
          borderRadius: BorderRadius.circular(12),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: color.withValues(alpha: 0.15),
                  child: Icon(Icons.receipt, color: color, size: 20),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'NF ${data.invoiceNumber}',
                        style: const TextStyle(fontWeight: FontWeight.w600),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(destino, maxLines: 1, overflow: TextOverflow.ellipsis),
                      Text(
                        data.issueDate.toFormattedDate(),
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  'R\$ $formattedValue',
                  style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Invoice>('invoice', invoice));
    properties.add(ColorProperty('color', color));
  }
}

class _MovementSection extends StatelessWidget {

  const _MovementSection({required this.title, required this.color, required this.movements});
  final String title;
  final Color color;
  final List<ProductInvoiceMovement> movements;

  @override
  Widget build(BuildContext context) => Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.history, color: color, size: 18),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '$title (${movements.length})',
                    style: TextStyle(fontWeight: FontWeight.w700, color: color),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (movements.isEmpty)
              const EmptyWidget(message: 'Nenhum registro encontrado.', icon: Icons.search_off)
            else
              ...movements.map((movement) {
                final invoice = movement.invoice;
                final item = movement.item;
                Future<void> onTap() => InvoiceOverviewBottomSheet.show(context, invoice);
                final semanticLabel =
                    'Nota Fiscal ${invoice.data.invoiceNumber}, Cliente ${invoice.data.personDisplayName}, Data ${invoice.data.issueDate.toFormattedDate()}, Quantidade ${item.quantity}, Preço unitário R\$ ${item.unitPrice.toStringAsFixed(2)}, Valor total R\$ ${item.totalValue.toStringAsFixed(2)}';
                return Semantics(
                  button: true,
                  label: semanticLabel,
                  excludeSemantics: true,
                  onTap: onTap,
                  onTapHint: 'Ver detalhes da nota fiscal',
                  child: ListTile(
                    dense: true,
                    contentPadding: EdgeInsets.zero,
                    title: Text(
                      'NF ${invoice.data.invoiceNumber} • ${invoice.data.personDisplayName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      '${invoice.data.issueDate.toFormattedDate()} • Qtd: ${item.quantity} • Unit: R\$ ${item.unitPrice.toStringAsFixed(2)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'R\$ ${item.totalValue.toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(width: 8),
                        Icon(
                          Icons.chevron_right,
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ],
                    ),
                    onTap: onTap,
                  ),
                );
              }),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(ColorProperty('color', color));
    properties.add(IterableProperty<ProductInvoiceMovement>('movements', movements));
  }
}

/// Aba de relatório de notas fiscais (entrada e saída).
class _NotasFiscaisTab extends StatefulWidget {

  const _NotasFiscaisTab({
    required this.entryInvoices,
    required this.exitInvoices,
    required this.notasOverview,
  });
  final Map<int, Invoice> entryInvoices;
  final Map<int, Invoice> exitInvoices;
  final RelatorioNotasOverviewData notasOverview;

  @override
  State<_NotasFiscaisTab> createState() => _NotasFiscaisTabState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Map<int, Invoice>>('entryInvoices', entryInvoices));
    properties.add(DiagnosticsProperty<Map<int, Invoice>>('exitInvoices', exitInvoices));
    properties.add(DiagnosticsProperty<RelatorioNotasOverviewData>('notasOverview', notasOverview));
  }
}

class _NotasFiscaisTabState extends State<_NotasFiscaisTab> {
  static const SliverGridDelegateWithMaxCrossAxisExtent _invoiceGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 350,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 132,
      );

  _InvoiceFilterType _selectedFilter = _InvoiceFilterType.entrada;

  @override
  Widget build(BuildContext context) {
    final isShowingEntries = _selectedFilter == _InvoiceFilterType.entrada;
    final invoices = (isShowingEntries ? widget.entryInvoices.values : widget.exitInvoices.values)
        .toList();

    final sectionTitle = isShowingEntries
        ? 'Notas de Entrada (${widget.entryInvoices.length})'
        : 'Notas de Saída (${widget.exitInvoices.length})';
    final sectionColor = isShowingEntries ? Colors.green : Colors.orange;
    final emptyMessage = isShowingEntries
        ? 'Nenhuma nota de entrada cadastrada'
        : 'Nenhuma nota de saída cadastrada';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ResumoNotasRow(
            totalEntrada: widget.notasOverview.totalEntrada,
            countEntrada: widget.notasOverview.quantidadeEntradas,
            totalSaida: widget.notasOverview.totalSaida,
            countSaida: widget.notasOverview.quantidadeSaidas,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: Row(
            children: [
              Expanded(
                child: _SectionHeader(
                  title: 'Notas de Entrada (${widget.entryInvoices.length})',
                  icon: Icons.arrow_downward,
                  color: Colors.green,
                  isSelected: isShowingEntries,
                  onTap: () {
                    setState(() {
                      _selectedFilter = _InvoiceFilterType.entrada;
                    });
                  },
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _SectionHeader(
                  title: 'Notas de Saída (${widget.exitInvoices.length})',
                  icon: Icons.arrow_upward,
                  color: Colors.orange,
                  isSelected: !isShowingEntries,
                  onTap: () {
                    setState(() {
                      _selectedFilter = _InvoiceFilterType.saida;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 8),
          child: _SectionHeader(
            title: sectionTitle,
            icon: isShowingEntries ? Icons.arrow_downward : Icons.arrow_upward,
            color: sectionColor,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () => context.read<RelatorioCubit>().carregarRelatorios(),
            child: invoices.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: [
                      EmptyWidget(message: emptyMessage, icon: Icons.receipt_long_outlined),
                    ],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: _invoiceGridDelegate,
                    itemCount: invoices.length,
                    itemBuilder: (context, index) => _InvoiceTile(invoice: invoices[index], color: sectionColor),
                  ),
          ),
        ),
      ],
    );
  }
}

class _ProductDetailsBottomSheet extends StatelessWidget {

  const _ProductDetailsBottomSheet({
    required this.product,
    required this.categoryName,
    required this.entries,
    required this.exits,
    required this.summary,
  });
  final Product product;
  final String categoryName;
  final List<ProductInvoiceMovement> entries;
  final List<ProductInvoiceMovement> exits;
  final ProductMovementSummary summary;

  @override
  Widget build(BuildContext context) => SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) => ListView(
            controller: scrollController,
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.outlineVariant,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Text(product.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 4),
              Text('Código: ${product.code}'),
              Text('Categoria: $categoryName'),
              Text('Preço: R\$ ${product.price.toStringAsFixed(2)}'),
              Text('Estoque atual: ${product.stockQuantity} unidade(s)'),
              const SizedBox(height: 12),
              _ProductMovementSummaryCard(summary: summary),
              const SizedBox(height: 16),
              _MovementSection(
                title: 'Entradas do produto',
                color: Colors.green,
                movements: entries,
              ),
              const SizedBox(height: 12),
              _MovementSection(title: 'Saídas do produto', color: Colors.orange, movements: exits),
            ],
          ),
      ),
    );

  static Future<void> show(
    BuildContext context, {
    required Product product,
    required String categoryName,
    required List<ProductInvoiceMovement> entries,
    required List<ProductInvoiceMovement> exits,
    required ProductMovementSummary summary,
  }) => showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => _ProductDetailsBottomSheet(
        product: product,
        categoryName: categoryName,
        entries: entries,
        exits: exits,
        summary: summary,
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
    properties.add(StringProperty('categoryName', categoryName));
    properties.add(IterableProperty<ProductInvoiceMovement>('entries', entries));
    properties.add(IterableProperty<ProductInvoiceMovement>('exits', exits));
    properties.add(DiagnosticsProperty<ProductMovementSummary>('summary', summary));
  }
}

class _ProductMovementSummaryCard extends StatelessWidget {

  const _ProductMovementSummaryCard({required this.summary});
  final ProductMovementSummary summary;

  @override
  Widget build(BuildContext context) {
    final saldoColor = summary.balanceQuantity >= 0 ? Colors.green : Colors.red;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Resumo de Movimentação', style: TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            _SummaryLine(
              label: 'Entradas',
              quantityText: '${summary.totalEntryQuantity} un.',
              valueText: 'R\$ ${summary.totalEntryValue.toStringAsFixed(2)}',
              color: Colors.green,
            ),
            _SummaryLine(
              label: 'Saídas',
              quantityText: '${summary.totalExitQuantity} un.',
              valueText: 'R\$ ${summary.totalExitValue.toStringAsFixed(2)}',
              color: Colors.orange,
            ),
            const Divider(height: 16),
            _SummaryLine(
              label: 'Saldo',
              quantityText: '${summary.balanceQuantity} un.',
              valueText: 'R\$ ${summary.balanceValue.toStringAsFixed(2)}',
              color: saldoColor,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ProductMovementSummary>('summary', summary));
  }
}

/// Item de lista para um produto com indicação de estoque.
class _ProdutoTile extends StatelessWidget {

  const _ProdutoTile({required this.product, required this.categoryName, required this.onTap});
  final Product product;
  final String categoryName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final Color stockColor;
    final IconData stockIcon;

    if (product.stockQuantity == 0) {
      stockColor = Colors.red;
      stockIcon = Icons.remove_shopping_cart;
    } else if (product.stockQuantity <= 5) {
      stockColor = Colors.orange;
      stockIcon = Icons.warning_amber;
    } else {
      stockColor = Colors.green;
      stockIcon = Icons.check_circle_outline;
    }

    final semanticLabel =
        'Produto: ${product.name}, Código: ${product.code}, Categoria: $categoryName, Estoque: ${product.stockQuantity} ${product.stockQuantity == 1 ? 'unidade' : 'unidades'}, Preço: R\$ ${product.price.toStringAsFixed(2)}';

    return Card(
      margin: EdgeInsets.zero,
      child: Center(
        child: Semantics(
          button: true,
          label: semanticLabel,
          excludeSemantics: true,
          onTap: onTap,
          onTapHint: 'Ver detalhes do produto',
          child: ListTile(
            onTap: onTap,
            leading: CircleAvatar(
              backgroundColor: stockColor.withValues(alpha: 0.15),
              child: Icon(stockIcon, color: stockColor, size: 20),
            ),
            title: Text(
              product.name,
              style: const TextStyle(fontWeight: FontWeight.w600),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              'Código: ${product.code}\nCategoria: $categoryName',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            isThreeLine: true,
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${product.stockQuantity} un.',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: stockColor,
                      ),
                    ),
                    Text(
                      'R\$ ${product.price.toStringAsFixed(2)}',
                      style: TextStyle(
                        fontSize: 12,
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 8),
                Icon(Icons.chevron_right, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Product>('product', product));
    properties.add(StringProperty('categoryName', categoryName));
    properties.add(ObjectFlagProperty<VoidCallback>.has('onTap', onTap));
  }
}

/// Card de resumo para um tipo de nota fiscal.
class _ResumoCard extends StatelessWidget {

  const _ResumoCard({
    required this.titulo,
    required this.valor,
    required this.quantidade,
    required this.icon,
    required this.color,
  });
  final String titulo;
  final double valor;
  final int quantidade;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(
                  titulo,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: color),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'R\$ ${valor.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              '$quantidade ${quantidade == 1 ? 'nota' : 'notas'}',
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('titulo', titulo));
    properties.add(DoubleProperty('valor', valor));
    properties.add(IntProperty('quantidade', quantidade));
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(ColorProperty('color', color));
  }
}

/// Card de resumo para estoque.
class _ResumoEstoqueCard extends StatelessWidget {

  const _ResumoEstoqueCard({
    required this.label,
    required this.valor,
    required this.icon,
    required this.color,
  });
  final String label;
  final int valor;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Card(
      elevation: 3,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 4),
            Text(
              '$valor',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: color),
            ),
            Text(
              label,
              style: TextStyle(fontSize: 11, color: Theme.of(context).colorScheme.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(IntProperty('valor', valor));
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(ColorProperty('color', color));
  }
}

/// Resumo de estoque com cards informativos.
class _ResumoEstoqueRow extends StatelessWidget {

  const _ResumoEstoqueRow({
    required this.total,
    required this.semEstoque,
    required this.estoqueBaixo,
  });
  final int total;
  final int semEstoque;
  final int estoqueBaixo;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Expanded(
          child: _ResumoEstoqueCard(
            label: 'Total',
            valor: total,
            icon: Icons.inventory_2,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ResumoEstoqueCard(
            label: 'Estoque baixo',
            valor: estoqueBaixo,
            icon: Icons.warning_amber,
            color: Colors.orange,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: _ResumoEstoqueCard(
            label: 'Sem estoque',
            valor: semEstoque,
            icon: Icons.remove_shopping_cart,
            color: Colors.red,
          ),
        ),
      ],
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('total', total));
    properties.add(IntProperty('semEstoque', semEstoque));
    properties.add(IntProperty('estoqueBaixo', estoqueBaixo));
  }
}

/// Resumo com totais de entrada e saída.
class _ResumoNotasRow extends StatelessWidget {

  const _ResumoNotasRow({
    required this.totalEntrada,
    required this.countEntrada,
    required this.totalSaida,
    required this.countSaida,
  });
  final double totalEntrada;
  final int countEntrada;
  final double totalSaida;
  final int countSaida;

  @override
  Widget build(BuildContext context) => Row(
      children: [
        Expanded(
          child: _ResumoCard(
            titulo: 'Entradas',
            valor: totalEntrada,
            quantidade: countEntrada,
            icon: Icons.arrow_downward,
            color: Colors.green,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _ResumoCard(
            titulo: 'Saídas',
            valor: totalSaida,
            quantidade: countSaida,
            icon: Icons.arrow_upward,
            color: Colors.orange,
          ),
        ),
      ],
    );

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('totalEntrada', totalEntrada));
    properties.add(IntProperty('countEntrada', countEntrada));
    properties.add(DoubleProperty('totalSaida', totalSaida));
    properties.add(IntProperty('countSaida', countSaida));
  }
}

/// Cabeçalho de seção com ícone e cor.
class _SectionHeader extends StatelessWidget {

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final textColor = isSelected ? color : Theme.of(context).colorScheme.onSurfaceVariant;

    final content = Row(
      children: [
        Icon(icon, color: textColor, size: 20),
        const SizedBox(width: 8),
        Expanded(
          child: Text(
            title,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: textColor),
          ),
        ),
      ],
    );

    if (onTap == null) {
      return content;
    }

    return Semantics(
      button: true,
      label: 'Filtro: $title',
      selected: isSelected,
      onTap: onTap,
      onTapHint: 'Aplicar filtro',
      excludeSemantics: true,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Ink(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: isSelected
                  ? color.withValues(alpha: 0.55)
                  : Theme.of(context).colorScheme.outlineVariant,
            ),
            color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
          ),
          child: content,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('title', title));
    properties.add(DiagnosticsProperty<IconData>('icon', icon));
    properties.add(ColorProperty('color', color));
    properties.add(DiagnosticsProperty<bool>('isSelected', isSelected));
    properties.add(ObjectFlagProperty<VoidCallback?>.has('onTap', onTap));
  }
}

class _SummaryLine extends StatelessWidget {

  const _SummaryLine({
    required this.label,
    required this.quantityText,
    required this.valueText,
    required this.color,
    this.isBold = false,
  });
  final String label;
  final String quantityText;
  final String valueText;
  final Color color;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    final fontWeight = isBold ? FontWeight.w700 : FontWeight.w500;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: TextStyle(color: color, fontWeight: fontWeight),
            ),
          ),
          Text(
            quantityText,
            style: TextStyle(color: color, fontWeight: fontWeight),
          ),
          const SizedBox(width: 12),
          Text(
            valueText,
            style: TextStyle(color: color, fontWeight: fontWeight),
          ),
        ],
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('label', label));
    properties.add(StringProperty('quantityText', quantityText));
    properties.add(StringProperty('valueText', valueText));
    properties.add(ColorProperty('color', color));
    properties.add(DiagnosticsProperty<bool>('isBold', isBold));
  }
}
