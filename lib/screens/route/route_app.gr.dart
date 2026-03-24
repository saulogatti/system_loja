// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i18;
import 'package:collection/collection.dart' as _i21;
import 'package:flutter/material.dart' as _i20;
import 'package:system_loja/core/models/company.dart' as _i24;
import 'package:system_loja/core/models/customer.dart' as _i23;
import 'package:system_loja/core/models/product.dart' as _i19;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i22;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i2;
import 'package:system_loja/screens/configuracoes/issuer_config_screen.dart'
    as _i5;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i6;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i7;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i15;
import 'package:system_loja/screens/configuracoes/system_config_screen.dart'
    as _i16;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i17;
import 'package:system_loja/screens/home/home_screen.dart' as _i3;
import 'package:system_loja/screens/host/cadastro_group_screen.dart' as _i1;
import 'package:system_loja/screens/host/host_screen.dart' as _i4;
import 'package:system_loja/screens/person_registration/person_registration_view.dart'
    as _i8;
import 'package:system_loja/screens/products/product_detail_screen.dart' as _i9;
import 'package:system_loja/screens/products/product_screen.dart' as _i10;
import 'package:system_loja/screens/relatorios/relatorio_screen.dart' as _i11;
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/sales_purchase_analytics_screen.dart'
    as _i13;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i25;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i12;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i14;

/// generated route for
/// [_i1.CadastroGroupScreen]
class CadastroGroupRoute extends _i18.PageRouteInfo<void> {
  const CadastroGroupRoute({List<_i18.PageRouteInfo>? children})
    : super(CadastroGroupRoute.name, initialChildren: children);

  static const String name = 'CadastroGroupRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i1.CadastroGroupScreen();
    },
  );
}

/// generated route for
/// [_i2.CategoryManagementScreen]
class CategoryManagementRoute extends _i18.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i18.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);

  static const String name = 'CategoryManagementRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i2.CategoryManagementScreen());
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i18.PageRouteInfo<void> {
  const HomeRoute({List<_i18.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.HostScreen]
class HostRoute extends _i18.PageRouteInfo<void> {
  const HostRoute({List<_i18.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i4.HostScreen();
    },
  );
}

/// generated route for
/// [_i5.IssuerConfigScreen]
class IssuerConfigRoute extends _i18.PageRouteInfo<void> {
  const IssuerConfigRoute({List<_i18.PageRouteInfo>? children})
    : super(IssuerConfigRoute.name, initialChildren: children);

  static const String name = 'IssuerConfigRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i5.IssuerConfigScreen();
    },
  );
}

/// generated route for
/// [_i6.LogSystemScreen]
class LogSystemRoute extends _i18.PageRouteInfo<void> {
  const LogSystemRoute({List<_i18.PageRouteInfo>? children})
    : super(LogSystemRoute.name, initialChildren: children);

  static const String name = 'LogSystemRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i6.LogSystemScreen());
    },
  );
}

/// generated route for
/// [_i7.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i18.PageRouteInfo<void> {
  const LogsAnalyticsRoute({List<_i18.PageRouteInfo>? children})
    : super(LogsAnalyticsRoute.name, initialChildren: children);

  static const String name = 'LogsAnalyticsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i7.LogsAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i8.PersonRegistrationView]
class PersonRegistrationRoute extends _i18.PageRouteInfo<void> {
  const PersonRegistrationRoute({List<_i18.PageRouteInfo>? children})
    : super(PersonRegistrationRoute.name, initialChildren: children);

  static const String name = 'PersonRegistrationRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i8.PersonRegistrationView();
    },
  );
}

/// generated route for
/// [_i9.ProductDetailScreen]
class ProductDetailRoute extends _i18.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    required _i19.Product product,
    _i20.Key? key,
    List<_i19.Product> productList = const [],
    List<_i18.PageRouteInfo>? children,
  }) : super(
         ProductDetailRoute.name,
         args: ProductDetailRouteArgs(
           product: product,
           key: key,
           productList: productList,
         ),
         initialChildren: children,
       );

  static const String name = 'ProductDetailRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i18.WrappedRoute(
        child: _i9.ProductDetailScreen(
          product: args.product,
          key: args.key,
          productList: args.productList,
        ),
      );
    },
  );
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    required this.product,
    this.key,
    this.productList = const [],
  });

  final _i19.Product product;

  final _i20.Key? key;

  final List<_i19.Product> productList;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{product: $product, key: $key, productList: $productList}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return product == other.product &&
        key == other.key &&
        const _i21.ListEquality<_i19.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      product.hashCode ^
      key.hashCode ^
      const _i21.ListEquality<_i19.Product>().hash(productList);
}

