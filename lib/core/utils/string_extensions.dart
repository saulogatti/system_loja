import 'package:bcrypt/bcrypt.dart';
import 'package:path/path.dart' as p;
import 'package:system_loja/core/constants/app_constants.dart';

/// Extensões para manipulação segura de strings em nomes de arquivos.
///
/// Fornece métodos para sanitizar, normalizar e validar strings
/// que serão usadas como nomes de arquivos, garantindo compatibilidade
/// entre diferentes sistemas operacionais.
extension FileNameStringExtensions on String {
  /// Nomes de arquivo reservados no Windows.
  static const Set<String> _reservedWindowsNames = {
    'CON',
    'PRN',
    'AUX',
    'NUL',
    'COM1',
    'COM2',
    'COM3',
    'COM4',
    'COM5',
    'COM6',
    'COM7',
    'COM8',
    'COM9',
    'LPT1',
    'LPT2',
    'LPT3',
    'LPT4',
    'LPT5',
    'LPT6',
    'LPT7',
    'LPT8',
    'LPT9',
  };

  /// Verifica se o nome do arquivo é reservado no Windows.
  ///
  /// Retorna `true` se o nome (sem extensão) for um dos nomes
  /// reservados do Windows (CON, PRN, AUX, NUL, COM1-9, LPT1-9).
  ///
  /// Exemplo:
  /// ```dart
  /// 'CON.txt'.isReservedFileName(); // true
  /// 'con.txt'.isReservedFileName(); // true
  /// 'arquivo.txt'.isReservedFileName(); // false
  /// ```
  bool isReservedFileName() {
    final nameUpper = p.basenameWithoutExtension(this).toUpperCase();
    return _reservedWindowsNames.contains(nameUpper);
  }

  /// Valida se a string é um nome de arquivo válido.
  ///
  /// Verifica:
  /// - String não vazia
  /// - Não contém caracteres proibidos
  /// - Não é nome reservado do Windows
  /// - Não excede comprimento máximo
  ///
  /// [maxLength] define o comprimento máximo permitido (padrão: 255).
  ///
  /// Retorna `true` se o nome for válido, `false` caso contrário.
  ///
  /// Exemplo:
  /// ```dart
  /// 'arquivo.txt'.isValidFileName(); // true
  /// 'arquivo<teste>.txt'.isValidFileName(); // false
  /// 'CON.txt'.isValidFileName(); // false
  /// ```
  bool isValidFileName({int maxLength = 255}) {
    if (isEmpty || length > maxLength) return false;
    if (isReservedFileName()) return false;
    if (contains(Constants.invalidFileNameCharsRegExp)) return false;

    return true;
  }

  /// Gera um nome de arquivo único adicionando timestamp.
  ///
  /// Adiciona os milissegundos desde epoch antes da extensão
  /// para garantir unicidade do nome.
  ///
  /// Exemplo:
  /// ```dart
  /// 'relatorio.pdf'.makeUniqueFileName(); // 'relatorio_1701979200000.pdf'
  /// ```
  String makeUniqueFileName() {
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final extension = p.extension(this);
    final name = p.basenameWithoutExtension(this);

    return '${name}_$timestamp$extension';
  }

  /// Normaliza o nome do arquivo convertendo para lowercase.
  ///
  /// Útil para garantir consistência entre sistemas case-sensitive
  /// (Linux/macOS) e case-insensitive (Windows).
  ///
  /// Exemplo:
  /// ```dart
  /// 'MinhaFoto.JPG'.normalizeFileName(); // 'minhafoto.jpg'
  /// ```
  String normalizeFileName() {
    return toLowerCase();
  }

  /// Sanitiza a string removendo caracteres inválidos para nomes de arquivo.
  ///
  /// Remove ou substitui:
  /// - Caracteres proibidos: `< > : " / \ | ? *`
  /// - Caracteres de controle (0x00-0x1F)
  /// - Espaços em branco (substituídos por underscore)
  /// - Underscores duplicados (consolidados em um único)
  /// - Espaços no início e fim
  ///
  /// Exemplo:
  /// ```dart
  /// 'Arquivo<teste>.txt'.sanitizeFileName(); // 'Arquivo_teste_.txt'
  /// 'Nome  com   espaços'.sanitizeFileName(); // 'Nome_com_espaços'
  /// ```
  String sanitizeFileName() {
    return toLowerCase()
        .replaceAll(Constants.invalidFileNameCharsRegExp, '_')
        .replaceAll(Constants.oneOrMoreWhitespaceRegExp, '_')
        .replaceAll(Constants.oneOrMoreUnderscoreRegExp, '_')
        .trim();
  }

  /// Converte caracteres acentuados para ASCII.
  ///
  /// Remove acentos e caracteres especiais comuns em português,
  /// substituindo-os por suas versões ASCII equivalentes.
  ///
  /// Exemplo:
  /// ```dart
  /// 'relatório_ção.txt'.toAsciiFileName(); // 'relatorio_cao.txt'
  /// 'José_García.pdf'.toAsciiFileName(); // 'Jose_Garcia.pdf'
  /// ```
  String toAsciiFileName() {
    return replaceAll(Constants.accentARegExp, 'a')
        .replaceAll(Constants.accentERegExp, 'e')
        .replaceAll(Constants.accentIRegExp, 'i')
        .replaceAll(Constants.accentORegExp, 'o')
        .replaceAll(Constants.accentURegExp, 'u')
        .replaceAll(Constants.cedillaRegExp, 'c')
        .replaceAll(Constants.tildeNRegExp, 'n')
        .replaceAll(Constants.yVariantsRegExp, 'y');
  }

