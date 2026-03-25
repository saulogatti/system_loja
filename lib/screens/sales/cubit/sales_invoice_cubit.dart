import 'package:bloc/bloc.dart';
import 'package:system_loja/core/constants/app_constants.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart';
import 'package:system_loja/screens/sales/cubit/sales_invoice_state.dart';
import 'package:system_loja/screens/sales/cubit/sales_state.dart';
import 'package:system_loja/screens/sales/models/invoice_line_entry.dart';
import 'package:system_loja/screens/sales/models/person_selection.dart';
import 'package:system_loja/screens/sales/models/person_selection_invoice_mapping.dart';

/// Cubit do formulário de nova nota fiscal (delega persistência ao [SalesCubit]).
class SalesInvoiceCubit extends Cubit<SalesInvoiceState> {
  final SalesCubit _salesCubit;

  SalesInvoiceCubit({required SalesCubit salesCubit, required List<PaymentMethodType> paymentMethods})
    : _salesCubit = salesCubit,
      super(
        SalesInvoiceState.editing(
          form: SalesInvoiceFormData(paymentMethod: paymentMethods.isEmpty ? null : paymentMethods.first),
        ),
      );

  /// Adiciona ou soma quantidade; em falta de estoque (saída), emite [SalesInvoiceState.feedback].
  void addOrMergeLine(Product product, int quantityToAdd) {
    if (quantityToAdd <= 0) return;

    final form = state.form;
    final existing = form.linesByProductId[product.id];
    final mergedQty = (existing?.quantity ?? 0) + quantityToAdd;

    if (form.invoiceType == InvoiceType.exit && mergedQty > product.stockQuantity) {
      _emitFeedback('Estoque insuficiente! Disponível: ${product.stockQuantity}');
      return;
    }

    final nextMap = Map<int, InvoiceLineEntry>.from(form.linesByProductId);
    nextMap[product.id] = InvoiceLineEntry(product: product, quantity: mergedQty);

    final nextOrder = List<int>.from(form.orderedProductIds);
    if (!nextOrder.contains(product.id)) {
      nextOrder.add(product.id);
    }

    _emitEditing(form.copyWith(linesByProductId: nextMap, orderedProductIds: nextOrder));
  }

  /// Volta para [SalesInvoiceEditing] após exibir o SnackBar (transição por tipo, sem campo solto).
  void consumeFeedback() {
    switch (state) {
      case SalesInvoiceFeedback(:final form):
        _emitEditing(form);
      case SalesInvoiceEditing():
        break;
    }
  }

  void removeLine(int productId) {
    final form = state.form;
    final nextMap = Map<int, InvoiceLineEntry>.from(form.linesByProductId)..remove(productId);
    final nextOrder = form.orderedProductIds.where((id) => id != productId).toList();
    _emitEditing(form.copyWith(linesByProductId: nextMap, orderedProductIds: nextOrder));
  }

  void setInvoiceType(InvoiceType type) {
    _emitEditing(state.form.copyWith(invoiceType: type, person: null));
  }

  void setPaymentMethod(PaymentMethodType? method) {
    _emitEditing(state.form.copyWith(paymentMethod: method));
  }

  void setPerson(PersonSelection? person) {
    _emitEditing(state.form.copyWith(person: person));
  }

  /// Valida regras de negócio e delega ao [SalesCubit.registerSale].
  Future<void> submit() async {
    final form = state.form;
    if (form.linesByProductId.isEmpty) {
      _emitFeedback('Erro: Adicione pelo menos um item!');
      return;
    }
    if (form.person == null) {
      _emitFeedback('Selecione um cliente ou empresa');
      return;
    }
    if (form.paymentMethod == null) {
      _emitFeedback('Selecione uma forma de pagamento');
      return;
    }

    final numeroNota = form.invoiceNumber.trim();
    final itens = state.form.buildOrderedLines().map((line) {
      final p = line.product;
      return InvoiceItem(
        productId: p.id,
        productName: p.name,
        productCode: p.code,
        quantity: line.quantity,
        unitPrice: p.price,
      );
    }).toList();

    final notaFiscal = form.person!.toInvoiceData(
      invoiceNumber: numeroNota,
      type: form.invoiceType,
      items: itens,
      paymentMethod: form.paymentMethod!.name,
    );

    _emitEditing(form.copyWith(isSubmitting: true));
    try {
      final registerFlow = _salesCubit.stream.firstWhere(
        (state) => state is SalesSaved || state is SalesError,
      );

      await _salesCubit.registerSale(notaFiscal, form.enableCodeGeneration);
      final registerResult = await registerFlow;

      if (registerResult case SalesError(:final message)) {
        _emitFeedback(message);
      }
    } finally {
      if (!isClosed) {
        _emitEditing(state.form.copyWith(isSubmitting: false));
      }
    }
  }

  void toggleAutoInvoiceNumber() {
    final form = state.form;
    final next = !form.enableCodeGeneration;
    _emitEditing(form.copyWith(enableCodeGeneration: next, invoiceNumber: next ? kStringGenerate : ''));
  }

  void updateInvoiceNumber(String value) {
    _emitEditing(state.form.copyWith(invoiceNumber: value));
  }

  void _emitEditing(SalesInvoiceFormData form) {
    emit(SalesInvoiceState.editing(form: form));
  }

  void _emitFeedback(String message) {
    emit(SalesInvoiceState.feedback(form: state.form, message: message));
  }
}
