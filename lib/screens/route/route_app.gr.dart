// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i17;
import 'package:flutter/material.dart' as _i18;
import 'package:system_loja/core/models/company.dart' as _i19;
import 'package:system_loja/core/models/customer.dart' as _i20;
import 'package:system_loja/core/models/product.dart' as _i22;
import 'package:system_loja/core/models/system_config/price_configuration.dart'
    as _i23;
import 'package:system_loja/screens/categories/category_management_screen.dart'
    as _i1;
import 'package:system_loja/screens/company/company_edit_view.dart' as _i2;
import 'package:system_loja/screens/company/company_view.dart' as _i3;
import 'package:system_loja/screens/configuracoes/log_system_screen.dart'
    as _i7;
import 'package:system_loja/screens/configuracoes/logs_analytics_screen.dart'
    as _i8;
import 'package:system_loja/screens/configuracoes/settings_screen.dart' as _i14;
import 'package:system_loja/screens/configuracoes/system_config_screen.dart'
    as _i15;
import 'package:system_loja/screens/configuracoes/usuario_screen.dart' as _i16;
import 'package:system_loja/screens/customer/customer_view.dart' as _i4;
import 'package:system_loja/screens/home/home_screen.dart' as _i5;
import 'package:system_loja/screens/person_registration/models/person_registration_form_data.dart'
    as _i21;
import 'package:system_loja/screens/person_registration/person_registration_view.dart'
    as _i9;
import 'package:system_loja/screens/products/product_detail_screen.dart'
    as _i10;
import 'package:system_loja/screens/products/product_screen.dart' as _i11;
import 'package:system_loja/screens/route/route_app.dart' as _i6;
import 'package:system_loja/screens/sales/cubit/sales_cubit.dart' as _i24;
import 'package:system_loja/screens/sales/sales_invoice_screen.dart' as _i12;
import 'package:system_loja/screens/sales/sales_screen.dart' as _i13;

abstract class $RouteApp extends _i17.RootStackRouter {
  $RouteApp({super.navigatorKey});

  @override
  final Map<String, _i17.PageFactory> pagesMap = {
    CategoryManagementRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i1.CategoryManagementScreen()),
      );
    },
    CompanyEditRoute.name: (routeData) {
      final args = routeData.argsAs<CompanyEditRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.CompanyEditView(
          key: args.key,
          company: args.company,
        ),
      );
    },
    CompanyRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.CompanyView(),
      );
    },
    CustomerRoute.name: (routeData) {
      final args = routeData.argsAs<CustomerRouteArgs>(
          orElse: () => const CustomerRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i4.CustomerView(
          key: args.key,
          customer: args.customer,
        ),
      );
    },
    HomeRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.HomeScreen(),
      );
    },
    HostRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.HostScreen(),
      );
    },
    LogSystemRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i7.LogSystemScreen()),
      );
    },
    LogsAnalyticsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.LogsAnalyticsScreen(),
      );
    },
    PersonRegistrationRoute.name: (routeData) {
      final args = routeData.argsAs<PersonRegistrationRouteArgs>(
          orElse: () => const PersonRegistrationRouteArgs());
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i9.PersonRegistrationView(
          key: args.key,
          onValidated: args.onValidated,
        ),
      );
    },
    ProductDetailRoute.name: (routeData) {
      final args = routeData.argsAs<ProductDetailRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(
            child: _i10.ProductDetailScreen(
          key: args.key,
          product: args.product,
          productList: args.productList,
        )),
      );
    },
    ProductInfoRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i11.ProductInfoScreen()),
      );
    },
    SalesInvoiceRoute.name: (routeData) {
      final args = routeData.argsAs<SalesInvoiceRouteArgs>();
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i12.SalesInvoiceScreen(
          key: args.key,
          paymentMethods: args.paymentMethods,
          customers: args.customers,
          companies: args.companies,
          salesCubit: args.salesCubit,
          products: args.products,
        ),
      );
    },
    SalesRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i13.SalesView(),
      );
    },
    SettingsRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i14.SettingsScreen()),
      );
    },
    SystemConfigRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i15.SystemConfigScreen()),
      );
    },
    UsuarioRoute.name: (routeData) {
      return _i17.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i17.WrappedRoute(child: const _i16.UsuarioScreen()),
      );
    },
  };
}

