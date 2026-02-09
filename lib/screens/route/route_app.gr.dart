// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:collection/collection.dart' as _i22;
import 'package:flutter/material.dart' as _i18;
import 'package:system_loja/core/models/company.dart' as _i19;
import 'package:system_loja/core/models/customer.dart' as _i20;
import 'package:system_loja/core/models/product.dart' as _i21;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i23;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i1;
import 'package:system_loja/screens/company/company_edit_view.dart' as _i2;
import 'package:system_loja/screens/company/company_view.dart' as _i3;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i8;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i9;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i14;
import 'package:system_loja/screens/configuracoes/system_config_screen.dart'
    as _i15;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i16;
import 'package:system_loja/screens/customer/customer_detail_screen.dart'
    as _i4;
import 'package:system_loja/screens/customer/customer_view.dart' as _i5;
import 'package:system_loja/screens/home/home_screen.dart' as _i6;
import 'package:system_loja/screens/products/product_detail_screen.dart'
    as _i10;
import 'package:system_loja/screens/products/product_screen.dart' as _i11;
import 'package:system_loja/screens/route/route_app.dart' as _i7;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i24;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i12;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i13;

/// generated route for
/// [_i1.CategoryManagementScreen]
class CategoryManagementRoute extends _i17.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i17.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);

  static const String name = 'CategoryManagementRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i1.CategoryManagementScreen());
    },
  );
}

/// generated route for
/// [_i2.CompanyEditView]
class CompanyEditRoute extends _i17.PageRouteInfo<CompanyEditRouteArgs> {
  CompanyEditRoute({
    _i18.Key? key,
    required _i19.Company company,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         CompanyEditRoute.name,
         args: CompanyEditRouteArgs(key: key, company: company),
         initialChildren: children,
       );

  static const String name = 'CompanyEditRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyEditRouteArgs>();
      return _i2.CompanyEditView(key: args.key, company: args.company);
    },
  );
}

class CompanyEditRouteArgs {
  const CompanyEditRouteArgs({this.key, required this.company});

  final _i18.Key? key;

  final _i19.Company company;

  @override
  String toString() {
    return 'CompanyEditRouteArgs{key: $key, company: $company}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyEditRouteArgs) return false;
    return key == other.key && company == other.company;
  }

  @override
  int get hashCode => key.hashCode ^ company.hashCode;
}

/// generated route for
/// [_i3.CompanyView]
class CompanyRoute extends _i17.PageRouteInfo<void> {
  const CompanyRoute({List<_i17.PageRouteInfo>? children})
    : super(CompanyRoute.name, initialChildren: children);

  static const String name = 'CompanyRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i3.CompanyView();
    },
  );
}

/// generated route for
/// [_i4.CustomerDetailScreen]
class CustomerDetailRoute extends _i17.PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    _i18.Key? key,
    required _i20.Customer customer,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerDetailRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i4.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({this.key, required this.customer});

  final _i18.Key? key;

  final _i20.Customer customer;

  @override
  String toString() {
    return 'CustomerDetailRouteArgs{key: $key, customer: $customer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerDetailRouteArgs) return false;
    return key == other.key && customer == other.customer;
  }

  @override
  int get hashCode => key.hashCode ^ customer.hashCode;
}

/// generated route for
/// [_i5.CustomerView]
class CustomerRoute extends _i17.PageRouteInfo<void> {
  const CustomerRoute({List<_i17.PageRouteInfo>? children})
    : super(CustomerRoute.name, initialChildren: children);

  static const String name = 'CustomerRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i5.CustomerView();
    },
  );
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.HostScreen]
class HostRoute extends _i17.PageRouteInfo<void> {
  const HostRoute({List<_i17.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i7.HostScreen();
    },
  );
}

/// generated route for
/// [_i8.LogSystemScreen]
class LogSystemRoute extends _i17.PageRouteInfo<void> {
  const LogSystemRoute({List<_i17.PageRouteInfo>? children})
    : super(LogSystemRoute.name, initialChildren: children);

  static const String name = 'LogSystemRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i8.LogSystemScreen());
    },
  );
}

/// generated route for
/// [_i9.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i17.PageRouteInfo<void> {
  const LogsAnalyticsRoute({List<_i17.PageRouteInfo>? children})
    : super(LogsAnalyticsRoute.name, initialChildren: children);

  static const String name = 'LogsAnalyticsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i9.LogsAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i10.ProductDetailScreen]
