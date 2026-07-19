import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

void main() {
  group('Password Security Tests', () {
    test('hashPassword generates different hashes for the same password (salt)', () {
      const password = 'Password123';
      final hash1 = password.hashPassword();
      final hash2 = password.hashPassword();

      expect(hash1, isNot(equals(hash2)));
      expect(hash1.split(r'$').length, equals(4)); // BCrypt format: $2a$10$...
    });

    test('validatePassword validates password strength rules', () {
      const password = 'StrongPassword!1';

      expect(password.validatePassword(), isNull);
      expect('WrongPassword'.validatePassword(), isNotNull);
    });

    test('hashPassword output matches expected format', () {
      const password = 'TestFormat1';
      final hash = password.hashPassword();
      final parts = hash.split(r'$');

      // BCrypt format: $2a$10$<53 chars from bcrypt alphabet>
      expect(parts.length, equals(4));
      expect(parts[0], isEmpty);
      expect(parts[1], matches(RegExp(r'^2[aby]$')));
      expect(int.parse(parts[2]), inInclusiveRange(4, 31));
      expect(parts[3], matches(RegExp(r'^[./A-Za-z0-9]{53}$')));
      expect(hash.length, equals(60));
    });
  });
}
