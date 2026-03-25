// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i22;
import 'package:collection/collection.dart' as _i27;
import 'package:flutter/material.dart' as _i24;
import 'package:system_loja/core/models/company.dart' as _i23;
import 'package:system_loja/core/models/customer.dart' as _i25;
import 'package:system_loja/core/models/product.dart' as _i26;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i28;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i2;
import 'package:system_loja/screens/configuracoes/issuer_config_screen.dart'
    as _i7;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i8;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i9;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i19;
import 'package:system_loja/screens/configuracoes/system_config_screen.dart'
    as _i20;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i21;
import 'package:system_loja/screens/home/home_screen.dart' as _i5;
import 'package:system_loja/screens/host/cadastro_group_screen.dart' as _i1;
import 'package:system_loja/screens/host/host_screen.dart' as _i6;
import 'package:system_loja/screens/person_registration/company_edit_view.dart'
    as _i3;
import 'package:system_loja/screens/person_registration/customer_edit_view.dart'
    as _i4;
import 'package:system_loja/screens/person_registration/person_list_screen.dart'
    as _i10;
import 'package:system_loja/screens/person_registration/person_registration_view.dart'
    as _i11;
import 'package:system_loja/screens/products/product_detail_screen.dart'
    as _i12;
import 'package:system_loja/screens/products/product_list_screen.dart' as _i14;
import 'package:system_loja/screens/products/product_screen.dart' as _i13;
import 'package:system_loja/screens/relatorios/relatorio_screen.dart' as _i15;
import 'package:system_loja/screens/relatorios/sales_purchase_analytics/sales_purchase_analytics_screen.dart'
    as _i17;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i29;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i16;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i18;

/// generated route for
/// [_i1.CadastroGroupScreen]
class CadastroGroupRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'CadastroGroupRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i1.CadastroGroupScreen();
    },
  );

  const CadastroGroupRoute({List<_i22.PageRouteInfo>? children})
    : super(CadastroGroupRoute.name, initialChildren: children);
}

/// generated route for
/// [_i2.CategoryManagementScreen]
class CategoryManagementRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'CategoryManagementRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i2.CategoryManagementScreen());
    },
  );

  const CategoryManagementRoute({List<_i22.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);
}

/// generated route for
/// [_i3.CompanyEditView]
class CompanyEditRoute extends _i22.PageRouteInfo<CompanyEditRouteArgs> {
  static const String name = 'CompanyEditRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyEditRouteArgs>();
      return _i22.WrappedRoute(
        child: _i3.CompanyEditView(company: args.company, key: args.key),
      );
    },
  );

  CompanyEditRoute({
    required _i23.Company company,
    _i24.Key? key,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CompanyEditRoute.name,
         args: CompanyEditRouteArgs(company: company, key: key),
         initialChildren: children,
       );
}

class CompanyEditRouteArgs {
  final _i23.Company company;

  final _i24.Key? key;

  const CompanyEditRouteArgs({required this.company, this.key});

  @override
  int get hashCode => company.hashCode ^ key.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyEditRouteArgs) return false;
    return company == other.company && key == other.key;
  }

  @override
  String toString() {
    return 'CompanyEditRouteArgs{company: $company, key: $key}';
  }
}

/// generated route for
/// [_i4.CustomerEditView]
class CustomerEditRoute extends _i22.PageRouteInfo<CustomerEditRouteArgs> {
  static const String name = 'CustomerEditRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerEditRouteArgs>();
      return _i22.WrappedRoute(
        child: _i4.CustomerEditView(customer: args.customer, key: args.key),
      );
    },
  );

  CustomerEditRoute({
    required _i25.Customer customer,
    _i24.Key? key,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CustomerEditRoute.name,
         args: CustomerEditRouteArgs(customer: customer, key: key),
         initialChildren: children,
       );
}

class CustomerEditRouteArgs {
  final _i25.Customer customer;

  final _i24.Key? key;

