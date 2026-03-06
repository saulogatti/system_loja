import 'package:json_annotation/json_annotation.dart';

/// Objeto padrão com ID único.
abstract class DefaultObject {
  final int id;
  @JsonKey(name: 'registration_date')
  final DateTime registrationDate;

  @JsonKey(name: 'last_updated_date')
  DateTime lastUpdatedDate;
  DefaultObject({int? id, DateTime? registrationDate, DateTime? lastUpdatedDate})
    : id = id ?? -1,
      registrationDate = registrationDate ?? DateTime.now(),
      lastUpdatedDate = lastUpdatedDate ?? DateTime.now();
}
