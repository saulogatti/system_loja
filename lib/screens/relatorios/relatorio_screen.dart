import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_category_repository.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/report/product_invoice_movement.dart';
import 'package:system_loja/core/models/report/product_movement_summary.dart';
import 'package:system_loja/domain/services/product_movement_report_service.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_cubit.dart';
import 'package:system_loja/screens/relatorios/cubit/relatorio_state.dart';
import 'package:system_loja/screens/sales/widgets/invoice_overview_bottom_sheet.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

/// Tela de relatórios com abas para notas fiscais (entrada/saída) e estoque.
@RoutePage()
class RelatoriosScreen extends StatelessWidget implements AutoRouteWrapper {
  /// Cria uma instância de [RelatoriosScreen].
  const RelatoriosScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Column(
        children: [
          TabBar(
            tabs: const [
              Tab(icon: Icon(Icons.receipt_long), text: 'Notas Fiscais'),
              Tab(icon: Icon(Icons.inventory_2), text: 'Estoque'),
            ],
          ),
          Expanded(
            child: BlocBuilder<RelatorioCubit, RelatorioState>(
              builder: (context, state) {
                return switch (state) {
                  RelatorioInitial() ||
                  RelatorioLoading() => const Center(child: CircularProgressIndicator()),
                  RelatorioError(:final message) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.error_outline, size: 64, color: Theme.of(context).colorScheme.error),
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
                  RelatorioLoaded(:final entryInvoices, :final exitInvoices, :final products) => TabBarView(
                    children: [
                      _NotasFiscaisTab(entryInvoices: entryInvoices, exitInvoices: exitInvoices),
                      _EstoqueTab(
                        products: products,
                        entryInvoices: entryInvoices,
                        exitInvoices: exitInvoices,
                      ),
                    ],
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget wrappedRoute(BuildContext context) {
    return BlocProvider<RelatorioCubit>(
      create: (_) =>
          RelatorioCubit(appInjection.get<ISalesRepository>(), appInjection.get<IProductRepository>()),
      child: this,
    );
  }
}

/// Mensagem exibida quando não há itens.
class _EmptyMessage extends StatelessWidget {
  final String message;

  const _EmptyMessage(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        message,
        style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant, fontStyle: FontStyle.italic),
      ),
    );
  }
}

/// Aba de relatório de estoque de produtos.
class _EstoqueTab extends StatefulWidget {
  static const SliverGridDelegateWithMaxCrossAxisExtent _productGridDelegate =
      SliverGridDelegateWithMaxCrossAxisExtent(
        maxCrossAxisExtent: 420,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        mainAxisExtent: 128,
      );

  final List<Product> products;
  final Map<int, Invoice> entryInvoices;
  final Map<int, Invoice> exitInvoices;

  const _EstoqueTab({required this.products, required this.entryInvoices, required this.exitInvoices});

  @override
  State<_EstoqueTab> createState() => _EstoqueTabState();
}

class _EstoqueTabState extends State<_EstoqueTab> {
  final ICategoryRepository _categoryRepository = appInjection.get<ICategoryRepository>();
  final ProductMovementReportService _movementReportService = ProductMovementReportService();
  Map<int, String> _categoryNamesById = const {};

  @override
  Widget build(BuildContext context) {
    final semEstoque = widget.products.where((p) => p.stockQuantity == 0).length;
    final estoquesBaixo = widget.products.where((p) => p.stockQuantity > 0 && p.stockQuantity <= 5).length;
    final sorted = List<Product>.from(widget.products)
      ..sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ResumoEstoqueRow(
            total: widget.products.length,
            semEstoque: semEstoque,
            estoqueBaixo: estoquesBaixo,
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
          child: _SectionHeader(
            title: 'Produtos (${widget.products.length})',
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
                    children: const [_EmptyMessage('Nenhum produto cadastrado')],
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
                        categoryName: _resolveCategoryName(product),
                        onTap: () => _openProductDetails(product),
                      );
                    },
                  ),
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  Future<void> _loadCategories() async {
    final result = await _categoryRepository.getAllCategories();
    if (!mounted || !result.isSuccessful) {
      return;
    }

    final categoriesMap = <int, String>{for (final category in result.asSuccess) category.id: category.name};

    setState(() {
      _categoryNamesById = categoriesMap;
    });
  }

  void _openProductDetails(Product product) {
    final categoryName = _resolveCategoryName(product);
    final entradas = _movementReportService.buildMovements(widget.entryInvoices, product);
    final saidas = _movementReportService.buildMovements(widget.exitInvoices, product);
    final summary = _movementReportService.summarize(entradas: entradas, saidas: saidas);

    _ProductDetailsBottomSheet.show(
      context,
      product: product,
      categoryName: categoryName,
      entradas: entradas,
      saidas: saidas,
      summary: summary,
    );
  }

  String _resolveCategoryName(Product product) {
    final categoryId = product.categoryId;
    if (categoryId == null) {
      return 'Sem categoria';
    }
    return _categoryNamesById[categoryId] ?? 'Categoria #$categoryId';
  }
}

enum _InvoiceFilterType { entrada, saida }

/// Item de lista para uma nota fiscal.
class _InvoiceTile extends StatelessWidget {
  final Invoice invoice;
  final Color color;

  const _InvoiceTile({required this.invoice, required this.color});

  @override
  Widget build(BuildContext context) {
    final data = invoice.data;
    final destino = data.personDisplayName;

    return Card(
      margin: EdgeInsets.zero,
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
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                'R\$ ${data.totalValue.toStringAsFixed(2)}',
                style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MovementSection extends StatelessWidget {
  final String title;
  final Color color;
  final List<ProductInvoiceMovement> movements;

  const _MovementSection({required this.title, required this.color, required this.movements});

  @override
  Widget build(BuildContext context) {
    return Card(
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
              Text(
                'Nenhum registro encontrado.',
                style: TextStyle(color: Theme.of(context).colorScheme.onSurfaceVariant),
              )
            else
              ...movements.map((movement) {
                final invoice = movement.invoice;
                final item = movement.item;
                return ListTile(
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
                  trailing: Text(
                    'R\$ ${item.totalValue.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                  onTap: () => InvoiceOverviewBottomSheet.show(context, invoice),
                );
              }),
          ],
        ),
      ),
    );
  }
}

/// Aba de relatório de notas fiscais (entrada e saída).
class _NotasFiscaisTab extends StatefulWidget {
  final Map<int, Invoice> entryInvoices;
  final Map<int, Invoice> exitInvoices;

  const _NotasFiscaisTab({required this.entryInvoices, required this.exitInvoices});

  @override
  State<_NotasFiscaisTab> createState() => _NotasFiscaisTabState();
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
    final totalEntrada = widget.entryInvoices.values.fold<double>(0.0, (sum, inv) {
      return sum + inv.data.totalValue;
    });
    final totalSaida = widget.exitInvoices.values.fold<double>(0.0, (sum, inv) {
      return sum + inv.data.totalValue;
    });

    final exibindoEntradas = _selectedFilter == _InvoiceFilterType.entrada;
    final invoices = (exibindoEntradas ? widget.entryInvoices.values : widget.exitInvoices.values).toList();

    final sectionTitle = exibindoEntradas
        ? 'Notas de Entrada (${widget.entryInvoices.length})'
        : 'Notas de Saída (${widget.exitInvoices.length})';
    final sectionColor = exibindoEntradas ? Colors.green : Colors.orange;
    final emptyMessage = exibindoEntradas
        ? 'Nenhuma nota de entrada cadastrada'
        : 'Nenhuma nota de saída cadastrada';

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ResumoNotasRow(
            totalEntrada: totalEntrada,
            countEntrada: widget.entryInvoices.length,
            totalSaida: totalSaida,
            countSaida: widget.exitInvoices.length,
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
                  isSelected: exibindoEntradas,
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
                  isSelected: !exibindoEntradas,
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
            icon: exibindoEntradas ? Icons.arrow_downward : Icons.arrow_upward,
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
                    children: [_EmptyMessage(emptyMessage)],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: _invoiceGridDelegate,
                    itemCount: invoices.length,
                    itemBuilder: (context, index) {
                      return _InvoiceTile(invoice: invoices[index], color: sectionColor);
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

class _ProductDetailsBottomSheet extends StatelessWidget {
  final Product product;
  final String categoryName;
  final List<ProductInvoiceMovement> entradas;
  final List<ProductInvoiceMovement> saidas;
  final ProductMovementSummary summary;

  const _ProductDetailsBottomSheet({
    required this.product,
    required this.categoryName,
    required this.entradas,
    required this.saidas,
    required this.summary,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.75,
        minChildSize: 0.5,
        maxChildSize: 0.95,
        builder: (context, scrollController) {
          return ListView(
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
              _MovementSection(title: 'Entradas do produto', color: Colors.green, movements: entradas),
              const SizedBox(height: 12),
              _MovementSection(title: 'Saídas do produto', color: Colors.orange, movements: saidas),
            ],
          );
        },
      ),
    );
  }

  static Future<void> show(
    BuildContext context, {
    required Product product,
    required String categoryName,
    required List<ProductInvoiceMovement> entradas,
    required List<ProductInvoiceMovement> saidas,
    required ProductMovementSummary summary,
  }) {
    return showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16))),
      builder: (_) => _ProductDetailsBottomSheet(
        product: product,
        categoryName: categoryName,
        entradas: entradas,
        saidas: saidas,
        summary: summary,
      ),
    );
  }
}

class _ProductMovementSummaryCard extends StatelessWidget {
  final ProductMovementSummary summary;

