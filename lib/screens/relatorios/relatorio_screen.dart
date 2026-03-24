import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';
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
                      _EstoqueTab(products: products),
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
class _EstoqueTab extends StatelessWidget {
  final List<Product> products;

  const _EstoqueTab({required this.products});

  @override
  Widget build(BuildContext context) {
    final semEstoque = products.where((p) => p.stockQuantity == 0).length;
    final estoquesBaixo = products.where((p) => p.stockQuantity > 0 && p.stockQuantity <= 5).length;
    final sorted = List<Product>.from(products)..sort((a, b) => a.stockQuantity.compareTo(b.stockQuantity));

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
          child: _ResumoEstoqueRow(
            total: products.length,
            semEstoque: semEstoque,
            estoqueBaixo: estoquesBaixo,
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
                    children: const [_EmptyMessage('Nenhum produto cadastrado')],
                  )
                : GridView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    physics: const AlwaysScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 420,
                      childAspectRatio: 2.8,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 12,
                    ),
                    itemCount: sorted.length,
                    itemBuilder: (context, index) {
                      return _ProdutoTile(product: sorted[index]);
                    },
                  ),
          ),
        ),
      ],
    );
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
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withValues(alpha: 0.15),
          child: Icon(Icons.receipt, color: color, size: 20),
        ),
        title: Text('NF ${data.invoiceNumber}', style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(destino),
            Text(
              data.issueDate.toFormattedDate(),
              style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.onSurfaceVariant),
            ),
          ],
        ),
        trailing: Text(
          'R\$ ${data.totalValue.toStringAsFixed(2)}',
          style: TextStyle(fontWeight: FontWeight.bold, color: color, fontSize: 14),
        ),
        isThreeLine: true,
        onTap: () => InvoiceOverviewBottomSheet.show(context, invoice),
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
                    gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 520,
                      childAspectRatio: 2.3,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 12,
                    ),
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

/// Item de lista para um produto com indicação de estoque.
class _ProdutoTile extends StatelessWidget {
  final Product product;

  const _ProdutoTile({required this.product});

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
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: stockColor.withValues(alpha: 0.15),
          child: Icon(stockIcon, color: stockColor, size: 20),
        ),
        title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text('Código: ${product.code}'),
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
