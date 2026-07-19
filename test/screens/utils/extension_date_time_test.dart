import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/utils/extension_date_time.dart';

void main() {
  group('DateTimeExtension', () {
    group('toFormattedDate', () {
      test('deve formatar data e hora padrão corretamente', () {
        final dateTime = DateTime(2023, 10, 15, 14, 30);
        expect(dateTime.toFormattedDate(), '15/10/2023 14:30');
      });

      test('deve aplicar preenchimento de zeros para valores de um dígito', () {
        final dateTime = DateTime(2023, 1, 5, 9, 5);
        expect(dateTime.toFormattedDate(), '05/01/2023 09:05');
      });

      test('deve formatar corretamente no último dia do ano', () {
        final dateTime = DateTime(2023, 12, 31, 23, 59);
        expect(dateTime.toFormattedDate(), '31/12/2023 23:59');
      });

      test('deve formatar corretamente no primeiro dia do ano', () {
        final dateTime = DateTime(2024);
        expect(dateTime.toFormattedDate(), '01/01/2024 00:00');
      });

      test('deve formatar corretamente em ano bissexto', () {
        final dateTime = DateTime(2024, 2, 29, 12);
        expect(dateTime.toFormattedDate(), '29/02/2024 12:00');
      });
    });
  });
}
