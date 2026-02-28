import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/product.dart';

part 'relatorio_state.freezed.dart';

/// Estados para a tela de relatórios.
@freezed
@immutable
sealed class RelatorioState with _$RelatorioState {
  /// Estado inicial antes de qualquer carregamento.
  factory RelatorioState.initial() = RelatorioInitial;

  /// Estado de carregamento dos dados.
  factory RelatorioState.loading() = RelatorioLoading;

  /// Estado com dados carregados com sucesso.
  factory RelatorioState.loaded({
    required Map<int, Invoice> entryInvoices,
    required Map<int, Invoice> exitInvoices,
    required List<Product> products,
  }) = RelatorioLoaded;

  /// Estado de erro ao carregar dados.
  factory RelatorioState.error({required String message}) = RelatorioError;
}
