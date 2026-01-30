// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i14;
import 'package:collection/collection.dart' as _i18;
import 'package:flutter/material.dart' as _i15;
import 'package:system_loja/core/models/customer.dart' as _i16;
import 'package:system_loja/core/models/product.dart' as _i17;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i1;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i10;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i11;
import 'package:system_loja/screens/customer/customer_detail_screen.dart'
    as _i2;
import 'package:system_loja/screens/customer/customer_view.dart' as _i3;
import 'package:system_loja/screens/home/home_screen.dart' as _i4;
import 'package:system_loja/screens/products/product_detail_screen.dart' as _i6;
import 'package:system_loja/screens/products/product_screen.dart' as _i7;
import 'package:system_loja/screens/route/route_app.dart' as _i5;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i17;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i8;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i9;

/// generated route for
/// [_i1.CategoryManagementScreen]
class CategoryManagementRoute extends _i14.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i14.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);

  static const String name = 'CategoryManagementRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i14.WrappedRoute(child: const _i1.CategoryManagementScreen());
    },
  );
}

/// generated route for
/// [_i2.CustomerDetailScreen]
class CustomerDetailRoute extends _i14.PageRouteInfo<CustomerDetailRouteArgs> {
  CustomerDetailRoute({
    _i15.Key? key,
    required _i16.Customer customer,
    List<_i14.PageRouteInfo>? children,
  }) : super(
         CustomerDetailRoute.name,
         args: CustomerDetailRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerDetailRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerDetailRouteArgs>();
      return _i2.CustomerDetailScreen(key: args.key, customer: args.customer);
    },
  );
}

class CustomerDetailRouteArgs {
  const CustomerDetailRouteArgs({this.key, required this.customer});

  final _i15.Key? key;

  final _i16.Customer customer;

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
class CustomerRoute extends _i12.PageRouteInfo<void> {
  const CustomerRoute({List<_i12.PageRouteInfo>? children})
    : super(CustomerRoute.name, initialChildren: children);

  static const String name = 'CustomerRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i4.CustomerView();
    },
  );
}

/// generated route for
/// [_i2.CompanyView]
class CompanyRoute extends _i12.PageRouteInfo<void> {
  const CompanyRoute({List<_i12.PageRouteInfo>? children})
    : super(CompanyRoute.name, initialChildren: children);

  static const String name = 'CompanyRoute';

  static _i12.PageInfo page = _i12.PageInfo(
    name,
    builder: (data) {
      return const _i2.CompanyView();
    },
  );
}

/// generated route for
/// [_i4.HomeScreen]
class HomeRoute extends _i12.PageRouteInfo<void> {
  const HomeRoute({List<_i12.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i5.HostScreen]
class HostRoute extends _i12.PageRouteInfo<void> {
  const HostRoute({List<_i12.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i6.HostScreen();
    },
  );
}

/// generated route for
/// [_i6.ProductDetailScreen]
class ProductDetailRoute extends _i12.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i15.Key? key,
    required _i17.Product product,
    List<_i17.Product> productList = const [],
    List<_i14.PageRouteInfo>? children,
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

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i12.WrappedRoute(
        child: _i6.ProductDetailScreen(
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

  final _i15.Key? key;

  final _i17.Product product;

  final List<_i17.Product> productList;

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
        const _i18.ListEquality<_i17.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i18.ListEquality<_i17.Product>().hash(productList);
}

/// generated route for
/// [_i7.ProductInfoScreen]
class ProductInfoRoute extends _i12.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i12.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i7.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i8.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i12.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    _i13.Key? key,
    required Map<int, _i14.Customer> customers,
    required _i17.SalesCubit salesCubit,
    required List<_i15.Product> products,
    List<_i12.PageRouteInfo>? children,
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

  static _i14.PageInfo page = _i14.PageInfo(
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
}

class SalesInvoiceRouteArgs {
  const SalesInvoiceRouteArgs({
    this.key,
    required this.customers,
    required this.salesCubit,
    required this.products,
  });

  final _i15.Key? key;

  final Map<int, _i16.Customer> customers;

  final _i19.SalesCubit salesCubit;

  final List<_i17.Product> products;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, customers: $customers, salesCubit: $salesCubit, products: $products}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return key == other.key &&
        const _i18.MapEquality<int, _i16.Customer>().equals(
          customers,
          other.customers,
        ) &&
        salesCubit == other.salesCubit &&
        const _i18.ListEquality<_i17.Product>().equals(
          products,
          other.products,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i18.MapEquality<int, _i16.Customer>().hash(customers) ^
      salesCubit.hashCode ^
      const _i18.ListEquality<_i17.Product>().hash(products);
}

/// generated route for
/// [_i9.SalesView]
class SalesRoute extends _i12.PageRouteInfo<void> {
  const SalesRoute({List<_i12.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i9.SalesView();
    },
  );
}

/// generated route for
/// [_i10.SettingsScreen]
class SettingsRoute extends _i12.PageRouteInfo<void> {
  const SettingsRoute({List<_i12.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return _i12.WrappedRoute(child: const _i10.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i11.UsuarioScreen]
class UsuarioRoute extends _i12.PageRouteInfo<void> {
  const UsuarioRoute({List<_i12.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i14.PageInfo page = _i14.PageInfo(
    name,
    builder: (data) {
      return const _i11.UsuarioScreen();
    },
  );
}
