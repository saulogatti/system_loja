// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i19;
import 'package:collection/collection.dart' as _i24;
import 'package:flutter/material.dart' as _i20;
import 'package:system_loja/core/models/company.dart' as _i21;
import 'package:system_loja/core/models/customer.dart' as _i22;
import 'package:system_loja/core/models/product.dart' as _i23;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i25;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i2;
import 'package:system_loja/screens/company/company_edit_view.dart' as _i3;
import 'package:system_loja/screens/company/company_view.dart' as _i4;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i8;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i9;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i16;
import 'package:system_loja/screens/configuracoes/system_config_screen.dart'
    as _i17;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i18;
import 'package:system_loja/screens/customer/customer_view.dart' as _i5;
import 'package:system_loja/screens/home/home_screen.dart' as _i6;
import 'package:system_loja/screens/host/cadastro_group_screen.dart' as _i1;
import 'package:system_loja/screens/host/host_screen.dart' as _i7;
import 'package:system_loja/screens/person_registration/person_registration_view.dart'
    as _i10;
import 'package:system_loja/screens/products/product_detail_screen.dart'
    as _i11;
import 'package:system_loja/screens/products/product_screen.dart' as _i12;
import 'package:system_loja/screens/relatorios/relatorio_screen.dart' as _i13;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i26;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i14;
import 'package:system_loja/screens/configuracoes/issuer_config_screen.dart'
    as _i27;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i15;

/// generated route for
/// [_i1.CadastroGroupScreen]
class CadastroGroupRoute extends _i19.PageRouteInfo<void> {
  const CadastroGroupRoute({List<_i19.PageRouteInfo>? children})
    : super(CadastroGroupRoute.name, initialChildren: children);

  static const String name = 'CadastroGroupRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i1.CadastroGroupScreen();
    },
  );
}

/// generated route for
/// [_i2.CategoryManagementScreen]
class CategoryManagementRoute extends _i19.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i19.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);

  static const String name = 'CategoryManagementRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i2.CategoryManagementScreen());
    },
  );
}

/// generated route for
/// [_i3.CompanyEditView]
class CompanyEditRoute extends _i19.PageRouteInfo<CompanyEditRouteArgs> {
  CompanyEditRoute({
    _i20.Key? key,
    required _i21.Company company,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         CompanyEditRoute.name,
         args: CompanyEditRouteArgs(key: key, company: company),
         initialChildren: children,
       );

  static const String name = 'CompanyEditRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CompanyEditRouteArgs>();
      return _i3.CompanyEditView(key: args.key, company: args.company);
    },
  );
}

class CompanyEditRouteArgs {
  const CompanyEditRouteArgs({this.key, required this.company});

  final _i20.Key? key;

  final _i21.Company company;

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
/// [_i4.CompanyView]
class CompanyRoute extends _i19.PageRouteInfo<void> {
  const CompanyRoute({List<_i19.PageRouteInfo>? children})
    : super(CompanyRoute.name, initialChildren: children);

  static const String name = 'CompanyRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i4.CompanyView();
    },
  );
}

/// generated route for
/// [_i5.CustomerView]
class CustomerRoute extends _i19.PageRouteInfo<CustomerRouteArgs> {
  CustomerRoute({
    _i20.Key? key,
    _i22.Customer? customer,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         CustomerRoute.name,
         args: CustomerRouteArgs(key: key, customer: customer),
         initialChildren: children,
       );

  static const String name = 'CustomerRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<CustomerRouteArgs>(
        orElse: () => const CustomerRouteArgs(),
      );
      return _i5.CustomerView(key: args.key, customer: args.customer);
    },
  );
}

class CustomerRouteArgs {
  const CustomerRouteArgs({this.key, this.customer});

  final _i20.Key? key;

  final _i22.Customer? customer;

  @override
  String toString() {
    return 'CustomerRouteArgs{key: $key, customer: $customer}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerRouteArgs) return false;
    return key == other.key && customer == other.customer;
  }

  @override
  int get hashCode => key.hashCode ^ customer.hashCode;
}

/// generated route for
/// [_i6.HomeScreen]
class HomeRoute extends _i19.PageRouteInfo<void> {
  const HomeRoute({List<_i19.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i6.HomeScreen();
    },
  );
}

/// generated route for
/// [_i7.HostScreen]
class HostRoute extends _i19.PageRouteInfo<void> {
  const HostRoute({List<_i19.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i7.HostScreen();
    },
  );
}

/// generated route for
/// [_i8.LogSystemScreen]
class LogSystemRoute extends _i19.PageRouteInfo<void> {
  const LogSystemRoute({List<_i19.PageRouteInfo>? children})
    : super(LogSystemRoute.name, initialChildren: children);

  static const String name = 'LogSystemRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i8.LogSystemScreen());
    },
  );
}

/// generated route for
/// [_i9.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i19.PageRouteInfo<void> {
  const LogsAnalyticsRoute({List<_i19.PageRouteInfo>? children})
    : super(LogsAnalyticsRoute.name, initialChildren: children);

  static const String name = 'LogsAnalyticsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i9.LogsAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i10.PersonRegistrationView]
