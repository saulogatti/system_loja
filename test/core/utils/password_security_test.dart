import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/utils/string_extensions.dart';
import 'dart:convert';
import 'package:crypto/crypto.dart';

void main() {
  group('Password Security Tests', () {
    test('hashSenha generates different hashes for the same password (salt)', () {
      const password = 'Password123';
      final hash1 = password.hashSenha();
      final hash2 = password.hashSenha();

      expect(hash1, isNot(equals(hash2)));
      expect(hash1.split('$').length, equals(3));
    });

    test('verifySenha validates correctly with new PBKDF2 format', () {
      const password = 'StrongPassword!1';
      final hash = password.hashSenha();

      expect(password.verifySenha(hash), isTrue);
      expect('WrongPassword'.verifySenha(hash), isFalse);
    });

    test('verifySenha maintains backward compatibility with legacy SHA-256', () {
      const password = 'LegacyPassword';
      // Manual SHA-256 hash of 'LegacyPassword'
      final bytes = utf8.encode(password);
      final legacyHash = sha256.convert(bytes).toString();

      expect(password.verifySenha(legacyHash), isTrue);
      expect('WrongPassword'.verifySenha(legacyHash), isFalse);
    });

    test('hashSenha output matches expected format', () {
      const password = 'TestFormat1';
      final hash = password.hashSenha();
      final parts = hash.split('$');

      expect(parts.length, equals(3));
      // Salt and hash should be valid base64
      expect(base64.decode(parts[1]), isA<List<int>>());
      expect(base64.decode(parts[2]), isA<List<int>>());
    });
  });
}
