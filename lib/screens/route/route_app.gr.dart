// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i11;
import 'package:collection/collection.dart' as _i15;
import 'package:flutter/material.dart' as _i12;
import 'package:system_loja/core/models/customer.dart' as _i13;
import 'package:system_loja/core/models/product.dart' as _i14;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i1;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i10;
import 'package:system_loja/screens/customer/customer_detail_screen.dart'
    as _i2;
import 'package:system_loja/screens/customer/customer_view.dart' as _i3;
import 'package:system_loja/screens/home/home_screen.dart' as _i4;
import 'package:system_loja/screens/products/product_detail_screen.dart' as _i6;
import 'package:system_loja/screens/products/product_screen.dart' as _i7;
import 'package:system_loja/screens/route/route_app.dart' as _i5;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i16;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i8;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i9;

/// generated route for
/// [_i1.SettingsScreen]
class ConfiguracoesRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'ConfiguracoesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i1.SettingsScreen();
    },
  );

  const ConfiguracoesRoute({List<_i11.PageRouteInfo>? children})
    : super(ConfiguracoesRoute.name, initialChildren: children);
}

/// generated route for
/// [_i2.CustomerDetailScreen]
class CustomerDetailRoute extends _i11.PageRouteInfo<CustomerDetailRouteArgs> {
  static const String name = 'CustomerDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i2.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );

  CustomerDetailRoute({
    _i12.Key? key,
    required _i13.Customer customer,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );
}

class CustomerDetailRouteArgs {
  final _i12.Key? key;

  final _i13.Customer customer;

  const CustomerDetailRouteArgs({this.key, required this.customer});

  @override
  int get hashCode => key.hashCode ^ customer.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerDetailRouteArgs) return false;
    return key == other.key && customer == other.customer;
  }

  @override
  String toString() {
    return 'CustomerDetailRouteArgs{key: $key, customer: $customer}';
  }
}

/// generated route for
/// [_i3.CustomerView]
class CustomerRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'CustomerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.CustomerView();
    },
  );

  const CustomerRoute({List<_i11.PageRouteInfo>? children})
    : super(CustomerRoute.name, initialChildren: children);
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );

  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);
}

/// generated route for
/// [_i5.HostScreen]
class HostRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'HostRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i5.HostScreen();
    },
  );

  const HostRoute({List<_i11.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);
}

/// generated route for
/// [_i6.ProductDetailScreen]
class ProductDetailRoute extends _i11.PageRouteInfo<ProductDetailRouteArgs> {
  static const String name = 'ProductDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i6.ProductDetailScreen(
        key: args.key,
        product: args.product,
        productList: args.productList,
      );
    },
  );

  ProductDetailRoute({
    _i12.Key? key,
    required _i14.Product product,
    List<_i14.Product> productList = const [],
    List<_i11.PageRouteInfo>? children,
  }) : super(
         ProductDetailRoute.name,
         args: ProductDetailRouteArgs(
           key: key,
           product: product,
           productList: productList,
         ),
         initialChildren: children,
       );
}

class ProductDetailRouteArgs {
  final _i12.Key? key;

  final _i14.Product product;

  final List<_i14.Product> productList;

  const ProductDetailRouteArgs({
    this.key,
    required this.product,
    this.productList = const [],
  });

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i15.ListEquality<_i14.Product>().hash(productList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return key == other.key &&
        product == other.product &&
        const _i15.ListEquality<_i14.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product, productList: $productList}';
  }
}

/// generated route for
/// [_i7.ProductInfoScreen]
class ProductInfoRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'ProductInfoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProductInfoScreen();
    },
  );

  const ProductInfoRoute({List<_i11.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);
}

/// generated route for
/// [_i8.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i11.PageRouteInfo<SalesInvoiceRouteArgs> {
  static const String name = 'SalesInvoiceRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i8.SalesInvoiceScreen(
        key: args.key,
        customers: args.customers,
        salesCubit: args.salesCubit,
        products: args.products,
      );
    },
  );

  SalesInvoiceRoute({
    _i12.Key? key,
    required Map<int, _i13.Customer> customers,
    required _i16.SalesCubit salesCubit,
    required List<_i14.Product> products,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         SalesInvoiceRoute.name,
         args: SalesInvoiceRouteArgs(
           key: key,
           customers: customers,
           salesCubit: salesCubit,
           products: products,
         ),
         initialChildren: children,
       );
}

class SalesInvoiceRouteArgs {
  final _i12.Key? key;

  final Map<int, _i13.Customer> customers;

  final _i16.SalesCubit salesCubit;

  final List<_i14.Product> products;

  const SalesInvoiceRouteArgs({
    this.key,
    required this.customers,
    required this.salesCubit,
    required this.products,
  });

  @override
  int get hashCode =>
      key.hashCode ^
      const _i15.MapEquality<int, _i13.Customer>().hash(customers) ^
      salesCubit.hashCode ^
      const _i15.ListEquality<_i14.Product>().hash(products);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return key == other.key &&
        const _i15.MapEquality<int, _i13.Customer>().equals(
          customers,
          other.customers,
        ) &&
        salesCubit == other.salesCubit &&
        const _i15.ListEquality<_i14.Product>().equals(
          products,
          other.products,
        );
  }

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, customers: $customers, salesCubit: $salesCubit, products: $products}';
  }
}

/// generated route for
/// [_i9.SalesView]
class SalesRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'SalesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i9.SalesView();
    },
  );

  const SalesRoute({List<_i11.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);
}

/// generated route for
/// [_i10.UsuarioScreen]
class UsuarioRoute extends _i11.PageRouteInfo<void> {
  static const String name = 'UsuarioRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.UsuarioScreen();
    },
  );

  const UsuarioRoute({List<_i11.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);
}
