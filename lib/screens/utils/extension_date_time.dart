import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  /// Formata a data no padrão brasileiro (DD/MM/YYYY HH:mm)
  String toFormattedDate() {
    final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    return dateFormat.format(this);
  }
}