  const CustomerEditRouteArgs({required this.customer, this.key});

  @override
  int get hashCode => customer.hashCode ^ key.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerEditRouteArgs) return false;
    return customer == other.customer && key == other.key;
  }

  @override
  String toString() {
    return 'CustomerEditRouteArgs{customer: $customer, key: $key}';
  }
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'HomeRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );

  const HomeRoute({List<_i22.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);
}

/// generated route for
/// [_i6.HostScreen]
class HostRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'HostRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i6.HostScreen();
    },
  );

  const HostRoute({List<_i22.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);
}

/// generated route for
/// [_i7.IssuerConfigScreen]
class IssuerConfigRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'IssuerConfigRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i7.IssuerConfigScreen();
    },
  );

  const IssuerConfigRoute({List<_i22.PageRouteInfo>? children})
    : super(IssuerConfigRoute.name, initialChildren: children);
}

/// generated route for
/// [_i9.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'LogsAnalyticsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i9.LogsAnalyticsScreen();
    },
  );

  const LogsAnalyticsRoute({List<_i22.PageRouteInfo>? children})
    : super(LogsAnalyticsRoute.name, initialChildren: children);
}

/// generated route for
/// [_i8.LogSystemScreen]
class LogSystemRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'LogSystemRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i8.LogSystemScreen());
    },
  );

  const LogSystemRoute({List<_i22.PageRouteInfo>? children})
    : super(LogSystemRoute.name, initialChildren: children);
}

/// generated route for
/// [_i10.PersonListScreen]
class PersonListRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'PersonListRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i10.PersonListScreen();
    },
  );

  const PersonListRoute({List<_i22.PageRouteInfo>? children})
    : super(PersonListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i11.PersonRegistrationView]
class PersonRegistrationRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'PersonRegistrationRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i11.PersonRegistrationView();
    },
  );

  const PersonRegistrationRoute({List<_i22.PageRouteInfo>? children})
    : super(PersonRegistrationRoute.name, initialChildren: children);
}

/// generated route for
/// [_i12.ProductDetailScreen]
class ProductDetailRoute extends _i22.PageRouteInfo<ProductDetailRouteArgs> {
  static const String name = 'ProductDetailRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i22.WrappedRoute(
        child: _i12.ProductDetailScreen(
          product: args.product,
          key: args.key,
          productList: args.productList,
        ),
      );
    },
  );

  ProductDetailRoute({
    required _i26.Product product,
    _i24.Key? key,
    List<_i26.Product> productList = const [],
    List<_i22.PageRouteInfo>? children,
  }) : super(
         ProductDetailRoute.name,
         args: ProductDetailRouteArgs(
           product: product,
           key: key,
           productList: productList,
         ),
         initialChildren: children,
       );
}

class ProductDetailRouteArgs {
  final _i26.Product product;

  final _i24.Key? key;

  final List<_i26.Product> productList;

  const ProductDetailRouteArgs({
    required this.product,
    this.key,
    this.productList = const [],
  });

  @override
  int get hashCode =>
      product.hashCode ^
      key.hashCode ^
      const _i27.ListEquality<_i26.Product>().hash(productList);

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ProductDetailRouteArgs) return false;
    return product == other.product &&
        key == other.key &&
        const _i27.ListEquality<_i26.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  String toString() {
    return 'ProductDetailRouteArgs{product: $product, key: $key, productList: $productList}';
  }
}

/// generated route for
/// [_i13.ProductInfoScreen]
class ProductInfoRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'ProductInfoRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i13.ProductInfoScreen());
    },
  );

  const ProductInfoRoute({List<_i22.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);
}

/// generated route for
/// [_i14.ProductListScreen]
class ProductListRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'ProductListRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i14.ProductListScreen());
    },
  );

  const ProductListRoute({List<_i22.PageRouteInfo>? children})
    : super(ProductListRoute.name, initialChildren: children);
}

