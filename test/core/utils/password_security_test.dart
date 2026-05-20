import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/utils/string_extensions.dart';

void main() {
  group('Password Security Tests', () {
    test('hashSenha generates different hashes for the same password (salt)', () {
      const password = 'Password123';
      final hash1 = password.hashPassword();
      final hash2 = password.hashPassword();

      expect(hash1, isNot(equals(hash2)));
      expect(hash1.split('\$').length, equals(3));
    });

    test('validatePassword validates correctly with new PBKDF2 format', () {
      const password = 'StrongPassword!1';

      expect(password.validatePassword(), isNull);
      expect('WrongPassword'.validatePassword(), isNotNull);
    });

    test('hashPassword output matches expected format', () {
      const password = 'TestFormat1';
      final hash = password.hashPassword();
      final parts = hash.split('\$');

      expect(parts.length, equals(3));
      // Salt and hash should be valid base64
      expect(base64.decode(parts[1]), isA<List<int>>());
      expect(base64.decode(parts[2]), isA<List<int>>());
    });
  });
}
