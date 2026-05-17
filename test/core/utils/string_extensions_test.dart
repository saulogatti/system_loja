import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/screens/utils/string_extensions.dart';

void main() {
  group('FileNameStringExtensions', () {
    test('isReservedFileName returns true for Windows reserved names', () {
      expect('CON'.isReservedFileName(), isTrue);
      expect('con'.isReservedFileName(), isTrue);
      expect('CON.txt'.isReservedFileName(), isTrue);
      expect('PRN'.isReservedFileName(), isTrue);
      expect('AUX'.isReservedFileName(), isTrue);
      expect('NUL'.isReservedFileName(), isTrue);
      expect('COM1.txt'.isReservedFileName(), isTrue);
      expect('COM9'.isReservedFileName(), isTrue);
      expect('LPT1'.isReservedFileName(), isTrue);
      expect('LPT9'.isReservedFileName(), isTrue);
    });

    test('isReservedFileName returns false for normal names', () {
      expect('arquivo.txt'.isReservedFileName(), isFalse);
      expect('CONTATO.txt'.isReservedFileName(), isFalse);
      expect('COM10.txt'.isReservedFileName(), isFalse);
      expect(''.isReservedFileName(), isFalse);
    });

    test('isValidFileName validates correctly', () {
      expect('arquivo.txt'.isValidFileName(), isTrue);
      expect(''.isValidFileName(), isFalse); // Empty
      expect(('a' * 256).isValidFileName(), isFalse); // Exceeds maxLength
      expect('CON.txt'.isValidFileName(), isFalse); // Reserved
      expect('arquivo<teste>.txt'.isValidFileName(), isFalse); // Invalid chars
    });

    test('makeUniqueFileName appends timestamp', () {
      final name = 'relatorio.pdf';
      final uniqueName = name.makeUniqueFileName();
      expect(uniqueName, startsWith('relatorio_'));
      expect(uniqueName, endsWith('.pdf'));
      // Extract timestamp part
      final timestampStr = uniqueName
          .replaceAll('relatorio_', '')
          .replaceAll('.pdf', '');
      expect(int.tryParse(timestampStr), isNotNull);
    });

    test('normalizeFileName converts to lowercase', () {
      expect('MinhaFoto.JPG'.normalizeFileName(), equals('minhafoto.jpg'));
    });

    test('sanitizeFileName removes invalid characters', () {
      expect(
        'Arquivo<teste>.txt'.sanitizeFileName(),
        equals('arquivo_teste_.txt'),
      );
      expect(
        'Nome  com   espaços'.sanitizeFileName(),
        equals('nome_com_espaços'),
      );
      expect('file:*?"<>|.txt'.sanitizeFileName(), equals('file_.txt'));
      expect(
        'leading and trailing spaces'.sanitizeFileName(),
        equals('leading_and_trailing_spaces'),
      );
    });

    test('toAsciiFileName converts accented characters', () {
      expect(
        'relatório_ção.txt'.toAsciiFileName(),
        equals('relatorio_cao.txt'),
      );
      expect('José_García.pdf'.toAsciiFileName(), equals('Jose_Garcia.pdf'));
      expect('ñ_ÿ.txt'.toAsciiFileName(), equals('n_y.txt'));
      expect(
        'ÀÁÂÃÄÅÈÉÊËÌÍÎÏÒÓÔÕÖÙÚÛÜ.txt'.toAsciiFileName(),
        equals('aaaaaaeeeeiiiiooooouuuu.txt'),
      );
    });

    test('toSafeFileName applies all transformations', () {
      expect('CON.txt'.toSafeFileName(), equals('con_file.txt'));
      final uniqueCon = 'CON.txt'.toSafeFileName(addTimestamp: true);
      expect(uniqueCon, startsWith('con_'));
      expect(uniqueCon, endsWith('.txt'));
    });

    test('truncateFileName shortens name preserving extension', () {
      expect(
        'nome_muito_longo.json'.truncateFileName(maxLength: 15),
        equals('nome_muito.json'),
      );
      expect('curto.txt'.truncateFileName(maxLength: 20), equals('curto.txt'));
      // When extension is longer or equal to maxLength
      expect(
        'arquivo.extensaolongademais'.truncateFileName(maxLength: 10),
        equals('arquivo.ex'),
      );
    });
  });

  group('ValidateDataCustomer', () {
    test('hashPassword generates BCrypt hash', () {
      final password = 'Password123';
      final hash = password.hashPassword();

      expect(hash, startsWith('\$2b\$'));
      expect(hash.length, equals(60));
      expect(password.verifyPassword(hash), isTrue);
    });

    test('verifyPassword does NOT support legacy SHA-256 hashes', () {
      // hash of "123456" is 8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92
      final oldHash =
          '8d969eef6ecad3c29a3a629280e686cf0c3f5d5a86aff3ca12020c923adc6c92';
      expect('123456'.verifyPassword(oldHash), isFalse);
    });

    test('verifyPassword supports BCrypt hashes', () {
      final password = 'SecurePassword123';
      final hash = password.hashPassword();

      expect(password.verifyPassword(hash), isTrue);
      expect('WrongPassword'.verifyPassword(hash), isFalse);
    });

    test('isValidCpf correctly validates CPF', () {
      // Valid CPF
      expect('00000000000'.isValidCpf(), isFalse); // All same digits
      expect('11111111111'.isValidCpf(), isFalse);
      expect(
        '123.456.289-09'.isValidCpf(),
        isFalse,
      ); // Fake but mathematically invalid usually

      // Known valid CPF mathematically (we can use a generated one or just a math one like 01234567890 if valid, let's use a standard test valid CPF)
      // 52998224725 is mathematically valid (common test CPF)
      expect('52998224725'.isValidCpf(), isTrue);
      expect('529.982.247-25'.isValidCpf(), isTrue);
      expect('123'.isValidCpf(), isFalse); // Too short
    });

    test('isValidEmail correctly validates emails', () {
      expect('example@example.com'.isValidEmail(), isTrue);
      expect('user.name_tag@domain.co.uk'.isValidEmail(), isTrue);
      expect('invalid-email'.isValidEmail(), isFalse);
      expect('@domain.com'.isValidEmail(), isFalse);
    });

    test('isValidPhone correctly validates phones', () {
      expect('(11) 91234-5678'.isValidPhone(), isTrue);
      expect('11912345678'.isValidPhone(), isTrue);
      expect('11 91234-5678'.isValidPhone(), isTrue);
      expect('123'.isValidPhone(), isFalse); // Too short
    });

    test('validatePassword validates password strength', () {
      expect(''.validatePassword(), equals('Senha é obrigatória'));
      expect(
        'curta'.validatePassword(),
        equals('Senha deve ter no mínimo 8 caracteres'),
      );
      expect(
        'semmaiuscula1'.validatePassword(),
        equals('Senha deve conter pelo menos uma letra maiúscula'),
      );
      expect(
        'SEM_MINUSCULA1'.validatePassword(),
        equals('Senha deve conter pelo menos uma letra minúscula'),
      );
      expect(
        'SemNumeroSenha'.validatePassword(),
        equals('Senha deve conter pelo menos um número'),
      );
      expect('SenhaForte123'.validatePassword(), isNull); // Valid
    });
  });
}
