import 'package:drift/drift.dart';
import 'package:system_loja/core/models/company.dart';
import 'package:system_loja/data/database/app_database.dart';

/// Extensão para converter Company (domínio) para CompanyRecordsCompanion (Drift).
extension CompanyToCompanion on Company {
  /// Converte um modelo de domínio Company para Companion usado em insert/update.
  ///
  /// Para inserções, usa .insert(). Para atualizações, inclui o ID.
  CompanyRecordsCompanion toCompanion({bool forUpdate = false}) {
    if (forUpdate) {
      return CompanyRecordsCompanion(
        id: Value(id),
        corporateName: Value(corporateName),
        cnpj: Value(cnpj),
        email: Value(email),
        address: Value(address),
        lastUpdatedDate: Value(DateTime.now()),
        registrationDate: Value(registrationDate),
      );
    }
    return CompanyRecordsCompanion.insert(
      corporateName: corporateName,
      cnpj: cnpj,
      email: Value(email),
      address: Value(address),

      lastUpdatedDate: Value(lastUpdatedDate),
      registrationDate: Value(registrationDate),
    );
  }
}
