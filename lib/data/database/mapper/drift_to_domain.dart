import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/core/models/product_category.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/system_database.dart';

/// Converte [AddressRecord] (Drift) para [Address] (domínio).
///
/// {@category persistencia}
/// {@subCategory Cadastros}
extension AddressRecordToDomain on AddressRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  Address toDomain() => Address(
    street: street,
    zipCode: zipCode,
    neighborhood: neighborhood,
    city: city,
    state: state,
  );
}

/// Converte [CategoriesRecord] (Drift) para [ProductCategory] (domínio).
///
/// {@category persistencia}
/// {@subCategory Cadastros}
extension CategoriesRecordToDomain on CategoriesRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  ProductCategory toDomain() => ProductCategory(
    id: id,
    name: name,
    description: description,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

/// Converte [CompanyRecord] (Drift) para [Company] (domínio).
///
/// {@category persistencia}
/// {@subCategory Cadastros}
extension CompanyRecordToDomain on CompanyRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  Company toDomain() => Company(
    id: id,
    name: name,
    cnpj: cnpj,
    email: email,
    address: address ?? const Address(),
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

/// Converte [CustomerRecord] (Drift) para [Customer] (domínio).
///
/// {@category persistencia}
/// {@subCategory Cadastros}
extension CustomerRecordToDomain on CustomerRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  Customer toDomain() => Customer(
    id: id,
    name: name,
    cpf: cpf,
    email: email,
    phone: phone,
    address: address ?? const Address(),
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

/// Converte [LogsRecord] (Drift) para [ActivityLog] (domínio).
///
/// {@category persistencia}
/// {@subCategory Sistema}
extension LogsRecordToDomain on LogsRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  ActivityLog toDomain() => ActivityLog(
    actionType: actionType,
    entity: entity,
    userId: userId,
    userName: userName,
    timestamp: timestamp,
    details: details,
    id: id,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

/// Converte [ProductsRecord] (Drift) para [Product] (domínio).
///
/// {@category persistencia}
/// {@subCategory Cadastros}
extension ProductsRecordToDomain on ProductsRecord {
  /// Mapeia a linha Drift para a entidade de domínio.
  Product toDomain() => Product(
    id: id,
    name: name,
    description: description,
    price: price,
    stockQuantity: stockQuantity,
    code: code,
    categoryId: categoryId,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}
