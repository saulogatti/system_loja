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
import 'package:system_loja/core/interface/i_category_repository.dart' as _i30;
import 'package:system_loja/core/interface/i_product_repository.dart' as _i29;
import 'package:system_loja/core/interface/i_sales_repository.dart' as _i28;
import 'package:system_loja/core/models/company.dart' as _i23;
import 'package:system_loja/core/models/customer.dart' as _i25;
import 'package:system_loja/core/models/product.dart' as _i26;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i31;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i2;
import 'package:system_loja/screens/configs/system/system_config_screen.dart'
    as _i20;
import 'package:system_loja/screens/configuracoes/issuer_config_screen.dart'
    as _i7;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i8;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i9;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i19;
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
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i32;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i16;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i18;

/// generated route for
/// [_i1.CadastroGroupScreen]
class CadastroGroupRoute extends _i22.PageRouteInfo<void> {
  const CadastroGroupRoute({List<_i22.PageRouteInfo>? children})
    : super(CadastroGroupRoute.name, initialChildren: children);

  static const String name = 'CadastroGroupRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i1.CadastroGroupScreen();
    },
  );
}

/// generated route for
/// [_i2.CategoryManagementScreen]
class CategoryManagementRoute extends _i22.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i22.PageRouteInfo>? children})
    : super(CategoryManagementRoute.name, initialChildren: children);

  static const String name = 'CategoryManagementRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i2.CategoryManagementScreen());
    },
  );
}

/// generated route for
/// [_i3.CompanyEditView]
class CompanyEditRoute extends _i22.PageRouteInfo<CompanyEditRouteArgs> {
  CompanyEditRoute({
    required _i23.Company company,
    _i24.Key? key,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CompanyEditRoute.name,
         args: CompanyEditRouteArgs(company: company, key: key),
         initialChildren: children,
       );

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
}

class CompanyEditRouteArgs {
  const CompanyEditRouteArgs({required this.company, this.key});

  final _i23.Company company;

  final _i24.Key? key;

  @override
  String toString() {
    return 'CompanyEditRouteArgs{company: $company, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CompanyEditRouteArgs) return false;
    return company == other.company && key == other.key;
  }

  @override
  int get hashCode => company.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i4.CustomerEditView]
class CustomerEditRoute extends _i22.PageRouteInfo<CustomerEditRouteArgs> {
  CustomerEditRoute({
    required _i25.Customer customer,
    _i24.Key? key,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         CustomerEditRoute.name,
         args: CustomerEditRouteArgs(customer: customer, key: key),
         initialChildren: children,
       );

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
}

class CustomerEditRouteArgs {
  const CustomerEditRouteArgs({required this.customer, this.key});

  final _i25.Customer customer;

  final _i24.Key? key;

  @override
  String toString() {
    return 'CustomerEditRouteArgs{customer: $customer, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! CustomerEditRouteArgs) return false;
    return customer == other.customer && key == other.key;
  }

  @override
  int get hashCode => customer.hashCode ^ key.hashCode;
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i22.PageRouteInfo<void> {
  const HomeRoute({List<_i22.PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i5.HomeScreen();
    },
  );
}

/// generated route for
/// [_i6.HostScreen]
class HostRoute extends _i22.PageRouteInfo<void> {
  const HostRoute({List<_i22.PageRouteInfo>? children})
    : super(HostRoute.name, initialChildren: children);

  static const String name = 'HostRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i6.HostScreen();
    },
  );
}

/// generated route for
/// [_i7.IssuerConfigScreen]
class IssuerConfigRoute extends _i22.PageRouteInfo<void> {
  const IssuerConfigRoute({List<_i22.PageRouteInfo>? children})
    : super(IssuerConfigRoute.name, initialChildren: children);

  static const String name = 'IssuerConfigRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i7.IssuerConfigScreen();
    },
  );
}

