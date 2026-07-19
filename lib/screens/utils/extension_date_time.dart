import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  static final DateFormat dateFormat = DateFormat('dd/MM/yyyy HH:mm');

  /// Formata a data no padrão brasileiro (DD/MM/YYYY HH:mm)
  String toFormattedDate() => dateFormat.format(this);
}
