/// Objeto base para entidades de domínio com ID, data de cadastro e data de atualização.
///
/// Todas as entidades do sistema herdam desta classe para garantir
/// rastreabilidade de criação e atualização.
abstract class DefaultObject {
  /// Identificador único da entidade. Valor padrão -1 indica objeto não persistido.
  final int id;

  /// Data e hora em que o registro foi criado.
  final DateTime registrationDate;

  /// Data e hora da última atualização do registro.
  final DateTime lastUpdatedDate;

  DefaultObject({
    DateTime? registrationDate,
    DateTime? lastUpdatedDate,
    int? id,
  }) : id = id ?? -1,
       registrationDate = registrationDate ?? DateTime.now(),
       lastUpdatedDate = lastUpdatedDate ?? DateTime.now();
}
