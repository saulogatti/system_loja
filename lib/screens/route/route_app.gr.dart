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
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i9;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i10;
import 'package:system_loja/screens/customer/customer_detail_screen.dart'
    as _i1;
import 'package:system_loja/screens/customer/customer_view.dart' as _i2;
import 'package:system_loja/screens/home/home_screen.dart' as _i3;
import 'package:system_loja/screens/products/product_detail_screen.dart' as _i5;
import 'package:system_loja/screens/products/product_screen.dart' as _i6;
import 'package:system_loja/screens/route/route_app.dart' as _i4;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i16;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i7;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i8;

/// generated route for
/// [_i1.CustomerDetailScreen]
class CustomerDetailRoute extends _i11.PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    _i12.Key? key,
    required _i13.Customer customer,
    List<_i11.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i1.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({this.key, required this.customer});

  final _i12.Key? key;

  final _i13.Customer customer;

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
/// [_i2.CustomerView]
class CustomerRoute extends _i11.PageRouteInfo<void> {
  const CustomerRoute({List<_i11.PageRouteInfo>? children})
    : super(CustomerRoute.name, initialChildren: children);

  static const String name = 'CustomerRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i2.CustomerView();
    },
  );
}

/// generated route for
/// [_i3.HomeScreen]
class HomeRoute extends _i11.PageRouteInfo<void> {
  const HomeRoute({List<_i11.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i3.HomeScreen();
    },
  );
}

/// generated route for
/// [_i4.HostScreen]
class HostRoute extends _i11.PageRouteInfo<void> {
  const HostRoute({List<_i11.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i4.HostScreen();
    },
  );
}

/// generated route for
/// [_i5.ProductDetailScreen]
class ProductDetailRoute extends _i11.PageRouteInfo<ProductDetailRouteArgs> {
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

  static const String name = 'ProductDetailRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i11.WrappedRoute(
        child: _i5.ProductDetailScreen(
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

  final _i12.Key? key;

  final _i14.Product product;

  final List<_i14.Product> productList;

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
        const _i15.ListEquality<_i14.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i15.ListEquality<_i14.Product>().hash(productList);
}

/// generated route for
/// [_i6.ProductInfoScreen]
class ProductInfoRoute extends _i11.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i11.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i6.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i7.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i11.PageRouteInfo<SalesInvoiceRouteArgs> {
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

  static const String name = 'SalesInvoiceRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i7.SalesInvoiceScreen(
        key: args.key,
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
    required this.customers,
    required this.salesCubit,
    required this.products,
  });

  final _i12.Key? key;

  final Map<int, _i13.Customer> customers;

  final _i16.SalesCubit salesCubit;

  final List<_i14.Product> products;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, customers: $customers, salesCubit: $salesCubit, products: $products}';
  }

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
  int get hashCode =>
      key.hashCode ^
      const _i15.MapEquality<int, _i13.Customer>().hash(customers) ^
      salesCubit.hashCode ^
      const _i15.ListEquality<_i14.Product>().hash(products);
}

/// generated route for
/// [_i8.SalesView]
class SalesRoute extends _i11.PageRouteInfo<void> {
  const SalesRoute({List<_i11.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i8.SalesView();
    },
  );
}

/// generated route for
/// [_i9.SettingsScreen]
class SettingsRoute extends _i11.PageRouteInfo<void> {
  const SettingsRoute({List<_i11.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return _i11.WrappedRoute(child: const _i9.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i10.UsuarioScreen]
class UsuarioRoute extends _i11.PageRouteInfo<void> {
  const UsuarioRoute({List<_i11.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i11.PageInfo page = _i11.PageInfo(
    name,
    builder: (data) {
      return const _i10.UsuarioScreen();
    },
  );
}