/// generated route for
/// [_i8.LogSystemScreen]
class LogSystemRoute extends _i22.PageRouteInfo<void> {
  const LogSystemRoute({List<_i22.PageRouteInfo>? children})
    : super(LogSystemRoute.name, initialChildren: children);

  static const String name = 'LogSystemRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i8.LogSystemScreen());
    },
  );
}

/// generated route for
/// [_i9.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i22.PageRouteInfo<void> {
  const LogsAnalyticsRoute({List<_i22.PageRouteInfo>? children})
    : super(LogsAnalyticsRoute.name, initialChildren: children);

  static const String name = 'LogsAnalyticsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i9.LogsAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i10.PersonListScreen]
class PersonListRoute extends _i22.PageRouteInfo<void> {
  const PersonListRoute({List<_i22.PageRouteInfo>? children})
    : super(PersonListRoute.name, initialChildren: children);

  static const String name = 'PersonListRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i10.PersonListScreen());
    },
  );
}

/// generated route for
/// [_i11.PersonRegistrationView]
class PersonRegistrationRoute extends _i22.PageRouteInfo<void> {
  const PersonRegistrationRoute({List<_i22.PageRouteInfo>? children})
    : super(PersonRegistrationRoute.name, initialChildren: children);

  static const String name = 'PersonRegistrationRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i11.PersonRegistrationView();
    },
  );
}

/// generated route for
/// [_i12.ProductDetailScreen]
class ProductDetailRoute extends _i22.PageRouteInfo<ProductDetailRouteArgs> {
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
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    required this.product,
    this.key,
    this.productList = const [],
  });

  final _i26.Product product;

  final _i24.Key? key;

  final List<_i26.Product> productList;

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
        const _i27.ListEquality<_i26.Product>().equals(
          productList,
          other.productList,
        );
  }

  @override
  int get hashCode =>
      product.hashCode ^
      key.hashCode ^
      const _i27.ListEquality<_i26.Product>().hash(productList);
}

/// generated route for
/// [_i13.ProductInfoScreen]
class ProductInfoRoute extends _i22.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i22.PageRouteInfo>? children})
    : super(ProductInfoRoute.name, initialChildren: children);

  static const String name = 'ProductInfoRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i13.ProductInfoScreen());
    },
  );
}

/// generated route for
/// [_i14.ProductListScreen]
class ProductListRoute extends _i22.PageRouteInfo<void> {
  const ProductListRoute({List<_i22.PageRouteInfo>? children})
    : super(ProductListRoute.name, initialChildren: children);

  static const String name = 'ProductListRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i14.ProductListScreen());
    },
  );
}

/// generated route for
/// [_i15.RelatoriosScreen]
class RelatoriosRoute extends _i22.PageRouteInfo<RelatoriosRouteArgs> {
  RelatoriosRoute({
    _i24.Key? key,
    _i28.ISalesRepository? salesRepository,
    _i29.IProductRepository? productRepository,
    _i30.ICategoryRepository? categoryRepository,
    List<_i22.PageRouteInfo>? children,
  }) : super(
         RelatoriosRoute.name,
         args: RelatoriosRouteArgs(
           key: key,
           salesRepository: salesRepository,
           productRepository: productRepository,
           categoryRepository: categoryRepository,
         ),
         initialChildren: children,
       );

  static const String name = 'RelatoriosRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<RelatoriosRouteArgs>(
        orElse: () => const RelatoriosRouteArgs(),
      );
      return _i22.WrappedRoute(
        child: _i15.RelatoriosScreen(
          key: args.key,
          salesRepository: args.salesRepository,
          productRepository: args.productRepository,
          categoryRepository: args.categoryRepository,
        ),
      );
    },
  );
}

class RelatoriosRouteArgs {
  const RelatoriosRouteArgs({
    this.key,
    this.salesRepository,
    this.productRepository,
    this.categoryRepository,
  });

  final _i24.Key? key;

  final _i28.ISalesRepository? salesRepository;