/// generated route for
/// [_i10.ProductInfoScreen]
class ProductInfoRoute extends _i18.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i18.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i10.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i11.RelatoriosScreen]
class RelatoriosRoute extends _i18.PageRouteInfo<void> {
  const RelatoriosRoute({List<_i18.PageRouteInfo>? children})
    : super(RelatoriosRoute.name, initialChildren: children);

  static const String name = 'RelatoriosRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i11.RelatoriosScreen());
    },
  );
}

/// generated route for
/// [_i12.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i18.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    required List<_i22.PaymentMethodType> paymentMethods,
    required Map<int, _i23.Customer> customers,
    required Map<int, _i24.Company> companies,
    required _i25.SalesCubit salesCubit,
    required List<_i19.Product> products,
    _i20.Key? key,
    List<_i18.PageRouteInfo>? children,
  }) : super(
         SalesInvoiceRoute.name,
         args: SalesInvoiceRouteArgs(
           paymentMethods: paymentMethods,
           customers: customers,
           companies: companies,
           salesCubit: salesCubit,
           products: products,
           key: key,
         ),
         initialChildren: children,
       );

  static const String name = 'SalesInvoiceRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i12.SalesInvoiceScreen(
        paymentMethods: args.paymentMethods,
        customers: args.customers,
        companies: args.companies,
        salesCubit: args.salesCubit,
        products: args.products,
        key: args.key,
      );
    },
  );
}

class SalesInvoiceRouteArgs {
  const SalesInvoiceRouteArgs({
    required this.paymentMethods,
    required this.customers,
    required this.companies,
    required this.salesCubit,
    required this.products,
    this.key,
  });

  final List<_i22.PaymentMethodType> paymentMethods;

  final Map<int, _i23.Customer> customers;

  final Map<int, _i24.Company> companies;

  final _i25.SalesCubit salesCubit;

  final List<_i19.Product> products;

  final _i20.Key? key;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{paymentMethods: $paymentMethods, customers: $customers, companies: $companies, salesCubit: $salesCubit, products: $products, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return const _i21.ListEquality<_i22.PaymentMethodType>().equals(
          paymentMethods,
          other.paymentMethods,
        ) &&
        const _i21.MapEquality<int, _i23.Customer>().equals(
          customers,
          other.customers,
        ) &&
        const _i21.MapEquality<int, _i24.Company>().equals(
          companies,
          other.companies,
        ) &&
        salesCubit == other.salesCubit &&
        const _i21.ListEquality<_i19.Product>().equals(
          products,
          other.products,
        ) &&
        key == other.key;
  }

  @override
  int get hashCode =>
      const _i21.ListEquality<_i22.PaymentMethodType>().hash(paymentMethods) ^
      const _i21.MapEquality<int, _i23.Customer>().hash(customers) ^
      const _i21.MapEquality<int, _i24.Company>().hash(companies) ^
      salesCubit.hashCode ^
      const _i21.ListEquality<_i19.Product>().hash(products) ^
      key.hashCode;
}

/// generated route for
/// [_i13.SalesPurchaseAnalyticsScreen]
class SalesPurchaseAnalyticsRoute extends _i18.PageRouteInfo<void> {
  const SalesPurchaseAnalyticsRoute({List<_i18.PageRouteInfo>? children})
    : super(SalesPurchaseAnalyticsRoute.name, initialChildren: children);

  static const String name = 'SalesPurchaseAnalyticsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i13.SalesPurchaseAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i14.SalesView]
class SalesRoute extends _i18.PageRouteInfo<void> {
  const SalesRoute({List<_i18.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return const _i14.SalesView();
    },
  );
}

/// generated route for
/// [_i15.SettingsScreen]
class SettingsRoute extends _i18.PageRouteInfo<void> {
  const SettingsRoute({List<_i18.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i15.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i16.SystemConfigScreen]
class SystemConfigRoute extends _i18.PageRouteInfo<void> {
  const SystemConfigRoute({List<_i18.PageRouteInfo>? children})
    : super(SystemConfigRoute.name, initialChildren: children);

  static const String name = 'SystemConfigRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i16.SystemConfigScreen());
    },
  );
}

/// generated route for
/// [_i17.UsuarioScreen]
class UsuarioRoute extends _i18.PageRouteInfo<void> {
  const UsuarioRoute({List<_i18.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i18.PageInfo page = _i18.PageInfo(
    name,
    builder: (data) {
      return _i18.WrappedRoute(child: const _i17.UsuarioScreen());
    },
  );
}
