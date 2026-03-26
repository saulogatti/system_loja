import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/invoice_type.dart';
import 'package:system_loja/core/models/system_config/price_configuration.dart';
import 'package:system_loja/screens/sales/models/invoice_line_entry.dart';
import 'package:system_loja/screens/sales/models/person_selection.dart';

part 'sales_invoice_state.freezed.dart';

/// Dados editáveis do formulário de nota fiscal.
@freezed
abstract class SalesInvoiceFormData with _$SalesInvoiceFormData {
  const factory SalesInvoiceFormData({
    @Default(InvoiceType.exit) InvoiceType invoiceType,
    PaymentMethodType? paymentMethod,
    PersonSelection? person,
    @Default({}) Map<int, InvoiceLineEntry> linesByProductId,
    @Default([]) List<int> orderedProductIds,
    @Default(false) bool enableCodeGeneration,
    @Default('') String invoiceNumber,
    @Default(false) bool isSubmitting,
  }) = _SalesInvoiceFormData;
}

/// Estado da tela: edição normal ou feedback transitório (SnackBar) sem campo opcional solto.
@freezed
sealed class SalesInvoiceState with _$SalesInvoiceState {
  const factory SalesInvoiceState.editing({required SalesInvoiceFormData form}) = SalesInvoiceEditing;

  /// Mensagem já tratada para exibir na UI; após o SnackBar, volta para [editing] com o mesmo [form].
  const factory SalesInvoiceState.feedback({required SalesInvoiceFormData form, required String message}) =
      SalesInvoiceFeedback;
}

/// Acesso unificado aos campos do formulário em qualquer variante de [SalesInvoiceState].
extension SalesInvoiceStateFormX on SalesInvoiceState {
  SalesInvoiceFormData get form => switch (this) {
    SalesInvoiceEditing(:final form) => form,
    SalesInvoiceFeedback(:final form) => form,
  };
}

/// Totais e lista ordenada derivados do formulário (fora do Cubit, para respeitar o bloc_lint).
extension SalesInvoiceFormDataTotals on SalesInvoiceFormData {
  double computeTotal() {
    return linesByProductId.values.fold<double>(0, (sum, line) => sum + line.product.price * line.quantity);
  }

  List<InvoiceLineEntry> buildOrderedLines() {
    return orderedProductIds
        .map((id) => linesByProductId[id])
        .whereType<InvoiceLineEntry>()
        .toList(growable: false);
  }
}