  final _i29.IProductRepository? productRepository;

  final _i30.ICategoryRepository? categoryRepository;

  @override
  String toString() {
    return 'RelatoriosRouteArgs{key: $key, salesRepository: $salesRepository, productRepository: $productRepository, categoryRepository: $categoryRepository}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! RelatoriosRouteArgs) return false;
    return key == other.key &&
        salesRepository == other.salesRepository &&
        productRepository == other.productRepository &&
        categoryRepository == other.categoryRepository;
  }

  @override
  int get hashCode =>
      key.hashCode ^
      salesRepository.hashCode ^
      productRepository.hashCode ^
      categoryRepository.hashCode;
}

/// generated route for
/// [_i16.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i22.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    required List<_i31.PaymentMethodType> paymentMethods,
    required Map<int, _i25.Customer> customers,
    required Map<int, _i23.Company> companies,
    required _i32.SalesCubit salesCubit,
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

  final List<_i31.PaymentMethodType> paymentMethods;

  final Map<int, _i25.Customer> customers;

  final Map<int, _i23.Company> companies;

  final _i32.SalesCubit salesCubit;

  final List<_i26.Product> products;

  final _i24.Key? key;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{paymentMethods: $paymentMethods, customers: $customers, companies: $companies, salesCubit: $salesCubit, products: $products, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! SalesInvoiceRouteArgs) return false;
    return const _i27.ListEquality<_i31.PaymentMethodType>().equals(
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
  int get hashCode =>
      const _i27.ListEquality<_i31.PaymentMethodType>().hash(paymentMethods) ^
      const _i27.MapEquality<int, _i25.Customer>().hash(customers) ^
      const _i27.MapEquality<int, _i23.Company>().hash(companies) ^
      salesCubit.hashCode ^
      const _i27.ListEquality<_i26.Product>().hash(products) ^
      key.hashCode;
}

/// generated route for
/// [_i17.SalesPurchaseAnalyticsScreen]
class SalesPurchaseAnalyticsRoute extends _i22.PageRouteInfo<void> {
  const SalesPurchaseAnalyticsRoute({List<_i22.PageRouteInfo>? children})
    : super(SalesPurchaseAnalyticsRoute.name, initialChildren: children);

  static const String name = 'SalesPurchaseAnalyticsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i17.SalesPurchaseAnalyticsScreen();
    },
  );
}

/// generated route for
/// [_i18.SalesView]
class SalesRoute extends _i22.PageRouteInfo<void> {
  const SalesRoute({List<_i22.PageRouteInfo>? children})
    : super(SalesRoute.name, initialChildren: children);

  static const String name = 'SalesRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return const _i18.SalesView();
    },
  );
}

/// generated route for
/// [_i19.SettingsScreen]
class SettingsRoute extends _i22.PageRouteInfo<void> {
  const SettingsRoute({List<_i22.PageRouteInfo>? children})
    : super(SettingsRoute.name, initialChildren: children);

  static const String name = 'SettingsRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i19.SettingsScreen());
    },
  );
}

/// generated route for
/// [_i20.SystemConfigScreen]
class SystemConfigRoute extends _i22.PageRouteInfo<void> {
  const SystemConfigRoute({List<_i22.PageRouteInfo>? children})
    : super(SystemConfigRoute.name, initialChildren: children);

  static const String name = 'SystemConfigRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i20.SystemConfigScreen());
    },
  );
}

/// generated route for
/// [_i21.UsuarioScreen]
class UsuarioRoute extends _i22.PageRouteInfo<void> {
  const UsuarioRoute({List<_i22.PageRouteInfo>? children})
    : super(UsuarioRoute.name, initialChildren: children);

  static const String name = 'UsuarioRoute';

  static _i22.PageInfo page = _i22.PageInfo(
    name,
    builder: (data) {
      return _i22.WrappedRoute(child: const _i21.UsuarioScreen());
    },
  );
}