  const _ProductMovementSummaryCard({required this.summary});

  @override
  Widget build(BuildContext context) {
    final saldoColor = summary.saldoQuantidade >= 0 ? Colors.green : Colors.red;
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
              quantityText: '${summary.totalEntradaQuantidade} un.',
              valueText: 'R\$ ${summary.totalEntradaValor.toStringAsFixed(2)}',
              color: Colors.green,
            ),
            _SummaryLine(
              label: 'Saídas',
              quantityText: '${summary.totalSaidaQuantidade} un.',
              valueText: 'R\$ ${summary.totalSaidaValor.toStringAsFixed(2)}',
              color: Colors.orange,
            ),
            const Divider(height: 16),
            _SummaryLine(
              label: 'Saldo',
              quantityText: '${summary.saldoQuantidade} un.',
              valueText: 'R\$ ${summary.saldoValor.toStringAsFixed(2)}',
              color: saldoColor,
              isBold: true,
            ),
          ],
        ),
      ),
    );
  }
}

/// Item de lista para um produto com indicação de estoque.
class _ProdutoTile extends StatelessWidget {
  final Product product;
  final String categoryName;
  final VoidCallback onTap;

  const _ProdutoTile({required this.product, required this.categoryName, required this.onTap});

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

    return Card(
      margin: EdgeInsets.zero,
      child: Center(
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
          trailing: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                '${product.stockQuantity} un.',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: stockColor),
              ),
              Text(
                'R\$ ${product.price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Card de resumo para um tipo de nota fiscal.
class _ResumoCard extends StatelessWidget {
  final String titulo;
  final double valor;
  final int quantidade;
  final IconData icon;
  final Color color;

  const _ResumoCard({
    required this.titulo,
    required this.valor,
    required this.quantidade,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
  }
}

/// Card de resumo para estoque.
class _ResumoEstoqueCard extends StatelessWidget {
  final String label;
  final int valor;
  final IconData icon;
  final Color color;

  const _ResumoEstoqueCard({
    required this.label,
    required this.valor,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
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
  }
}

/// Resumo de estoque com cards informativos.
class _ResumoEstoqueRow extends StatelessWidget {
  final int total;
  final int semEstoque;
  final int estoqueBaixo;

  const _ResumoEstoqueRow({required this.total, required this.semEstoque, required this.estoqueBaixo});

  @override
  Widget build(BuildContext context) {
    return Row(
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
  }
}

/// Resumo com totais de entrada e saída.
class _ResumoNotasRow extends StatelessWidget {
  final double totalEntrada;
  final int countEntrada;
  final double totalSaida;
  final int countSaida;

  const _ResumoNotasRow({
    required this.totalEntrada,
    required this.countEntrada,
    required this.totalSaida,
    required this.countSaida,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
  }
}

/// Cabeçalho de seção com ícone e cor.
class _SectionHeader extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final bool isSelected;
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    required this.icon,
    required this.color,
    this.isSelected = false,
    this.onTap,
  });

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

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Ink(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? color.withValues(alpha: 0.55) : Theme.of(context).colorScheme.outlineVariant,
          ),
          color: isSelected ? color.withValues(alpha: 0.1) : Colors.transparent,
        ),
        child: content,
      ),
    );
  }
}

class _SummaryLine extends StatelessWidget {
  final String label;
  final String quantityText;
  final String valueText;
  final Color color;
  final bool isBold;

  const _SummaryLine({
    required this.label,
    required this.quantityText,
    required this.valueText,
    required this.color,
    this.isBold = false,
  });

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
}
