import 'package:bloc/bloc.dart';

import 'sales_purchase_analytics_event.dart';
import 'sales_purchase_analytics_state.dart';

const List<SalesPurchaseAnalyticsPoint> _mockByDate = [
  SalesPurchaseAnalyticsPoint(label: '10/03', salesValue: 1520.0, purchaseValue: 980.0, productsCount: 12),
  SalesPurchaseAnalyticsPoint(label: '11/03', salesValue: 1870.0, purchaseValue: 1100.0, productsCount: 18),
  SalesPurchaseAnalyticsPoint(label: '12/03', salesValue: 1325.0, purchaseValue: 760.0, productsCount: 9),
  SalesPurchaseAnalyticsPoint(label: '13/03', salesValue: 2090.0, purchaseValue: 1400.0, productsCount: 22),
  SalesPurchaseAnalyticsPoint(label: '14/03', salesValue: 1760.0, purchaseValue: 1180.0, productsCount: 15),
];

const List<SalesPurchaseAnalyticsPoint> _mockByProduct = [
  SalesPurchaseAnalyticsPoint(label: 'Arroz 5kg', salesValue: 980.0, purchaseValue: 640.0, productsCount: 31),
  SalesPurchaseAnalyticsPoint(
    label: 'Feijão 1kg',
    salesValue: 760.0,
    purchaseValue: 510.0,
    productsCount: 27,
  ),
  SalesPurchaseAnalyticsPoint(
    label: 'Óleo 900ml',
    salesValue: 540.0,
    purchaseValue: 360.0,
    productsCount: 19,
  ),
  SalesPurchaseAnalyticsPoint(
    label: 'Açúcar 1kg',
    salesValue: 690.0,
    purchaseValue: 470.0,
    productsCount: 24,
  ),
  SalesPurchaseAnalyticsPoint(label: 'Macarrão', salesValue: 430.0, purchaseValue: 290.0, productsCount: 16),
];

/// BLoC da tela de analytics de vendas e compras com dados mockados.
class SalesPurchaseAnalyticsBloc extends Bloc<SalesPurchaseAnalyticsEvent, SalesPurchaseAnalyticsState> {
  SalesPurchaseAnalyticsBloc() : super(const SalesPurchaseAnalyticsInitial()) {
    on<LoadSalesPurchaseAnalytics>(_onLoadAnalytics);
    on<ChangeSalesPurchaseGrouping>(_onChangeGrouping);
  }

  Future<void> _onChangeGrouping(
    ChangeSalesPurchaseGrouping event,
    Emitter<SalesPurchaseAnalyticsState> emit,
  ) async {
    emit(const SalesPurchaseAnalyticsLoading());

    final points = switch (event.grouping) {
      SalesPurchaseGrouping.byDate => _mockByDate,
      SalesPurchaseGrouping.byProduct => _mockByProduct,
    };

    if (points.isEmpty) {
      emit(SalesPurchaseAnalyticsEmpty(grouping: event.grouping));
      return;
    }

    emit(SalesPurchaseAnalyticsLoaded(grouping: event.grouping, points: points));
  }

  Future<void> _onLoadAnalytics(
    LoadSalesPurchaseAnalytics event,
    Emitter<SalesPurchaseAnalyticsState> emit,
  ) async {
    emit(const SalesPurchaseAnalyticsLoading());

    final points = _mockByDate;
    if (points.isEmpty) {
      emit(const SalesPurchaseAnalyticsEmpty(grouping: SalesPurchaseGrouping.byDate));
      return;
    }

    emit(const SalesPurchaseAnalyticsLoaded(grouping: SalesPurchaseGrouping.byDate, points: _mockByDate));
  }
}