/// generated route for
/// [_i1.CategoryManagementScreen]
class CategoryManagementRoute extends _i17.PageRouteInfo<void> {
  const CategoryManagementRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CategoryManagementRoute.name,
          initialChildren: children,
        );

  static const String name = 'CategoryManagementRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
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
          args: CompanyEditRouteArgs(
            key: key,
            company: company,
          ),
          initialChildren: children,
        );

  static const String name = 'CompanyEditRoute';

  static const _i17.PageInfo<CompanyEditRouteArgs> page =
      _i17.PageInfo<CompanyEditRouteArgs>(name);
}

class CompanyEditRouteArgs {
  const CompanyEditRouteArgs({
    this.key,
    required this.company,
  });

  final _i18.Key? key;

  final _i19.Company company;

  @override
  String toString() {
    return 'CompanyEditRouteArgs{key: $key, company: $company}';
  }
}

/// generated route for
/// [_i3.CompanyView]
class CompanyRoute extends _i17.PageRouteInfo<void> {
  const CompanyRoute({List<_i17.PageRouteInfo>? children})
      : super(
          CompanyRoute.name,
          initialChildren: children,
        );

  static const String name = 'CompanyRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i4.CustomerView]
class CustomerRoute extends _i17.PageRouteInfo<CustomerRouteArgs> {
  CustomerRoute({
    _i18.Key? key,
    _i20.Customer? customer,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          CustomerRoute.name,
          args: CustomerRouteArgs(
            key: key,
            customer: customer,
          ),
          initialChildren: children,
        );

  static const String name = 'CustomerRoute';

  static const _i17.PageInfo<CustomerRouteArgs> page =
      _i17.PageInfo<CustomerRouteArgs>(name);
}

class CustomerRouteArgs {
  const CustomerRouteArgs({
    this.key,
    this.customer,
  });

  final _i18.Key? key;

  final _i20.Customer? customer;

  @override
  String toString() {
    return 'CustomerRouteArgs{key: $key, customer: $customer}';
  }
}

/// generated route for
/// [_i5.HomeScreen]
class HomeRoute extends _i17.PageRouteInfo<void> {
  const HomeRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i6.HostScreen]
class HostRoute extends _i17.PageRouteInfo<void> {
  const HostRoute({List<_i17.PageRouteInfo>? children})
      : super(
          HostRoute.name,
          initialChildren: children,
        );

  static const String name = 'HostRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i7.LogSystemScreen]
class LogSystemRoute extends _i17.PageRouteInfo<void> {
  const LogSystemRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LogSystemRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogSystemRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i8.LogsAnalyticsScreen]
class LogsAnalyticsRoute extends _i17.PageRouteInfo<void> {
  const LogsAnalyticsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          LogsAnalyticsRoute.name,
          initialChildren: children,
        );

  static const String name = 'LogsAnalyticsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i9.PersonRegistrationView]
class PersonRegistrationRoute
    extends _i17.PageRouteInfo<PersonRegistrationRouteArgs> {
  PersonRegistrationRoute({
    _i18.Key? key,
    void Function(_i21.PersonRegistrationFormData)? onValidated,
    List<_i17.PageRouteInfo>? children,
  }) : super(
          PersonRegistrationRoute.name,
          args: PersonRegistrationRouteArgs(
            key: key,
            onValidated: onValidated,
          ),
          initialChildren: children,
        );

  static const String name = 'PersonRegistrationRoute';

  static const _i17.PageInfo<PersonRegistrationRouteArgs> page =
      _i17.PageInfo<PersonRegistrationRouteArgs>(name);
}

class PersonRegistrationRouteArgs {
  const PersonRegistrationRouteArgs({
    this.key,
    this.onValidated,
  });

