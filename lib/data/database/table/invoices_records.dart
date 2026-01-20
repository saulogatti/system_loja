import 'package:drift/drift.dart';

/// Tabela para armazenar notas fiscais no Drift.
class InvoicesRecords extends Table {
  IntColumn get id => integer().autoIncrement()();
  
  /// Número da nota fiscal
  TextColumn get invoiceNumber => text().named('numero_nota')();
  
  /// ID do cliente
  IntColumn get customerId => integer().named('cliente_id')();
  
  /// Nome do cliente (desnormalizado para facilitar consultas)
  TextColumn get customerName => text().named('cliente_nome')();
  
  /// CPF do cliente (desnormalizado para facilitar consultas)
  TextColumn get customerCpf => text().named('cliente_cpf')();
  
  /// Valor total da nota fiscal
  RealColumn get totalValue => real().named('valor_total')();
  
  /// Forma de pagamento
  TextColumn get paymentMethod => text().named('forma_pagamento')();
  
  /// Data de emissão da nota
  DateTimeColumn get issueDate => dateTime().named('data_emissao')();
  
  /// Data de cadastro no sistema
  DateTimeColumn get registrationDate =>
      dateTime().withDefault(currentDateAndTime)();
  
  /// Data da última atualização
  DateTimeColumn get lastUpdatedDate => dateTime().nullable()();
}
