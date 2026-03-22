class ChangeSalesPurchaseGrouping extends SalesPurchaseAnalyticsEvent {
  final SalesPurchaseGrouping grouping;

  const ChangeSalesPurchaseGrouping(this.grouping);
}

class LoadSalesPurchaseAnalytics extends SalesPurchaseAnalyticsEvent {
  const LoadSalesPurchaseAnalytics();
}

sealed class SalesPurchaseAnalyticsEvent {
  const SalesPurchaseAnalyticsEvent();
}

enum SalesPurchaseGrouping { byDate, byProduct }
