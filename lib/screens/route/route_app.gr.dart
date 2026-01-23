// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i10;
import 'package:collection/collection.dart' as _i14;
import 'package:flutter/material.dart' as _i11;
import 'package:system_loja/core/models/customer.dart' as _i12;
import 'package:system_loja/core/models/product.dart' as _i13;
import 'package:system_loja/screens/configuracoes/configuracoes_screen.dart'
    as _i1;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i9;
import 'package:system_loja/screens/customer/customer_detail_screen.dart'
    as _i2;
import 'package:system_loja/screens/customer/customer_view.dart' as _i3;
import 'package:system_loja/screens/home/home_screen.dart' as _i4;
import 'package:system_loja/screens/products/product_detail_screen.dart' as _i6;
import 'package:system_loja/screens/products/product_screen.dart' as _i7;
import 'package:system_loja/screens/route/route_app.dart' as _i5;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i8;

/// generated route for
/// [_i1.ConfiguracoesScreen]
class ConfiguracoesRoute extends _i10.PageRouteInfo<void> {
  const ConfiguracoesRoute({List<_i10.PageRouteInfo>? children})
    : super(ConfiguracoesRoute.name, initialChildren: children);

  static const String name = 'ConfiguracoesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i1.ConfiguracoesScreen();
    },
  );
}

/// generated route for
/// [_i2.CustomerDetailScreen]
class CustomerDetailRoute extends _i10.PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    _i11.Key? key,
    required _i12.Customer customer,
    List<_i10.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerDetailRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i2.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({this.key, required this.customer});

  final _i11.Key? key;

  final _i12.Customer customer;

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
/// [_i3.CustomerView]
class CustomerRoute extends _i10.PageRouteInfo<void> {
  const CustomerRoute({List<_i10.PageRouteInfo>? children})
    : super(CustomerRoute.name, initialChildren: children);

  static const String name = 'CustomerRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i3.CustomerView();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i10.PageRouteInfo<void> {
  const HomeRoute({List<_i10.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i4.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.HostScreen]
class HostRoute extends _i10.PageRouteInfo<void> {
  const HostRoute({List<_i10.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i5.HostScreen();
    },
  );
}

/// generated route for
/// [_i6.ProductDetailScreen]
class ProductDetailRoute extends _i10.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i11.Key? key,
    required _i13.Product product,
    List<_i13.Product> productList = const [],
    List<_i10.PageRouteInfo>? children,
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

  static _i10.PageInfo page = _i10.PageInfo(
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
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
    this.productList = const [],
  });

  final _i11.Key? key;

  final _i13.Product product;

  final List<_i13.Product> productList;

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
        const _i14.ListEquality<_i13.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i14.ListEquality<_i13.Product>().hash(productList);
}

/// generated route for
/// [_i7.ProductInfoScreen]
class ProductInfoRoute extends _i10.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i10.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i7.ProductInfoScreen();
    },
  );
}

/// generated route for
/// [_i8.SalesView]
class SalesRoute extends _i10.PageRouteInfo<void> {
  const SalesRoute({List<_i10.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i8.SalesView();
    },
  );
}

/// generated route for
/// [_i9.UsuarioScreen]
class UsuarioRoute extends _i10.PageRouteInfo<void> {
  const UsuarioRoute({List<_i10.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i10.PageInfo page = _i10.PageInfo(
    name,
    builder: (data) {
      return const _i9.UsuarioScreen();
    },
  );
}
