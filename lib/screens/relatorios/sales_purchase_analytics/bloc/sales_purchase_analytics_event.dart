class ChangeSalesPurchaseGrouping extends SalesPurchaseAnalyticsEvent {

  const ChangeSalesPurchaseGrouping(this.grouping);
  final SalesPurchaseGrouping grouping;
}

class LoadSalesPurchaseAnalytics extends SalesPurchaseAnalyticsEvent {
  const LoadSalesPurchaseAnalytics();
}

sealed class SalesPurchaseAnalyticsEvent {
  const SalesPurchaseAnalyticsEvent();
}

enum SalesPurchaseGrouping { byDate, byProduct }
