import 'package:drift/drift.dart';
import 'package:system_loja/core/models/customer.dart';
import 'package:system_loja/data/database/app_database.dart';

extension ClienteFromData on ClientesRecord {
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

extension ClienteToCompanion on Customer {
  ClientesRecordsCompanion toCompanion() {
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
