import 'package:system_loja/core/models/activity_log.dart';
import 'package:system_loja/core/models/address.dart';
import 'package:system_loja/core/models/category.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/data/database/app_database.dart';
import 'package:system_loja/data/database/system_database.dart';

/// Mapeia linhas Drift geradas para entidades de domínio (`core`).

extension CategoriesRecordToDomain on CategoriesRecord {
  Category toDomain() => Category(
    id: id,
    name: name,
    description: description,
    registrationDate: registrationDate,
    lastUpdatedDate: lastUpdatedDate,
  );
}

extension ProductsRecordToDomain on ProductsRecord {
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

extension CustomerRecordToDomain on CustomerRecord {
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

extension CompanyRecordToDomain on CompanyRecord {
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

extension AddressRecordToDomain on AddressRecord {
  Address toDomain() => Address(
    street: street,
    zipCode: zipCode,
    neighborhood: neighborhood,
    city: city,
    state: state,
  );
}

extension LogsRecordToDomain on LogsRecord {
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
