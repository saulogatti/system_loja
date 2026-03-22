import 'package:drift/drift.dart';
import 'package:system_loja/core/models/invoice_type.dart';

/// Tabela para armazenar notas fiscais no Drift.
///
/// Regra exclusiva: exatamente um de [customerId] ou [companyId] deve ser
/// preenchido, independente do [type].
class InvoicesRecords extends Table {
  /// CPF do cliente (desnormalizado; null quando vínculo for empresa).
  TextColumn get customerCpf => text().named('cliente_cpf').nullable()();

  /// ID do cliente (null quando vínculo for empresa).
  IntColumn get customerId => integer().named('cliente_id').nullable()();

  /// Nome do cliente (desnormalizado; null quando vínculo for empresa).
  TextColumn get customerName => text().named('cliente_nome').nullable()();

  /// ID da empresa vinculada (null quando vínculo for cliente).
  IntColumn get companyId => integer().named('empresa_id').nullable()();

  /// Nome da empresa (desnormalizado; null quando vínculo for cliente).
  TextColumn get companyName => text().named('empresa_nome').nullable()();

  /// CNPJ da empresa (desnormalizado; null quando vínculo for cliente).
  TextColumn get companyCnpj => text().named('empresa_cnpj').nullable()();

  IntColumn get id => integer().autoIncrement()();

  /// Número da nota fiscal.
  TextColumn get invoiceNumber => text().named('numero_nota').unique()();

  /// Data de emissão da nota.
  DateTimeColumn get issueDate => dateTime().named('data_emissao')();

  /// Data da última atualização.
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();

  /// Forma de pagamento.
  TextColumn get paymentMethod => text().named('forma_pagamento')();

  /// Data de cadastro no sistema.
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();

  /// Valor total da nota fiscal.
  RealColumn get totalValue => real().named('valor_total')();

  /// Tipo da nota fiscal (entrada ou saída). Padrão: saída.
  TextColumn get type => textEnum<InvoiceType>()
      .named('tipo')
      .withDefault(const Constant('exit'))();
}
