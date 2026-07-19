import 'package:system_loja/core/models/default/default_object.dart';
import 'package:system_loja/core/models/document/document.dart';

abstract class Person<D extends Document> extends DefaultObject {
  Person({
    required this.name,
    required this.document,
    this.email,
    this.phone,
    super.registrationDate,
    super.lastUpdatedDate,
    super.id,
  });
  final String name;
  final String? email;
  final String? phone;
  final D document;
}