/// generated route for
/// [_i15.RelatoriosScreen]
class RelatoriosRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'RelatoriosRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i15.RelatoriosScreen());
    },
  );

  const RelatoriosRoute({List<_i22.PageRouteInfo>? children})
    : super(RelatoriosRoute.name, initialChildren: children);
}

/// generated route for
/// [_i16.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i22.PageRouteInfo<SalesInvoiceRouteArgs> {
  static const String name = 'SalesInvoiceRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i16.SalesInvoiceScreen(
        paymentMethods: args.paymentMethods,
        customers: args.customers,
        companies: args.companies,
        salesCubit: args.salesCubit,
        products: args.products,
        key: args.key,
      );
    },
  );

  SalesInvoiceRoute({
    required List<_i28.PaymentMethodType> paymentMethods,
    required Map<int, _i25.Customer> customers,
    required Map<int, _i23.Company> companies,
    required _i29.SalesCubit salesCubit,
    required List<_i26.Product> products,
    _i24.Key? key,
    List<_i22.PageRouteInfo>? children,
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
}

class SalesInvoiceRouteArgs {
  final List<_i28.PaymentMethodType> paymentMethods;

  final Map<int, _i25.Customer> customers;

  final Map<int, _i23.Company> companies;

  final _i29.SalesCubit salesCubit;

  final List<_i26.Product> products;

  final _i24.Key? key;

  const SalesInvoiceRouteArgs({
    required this.paymentMethods,
    required this.customers,
    required this.companies,
    required this.salesCubit,
    required this.products,
    this.key,
  });

  @override
  int get hashCode =>
      const _i27.ListEquality<_i28.PaymentMethodType>().hash(paymentMethods) ^
      const _i27.MapEquality<int, _i25.Customer>().hash(customers) ^
      const _i27.MapEquality<int, _i23.Company>().hash(companies) ^
      salesCubit.hashCode ^
      const _i27.ListEquality<_i26.Product>().hash(products) ^
      key.hashCode;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return const _i27.ListEquality<_i28.PaymentMethodType>().equals(
          paymentMethods,
          other.paymentMethods,
        ) &&
        const _i27.MapEquality<int, _i25.Customer>().equals(
          customers,
          other.customers,
        ) &&
        const _i27.MapEquality<int, _i23.Company>().equals(
          companies,
          other.companies,
        ) &&
        salesCubit == other.salesCubit &&
        const _i27.ListEquality<_i26.Product>().equals(
          products,
          other.products,
        ) &&
        key == other.key;
  }

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{paymentMethods: $paymentMethods, customers: $customers, companies: $companies, salesCubit: $salesCubit, products: $products, key: $key}';
  }
}

/// generated route for
/// [_i17.SalesPurchaseAnalyticsScreen]
class SalesPurchaseAnalyticsRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'SalesPurchaseAnalyticsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i17.SalesPurchaseAnalyticsScreen();
    },
  );

  const SalesPurchaseAnalyticsRoute({List<_i22.PageRouteInfo>? children})
    : super(SalesPurchaseAnalyticsRoute.name, initialChildren: children);
}

/// generated route for
/// [_i18.SalesView]
class SalesRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'SalesRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i18.SalesView();
    },
  );

  const SalesRoute({List<_i22.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);
}

/// generated route for
/// [_i19.SettingsScreen]
class SettingsRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'SettingsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i19.SettingsScreen());
    },
  );

  const SettingsRoute({List<_i22.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);
}

/// generated route for
/// [_i20.SystemConfigScreen]
class SystemConfigRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'SystemConfigRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i20.SystemConfigScreen());
    },
  );

  const SystemConfigRoute({List<_i22.PageRouteInfo>? children})
    : super(SystemConfigRoute.name, initialChildren: children);
}

/// generated route for
/// [_i21.UsuarioScreen]
class UsuarioRoute extends _i22.PageRouteInfo<void> {
  static const String name = 'UsuarioRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i21.UsuarioScreen());
    },
  );

  const UsuarioRoute({List<_i22.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);
}
