import 'package:system_loja/core/models/analytics_point.dart';

import 'sales_purchase_analytics_event.dart';

export 'package:system_loja/core/models/analytics_point.dart'
    show AnalyticsPoint;

class SalesPurchaseAnalyticsEmpty extends SalesPurchaseAnalyticsState {
  final SalesPurchaseGrouping grouping;

  const SalesPurchaseAnalyticsEmpty({required this.grouping});
}

class SalesPurchaseAnalyticsError extends SalesPurchaseAnalyticsState {
  final String message;

  const SalesPurchaseAnalyticsError({required this.message});
}

class SalesPurchaseAnalyticsInitial extends SalesPurchaseAnalyticsState {
  const SalesPurchaseAnalyticsInitial();
}

class SalesPurchaseAnalyticsLoaded extends SalesPurchaseAnalyticsState {
  final SalesPurchaseGrouping grouping;
  final List<AnalyticsPoint> points;

  const SalesPurchaseAnalyticsLoaded({
    required this.grouping,
    required this.points,
  });

  double get maxValue {
    if (points.isEmpty) {
      return 0;
    }

    return points.fold<double>(
      0,
      (currentMax, point) => point.salesValue > currentMax
          ? point.salesValue
          : (point.purchaseValue > currentMax
                ? point.purchaseValue
                : currentMax),
    );
  }

  int get totalProducts =>
      points.fold<int>(0, (sum, point) => sum + point.productsCount);

  double get totalPurchases =>
      points.fold<double>(0, (sum, point) => sum + point.purchaseValue);

  double get totalSales =>
      points.fold<double>(0, (sum, point) => sum + point.salesValue);
}

class SalesPurchaseAnalyticsLoading extends SalesPurchaseAnalyticsState {
  const SalesPurchaseAnalyticsLoading();
}

sealed class SalesPurchaseAnalyticsState {
  const SalesPurchaseAnalyticsState();
}
