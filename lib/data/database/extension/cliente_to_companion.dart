import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Extensão para converter ClientesRecord (Drift) para Customer (domínio).
extension ClienteFromData on ClientesRecord {
  /// Converte um registro do banco de dados para o modelo de domínio Customer.
  Customer toDomain() {
    return Customer(
      id: id,
      name: name,
      cpf: cpf,
      email: email,
      phone: phone,
      address: address,
      lastUpdatedDate: lastUpdatedDate,
      registrationDate: registrationDate,
    );
  }
}

/// Extensão para converter Customer (domínio) para ClientesRecordsCompanion (Drift).
extension ClienteToCompanion on Customer {
  /// Converte um modelo de domínio Customer para Companion usado em insert/update.
  ///
  /// Para inserções, usa .insert(). Para atualizações, inclui o ID.
  ClientesRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return ClientesRecordsCompanion(
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
    return ClientesRecordsCompanion.insert(
      name: name,
      cpf: cpf,
      email: email,
      phone: phone,
      address: address,
      lastUpdatedDate: Value(lastUpdatedDate),
      registrationDate: Value(registrationDate),
    );
  }
}
