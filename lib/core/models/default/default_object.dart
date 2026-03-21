/// Objeto padrão com ID único.
abstract class DefaultObject {
  final int id;

  final DateTime registrationDate;

  final DateTime lastUpdatedDate;

  DefaultObject({
    DateTime? registrationDate,
    DateTime? lastUpdatedDate,
    int? id,
  }) : id = id ?? -1,
       registrationDate = registrationDate ?? DateTime.now(),
       lastUpdatedDate = lastUpdatedDate ?? DateTime.now();
}