class PersonRegistrationRoute extends _i19.PageRouteInfo<void> {
  const PersonRegistrationRoute({List<_i19.PageRouteInfo>? children})
    : super(PersonRegistrationRoute.name, initialChildren: children);

  static const String name = 'PersonRegistrationRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i10.PersonRegistrationView();
    },
  );
}

/// generated route for
/// [_i11.ProductDetailScreen]
class ProductDetailRoute extends _i19.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i20.Key? key,
    required _i23.Product product,
    List<_i23.Product> productList = const [],
    List<_i19.PageRouteInfo>? children,
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

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ProductDetailRouteArgs>();
      return _i19.WrappedRoute(
        child: _i11.ProductDetailScreen(
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

  final _i20.Key? key;

  final _i23.Product product;

  final List<_i23.Product> productList;

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
        const _i24.ListEquality<_i23.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      product.hashCode ^
      const _i24.ListEquality<_i23.Product>().hash(productList);
}

/// generated route for
/// [_i12.ProductInfoScreen]
class ProductInfoRoute extends _i19.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i19.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i12.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i13.RelatoriosScreen]
class RelatoriosRoute extends _i19.PageRouteInfo<void> {
  const RelatoriosRoute({List<_i19.PageRouteInfo>? children})
    : super(RelatoriosRoute.name, initialChildren: children);

  static const String name = 'RelatoriosRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i13.RelatoriosScreen());
    },
  );
}

/// generated route for
/// [_i14.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i19.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    _i20.Key? key,
    required List<_i25.PaymentMethodType> paymentMethods,
    required Map<int, _i22.Customer> customers,
    required Map<int, _i21.Company> companies,
    required _i26.SalesCubit salesCubit,
    required List<_i23.Product> products,
    List<_i19.PageRouteInfo>? children,
  }) : super(
         SalesInvoiceRoute.name,
         args: SalesInvoiceRouteArgs(
           key: key,
           paymentMethods: paymentMethods,
           customers: customers,
           companies: companies,
           salesCubit: salesCubit,
           products: products,
         ),
         initialChildren: children,
       );

  static const String name = 'SalesInvoiceRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<SalesInvoiceRouteArgs>();
      return _i14.SalesInvoiceScreen(
        key: args.key,
        paymentMethods: args.paymentMethods,
        customers: args.customers,
        companies: args.companies,
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
    required this.companies,
    required this.salesCubit,
    required this.products,
  });

  final _i20.Key? key;

  final List<_i25.PaymentMethodType> paymentMethods;

  final Map<int, _i22.Customer> customers;

  final Map<int, _i21.Company> companies;

  final _i26.SalesCubit salesCubit;

  final List<_i23.Product> products;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, paymentMethods: $paymentMethods, customers: $customers, companies: $companies, salesCubit: $salesCubit, products: $products}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return key == other.key &&
        const _i24.ListEquality<_i25.PaymentMethodType>().equals(
          paymentMethods,
          other.paymentMethods,
        ) &&
        const _i24.MapEquality<int, _i22.Customer>().equals(
          customers,
          other.customers,
        ) &&
        const _i24.MapEquality<int, _i21.Company>().equals(
          companies,
          other.companies,
        ) &&
        salesCubit == other.salesCubit &&
        const _i24.ListEquality<_i23.Product>().equals(
          products,
          other.products,
        );
  }

  @override
  int get hashCode =>
      key.hashCode ^
      const _i24.ListEquality<_i25.PaymentMethodType>().hash(paymentMethods) ^
      const _i24.MapEquality<int, _i22.Customer>().hash(customers) ^
      const _i24.MapEquality<int, _i21.Company>().hash(companies) ^
      salesCubit.hashCode ^
      const _i24.ListEquality<_i23.Product>().hash(products);
}

/// generated route for
/// [_i15.SalesView]
class SalesRoute extends _i19.PageRouteInfo<void> {
  const SalesRoute({List<_i19.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i15.SalesView();
    },
  );
}

/// generated route for
/// [_i16.SettingsScreen]
class SettingsRoute extends _i19.PageRouteInfo<void> {
  const SettingsRoute({List<_i19.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i16.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i17.SystemConfigScreen]
class SystemConfigRoute extends _i19.PageRouteInfo<void> {
  const SystemConfigRoute({List<_i19.PageRouteInfo>? children})
    : super(SystemConfigRoute.name, initialChildren: children);

  static const String name = 'SystemConfigRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i17.SystemConfigScreen());
    },
  );
}

/// generated route for
/// [_i18.UsuarioScreen]
class UsuarioRoute extends _i19.PageRouteInfo<void> {
  const UsuarioRoute({List<_i19.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return _i19.WrappedRoute(child: const _i18.UsuarioScreen());
    },
  );
}

/// generated route for
/// [_i27.IssuerConfigScreen]
class IssuerConfigRoute extends _i19.PageRouteInfo<void> {
  const IssuerConfigRoute({List<_i19.PageRouteInfo>? children})
    : super(IssuerConfigRoute.name, initialChildren: children);

  static const String name = 'IssuerConfigRoute';

  static _i19.PageInfo page = _i19.PageInfo(
    name,
    builder: (data) {
      return const _i27.IssuerConfigScreen();
    },
  );
}
