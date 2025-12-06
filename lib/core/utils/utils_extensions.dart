import 'package:system_loja/core/models/default/default_object.dart';

extension MapId on Map<int, DefaultObject> {
 int get novoId {
    if (isEmpty) return 1;
    return keys.reduce((a, b) => a > b ? a : b) + 1;
  }
}