  final _i18.Key? key;

  final void Function(_i21.PersonRegistrationFormData)? onValidated;

  @override
  String toString() {
    return 'PersonRegistrationRouteArgs{key: $key, onValidated: $onValidated}';
  }
}

/// generated route for
/// [_i10.ProductDetailScreen]
class ProductDetailRoute extends _i17.PageRouteInfo<ProductDetailRouteArgs> {
  ProductDetailRoute({
    _i18.Key? key,
    required _i22.Product product,
    List<_i22.Product> productList = const [],
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

  static const _i17.PageInfo<ProductDetailRouteArgs> page =
      _i17.PageInfo<ProductDetailRouteArgs>(name);
}

class ProductDetailRouteArgs {
  const ProductDetailRouteArgs({
    this.key,
    required this.product,
    this.productList = const [],
  });

  final _i18.Key? key;

  final _i22.Product product;

  final List<_i22.Product> productList;

  @override
  String toString() {
    return 'ProductDetailRouteArgs{key: $key, product: $product, productList: $productList}';
  }
}

/// generated route for
/// [_i11.ProductInfoScreen]
class ProductInfoRoute extends _i17.PageRouteInfo<void> {
  const ProductInfoRoute({List<_i17.PageRouteInfo>? children})
      : super(
          ProductInfoRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProductInfoRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SalesInvoiceScreen]
class SalesInvoiceRoute extends _i17.PageRouteInfo<SalesInvoiceRouteArgs> {
  SalesInvoiceRoute({
    _i18.Key? key,
    required List<_i23.PaymentMethodType> paymentMethods,
    required Map<int, _i20.Customer> customers,
    required Map<int, _i19.Company> companies,
    required _i24.SalesCubit salesCubit,
    required List<_i22.Product> products,
    List<_i17.PageRouteInfo>? children,
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

  static const _i17.PageInfo<SalesInvoiceRouteArgs> page =
      _i17.PageInfo<SalesInvoiceRouteArgs>(name);
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

  final _i18.Key? key;

  final List<_i23.PaymentMethodType> paymentMethods;

  final Map<int, _i20.Customer> customers;

  final Map<int, _i19.Company> companies;

  final _i24.SalesCubit salesCubit;

  final List<_i22.Product> products;

  @override
  String toString() {
    return 'SalesInvoiceRouteArgs{key: $key, paymentMethods: $paymentMethods, customers: $customers, companies: $companies, salesCubit: $salesCubit, products: $products}';
  }
}

/// generated route for
/// [_i13.SalesView]
class SalesRoute extends _i17.PageRouteInfo<void> {
  const SalesRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SalesRoute.name,
          initialChildren: children,
        );

  static const String name = 'SalesRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i14.SettingsScreen]
class SettingsRoute extends _i17.PageRouteInfo<void> {
  const SettingsRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SettingsRoute.name,
          initialChildren: children,
        );

  static const String name = 'SettingsRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i15.SystemConfigScreen]
class SystemConfigRoute extends _i17.PageRouteInfo<void> {
  const SystemConfigRoute({List<_i17.PageRouteInfo>? children})
      : super(
          SystemConfigRoute.name,
          initialChildren: children,
        );

  static const String name = 'SystemConfigRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}

/// generated route for
/// [_i16.UsuarioScreen]
class UsuarioRoute extends _i17.PageRouteInfo<void> {
  const UsuarioRoute({List<_i17.PageRouteInfo>? children})
      : super(
          UsuarioRoute.name,
          initialChildren: children,
        );

  static const String name = 'UsuarioRoute';

  static const _i17.PageInfo<void> page = _i17.PageInfo<void>(name);
}
