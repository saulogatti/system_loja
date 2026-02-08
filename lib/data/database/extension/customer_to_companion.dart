import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Extensão para converter Customer (domínio) para CustomerRecordsCompanion (Drift).
extension CustomerToCompanion on Customer {
  /// Converte um modelo de domínio Customer para Companion usado em insert/update.
  ///
  /// Para inserções, usa .insert(). Para atualizações, inclui o ID.
  CustomerRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return CustomerRecordsCompanion(
        id: Value(id),
        name: Value(name),
        cpf: Value(cpf),
        email: Value(email),
        phone: Value(phone),
        address: Value(address),
        lastUpdatedDate: Value(DateTime.now()),
        registrationDate: Value(registrationDate),
      );
    }
    return CustomerRecordsCompanion.insert(
      name: name,
      cpf: cpf,
      email: Value(email),
      phone: Value(phone),
      address: Value(address),
      lastUpdatedDate: Value(lastUpdatedDate),
      registrationDate: Value(registrationDate),
    );
  }
}
