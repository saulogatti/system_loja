import 'package:bloc/bloc.dart';
import 'package:system_loja/core/interface/i_analytics_repository.dart';

import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_event.dart';
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/bloc/sales_purchase_analytics_state.dart';

/// BLoC da tela de analytics de vendas e compras.
///
/// Carrega dados reais via [IAnalyticsRepository] e os expõe como
/// estados de UI para exibição em gráficos comparativos.
class SalesPurchaseAnalyticsBloc
    extends Bloc<SalesPurchaseAnalyticsEvent, SalesPurchaseAnalyticsState> {

  SalesPurchaseAnalyticsBloc({
    required IAnalyticsRepository analyticsRepository,
  }) : _analyticsRepository = analyticsRepository,
       super(const SalesPurchaseAnalyticsInitial()) {
    on<LoadSalesPurchaseAnalytics>(_onLoadAnalytics);
    on<ChangeSalesPurchaseGrouping>(_onChangeGrouping);
  }
  final IAnalyticsRepository _analyticsRepository;

  Future<void> _onChangeGrouping(
    ChangeSalesPurchaseGrouping event,
    Emitter<SalesPurchaseAnalyticsState> emit,
  ) async {
    emit(const SalesPurchaseAnalyticsLoading());

    final result = switch (event.grouping) {
      SalesPurchaseGrouping.byDate =>
        await _analyticsRepository.getAnalyticsByDate(),
      SalesPurchaseGrouping.byProduct =>
        await _analyticsRepository.getAnalyticsByProduct(),
    };

    result.when(
      onSuccess: (points) {
        if (points.isEmpty) {
          emit(SalesPurchaseAnalyticsEmpty(grouping: event.grouping));
        } else {
          emit(
            SalesPurchaseAnalyticsLoaded(
              grouping: event.grouping,
              points: points,
            ),
          );
        }
      },
      onError: (message) => emit(SalesPurchaseAnalyticsError(message: message)),
    );
  }

  Future<void> _onLoadAnalytics(
    LoadSalesPurchaseAnalytics event,
    Emitter<SalesPurchaseAnalyticsState> emit,
  ) async {
    emit(const SalesPurchaseAnalyticsLoading());

    final result = await _analyticsRepository.getAnalyticsByDate();

    result.when(
      onSuccess: (points) {
        if (points.isEmpty) {
          emit(
            const SalesPurchaseAnalyticsEmpty(
              grouping: SalesPurchaseGrouping.byDate,
            ),
          );
        } else {
          emit(
            SalesPurchaseAnalyticsLoaded(
              grouping: SalesPurchaseGrouping.byDate,
              points: points,
            ),
          );
        }
      },
      onError: (message) => emit(SalesPurchaseAnalyticsError(message: message)),
    );
  }
}