class ProductDetailRoute extends _i17.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i18.Key? key,
    required _i21.Product product,
    List<_i21.Product> productList = const [],
    List<_i17.PageRouteInfo>? children,
  }) : super(
         ProductDetailRoute.name,
         args: ProductDetailRouteArgs(
           key: key,
           product: product,
           productList: productList,
         ),
         initialChildren: children,
       );

  static const String name = 'ProductDetailRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i17.WrappedRoute(
        child: _i10.ProductDetailScreen(
          key: args.key,
          product: args.product,
          productList: args.productList,
        ),
      );
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
    this.productList = const [],
  });

  final _i18.Key? key;

  final _i21.Product product;

  final List<_i21.Product> productList;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product, productList: $productList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return key == other.key &&
        product == other.product &&
        const _i22.ListEquality<_i21.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i22.ListEquality<_i21.Product>().hash(productList);
}

/// generated route for
/// [_i11.ProductInfoScreen]
class ProductInfoRoute extends _i17.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i17.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i11.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i12.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i17.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    _i18.Key? key,
    required List<_i23.PaymentMethodType> paymentMethods,
    required Map<int, _i20.Customer> customers,
    required _i24.SalesCubit salesCubit,
    required List<_i21.Product> products,
    List<_i17.PageRouteInfo>? children,
  }) : super(
         SalesInvoiceRoute.name,
         args: SalesInvoiceRouteArgs(
           key: key,
           paymentMethods: paymentMethods,
           customers: customers,
           salesCubit: salesCubit,
           products: products,
         ),
         initialChildren: children,
       );

  static const String name = 'SalesInvoiceRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i12.SalesInvoiceScreen(
        key: args.key,
        paymentMethods: args.paymentMethods,
        customers: args.customers,
        salesCubit: args.salesCubit,
        products: args.products,
      );
    },
  );
}

class SalesInvoiceRouteArgs {
  const SalesInvoiceRouteArgs({
    this.key,
    required this.paymentMethods,
    required this.customers,
    required this.salesCubit,
    required this.products,
  });

  final _i18.Key? key;

  final List<_i23.PaymentMethodType> paymentMethods;

  final Map<int, _i20.Customer> customers;

  final _i24.SalesCubit salesCubit;

  final List<_i21.Product> products;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, paymentMethods: $paymentMethods, customers: $customers, salesCubit: $salesCubit, products: $products}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return key == other.key &&
        const _i22.ListEquality<_i23.PaymentMethodType>().equals(
          paymentMethods,
          other.paymentMethods,
        ) &&
        const _i22.MapEquality<int, _i20.Customer>().equals(
          customers,
          other.customers,
        ) &&
        salesCubit == other.salesCubit &&
        const _i22.ListEquality<_i21.Product>().equals(
          products,
          other.products,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i22.ListEquality<_i23.PaymentMethodType>().hash(paymentMethods) ^
      const _i22.MapEquality<int, _i20.Customer>().hash(customers) ^
      salesCubit.hashCode ^
      const _i22.ListEquality<_i21.Product>().hash(products);
}

/// generated route for
/// [_i13.SalesView]
class SalesRoute extends _i17.PageRouteInfo<void> {
  const SalesRoute({List<_i17.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return const _i13.SalesView();
    },
  );
}

/// generated route for
/// [_i14.SettingsScreen]
class SettingsRoute extends _i17.PageRouteInfo<void> {
  const SettingsRoute({List<_i17.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i14.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i15.SystemConfigScreen]
class SystemConfigRoute extends _i17.PageRouteInfo<void> {
  const SystemConfigRoute({List<_i17.PageRouteInfo>? children})
    : super(SystemConfigRoute.name, initialChildren: children);

  static const String name = 'SystemConfigRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i15.SystemConfigScreen());
    },
  );
}

/// generated route for
/// [_i16.UsuarioScreen]
class UsuarioRoute extends _i17.PageRouteInfo<void> {
  const UsuarioRoute({List<_i17.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i17.PageInfo page = _i17.PageInfo(
    name,
    builder: (data) {
      return _i17.WrappedRoute(child: const _i16.UsuarioScreen());
    },
  );
}
