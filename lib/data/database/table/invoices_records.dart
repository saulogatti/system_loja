import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Tabela para armazenar notas fiscais no Drift.
///
/// Regra exclusiva: exatamente um de [customerId] ou [companyId] deve ser
/// preenchido, independente do [type].
class InvoicesRecords extends Table {
  /// CNPJ da empresa (desnormalizado; null quando vínculo for cliente).
  TextColumn get companyCnpj => text().nullable()();

  /// ID da empresa vinculada (null quando vínculo for cliente).
  IntColumn get companyId => integer().nullable()();

  /// Nome da empresa (desnormalizado; null quando vínculo for cliente).
  TextColumn get companyName => text().nullable()();

  /// CPF do cliente (desnormalizado; null quando vínculo for empresa).
  TextColumn get customerCpf => text().nullable()();

  /// ID do cliente (null quando vínculo for empresa).
  IntColumn get customerId => integer().nullable()();

  /// Nome do cliente (desnormalizado; null quando vínculo for empresa).
  TextColumn get customerName => text().nullable()();

  IntColumn get id => integer().autoIncrement()();

  /// Número da nota fiscal.
  TextColumn get invoiceNumber => text().unique()();

  /// Data de emissão da nota.
  DateTimeColumn get issueDate => dateTime()();

  /// Data da última atualização.
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();

  /// Forma de pagamento.
  TextColumn get paymentMethod => text()();

  /// Data de cadastro no sistema.
  DateTimeColumn get registrationDate => dateTime().withDefault(currentDateAndTime)();

  /// Valor total da nota fiscal.
  RealColumn get totalValue => real()();

  /// Tipo da nota fiscal (entrada ou saída). Padrão: saída.
  TextColumn get type => textEnum<InvoiceType>().withDefault(const Constant('exit'))();
}