  /// Aplica todas as proteções recomendadas para nomes de arquivo.
  ///
  /// Este método combina:
  /// 1. Sanitização de caracteres inválidos
  /// 2. Conversão para ASCII
  /// 3. Normalização para lowercase
  /// 4. Truncamento para comprimento máximo
  /// 5. Validação contra nomes reservados (adiciona sufixo se necessário)
  ///
  /// [maxLength] define o comprimento máximo do nome (padrão: 200).
  /// [addTimestamp] adiciona timestamp se for nome reservado (padrão: false).
  ///
  /// Exemplo:
  /// ```dart
  /// 'Relatório <Final>.txt'.toSafeFileName(); // 'relatorio_final_.txt'
  /// 'CON.txt'.toSafeFileName(); // 'con_file.txt'
  /// 'CON.txt'.toSafeFileName(addTimestamp: true); // 'con_1701979200000.txt'
  /// ```
  String toSafeFileName({int maxLength = 200, bool addTimestamp = false}) {
    String safeName = sanitizeFileName().toAsciiFileName().normalizeFileName().truncateFileName(
      maxLength: maxLength,
    );

    // Se for nome reservado, adiciona sufixo
    if (safeName.isReservedFileName()) {
      if (addTimestamp) {
        safeName = safeName.makeUniqueFileName();
      } else {
        final extension = p.extension(safeName);
        final name = p.basenameWithoutExtension(safeName);
        safeName = '${name}_file$extension';
      }
    }

    return safeName;
  }

  /// Trunca o nome do arquivo para o comprimento máximo especificado.
  ///
  /// Preserva a extensão do arquivo ao truncar. Se o nome for maior que
  /// [maxLength], o nome base é encurtado mantendo a extensão intacta.
  ///
  /// [maxLength] deve ser maior que o tamanho da extensão + 1.
  ///
  /// Exemplo:
  /// ```dart
  /// 'nome_muito_longo_para_arquivo.json'.truncateFileName(20);
  /// // 'nome_muito_long.json'
  /// ```
  String truncateFileName({int maxLength = 255}) {
    if (length <= maxLength) return this;

    final extension = p.extension(this);
    final nameWithoutExt = p.basenameWithoutExtension(this);

    if (extension.length >= maxLength) {
      // Se a extensão é maior que maxLength, apenas trunca tudo
      return substring(0, maxLength);
    }

    final availableLength = maxLength - extension.length;
    final truncated = nameWithoutExt.substring(0, availableLength);

    return '$truncated$extension';
  }
}

extension ValidateDataCustomer on String {
  static const int senhaMinLength = 8;

  /// Gera um hash seguro usando PBKDF2 com HMAC-SHA256.
  ///
  /// Retorna uma string no formato: `iterations$salt$hash` (todos em hexadecimal).
  String hashPassword() {
    return BCrypt.hashpw(this, BCrypt.gensalt());
  }

  /// Valida se a string é um CPF válido.
  ///
  /// Verifica o formato e os dígitos verificadores do CPF.
  ///
  /// Retorna `true` se o CPF for válido, `false` caso contrário.
  ///
  /// Exemplo:
  /// ```dart
  /// '123.456.789-09'.isValidCPF(); // true ou false
  /// ```
  bool isValidCpf() {
    final String cpf = replaceAll(Constants.nonNumericRegExp, '');

    if (cpf.length != 11 || Constants.cpfSameDigitRegExp.hasMatch(cpf)) {
      return false;
    }

    final List<int> digits = cpf.split('').map(int.parse).toList();

    for (int j = 9; j < 11; j++) {
      int sum = 0;
      for (int i = 0; i < j; i++) {
        sum += digits[i] * ((j + 1) - i);
      }
      int mod = (sum * 10) % 11;
      if (mod == 10) mod = 0;
      if (mod != digits[j]) {
        return false;
      }
    }
    return true;
  }

  /// Valuida se a string é um email válido.
  /// Verifica o formato básico de um email.
  ///  Retorna `true` se o email for válido, `false` caso contrário.
  ///  Exemplo:
  /// ```dart
  /// 'example@example.com'.isValidEmail(); // true ou false
  /// ```
  bool isValidEmail() {
    return Constants.emailRegExp.hasMatch(this);
  }

  /// Valida se a string é um número de telefone válido.
  /// Verifica o formato básico de um número de telefone.
  /// Retorna `true` se o telefone for válido, `false` caso contrário.
  /// Exemplo:
  /// ```dart
  /// '(11) 91234-5678'.isValidPhone(); // true ou false
  /// ```
  bool isValidPhone() {
    return Constants.phoneRegExp.hasMatch(this);
  }

  /// Valida a força da senha
  ///
  /// Retorna uma mensagem de erro se a senha for inválida, ou null se for válida.
  /// Regras: mínimo [senhaMinLength] caracteres, pelo menos uma letra maiúscula,
  /// uma letra minúscula e um número.
  String? validatePassword() {
    final String senha = this;
    if (senha.isEmpty) {
      return 'Senha é obrigatória';
    }
    if (senha.length < senhaMinLength) {
      return 'Senha deve ter no mínimo $senhaMinLength caracteres';
    }
    if (!senha.contains(Constants.uppercaseLetterRegExp)) {
      return 'Senha deve conter pelo menos uma letra maiúscula';
    }
    if (!senha.contains(Constants.lowercaseLetterRegExp)) {
      return 'Senha deve conter pelo menos uma letra minúscula';
    }
    if (!senha.contains(Constants.digitRegExp)) {
      return 'Senha deve conter pelo menos um número';
    }
    return null;
  }
}
