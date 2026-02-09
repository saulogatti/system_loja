const String kStringGenerate = 'Será gerado automaticamente';

/// Constantes de RegExp reutilizáveis no app.
abstract final class Constants {
  /// Remove caracteres não numéricos (ex.: CNPJ, CPF, CEP).
  static final RegExp nonNumericRegExp = RegExp(r'[^0-9]');

  /// Permite apenas dígitos e ponto (valores decimais).
  static final RegExp decimalAllowedRegExp = RegExp(r'[^0-9.]');

  /// Permite apenas dígitos, vírgula e ponto (preço).
  static final RegExp priceAllowedRegExp = RegExp(r'[^0-9,.]');

  /// Caracteres inválidos em nomes de arquivo (Windows/FS).
  static final RegExp invalidFileNameCharsRegExp = RegExp(
    r'[<>:"/\\|?*\x00-\x1F]',
  );

  /// Um ou mais espaços em branco.
  static final RegExp oneOrMoreWhitespaceRegExp = RegExp(r'\s+');

  /// Um ou mais underscores.
  static final RegExp oneOrMoreUnderscoreRegExp = RegExp(r'_+');

  /// Acentuação em 'a' (àáâãäå etc.) para normalização de nome de arquivo.
  static final RegExp accentARegExp = RegExp(r'[àáâãäåÀÁÂÃÄÅ]');

  static final RegExp accentERegExp = RegExp(r'[èéêëÈÉÊË]');
  static final RegExp accentIRegExp = RegExp(r'[ìíîïÌÍÎÏ]');
  static final RegExp accentORegExp = RegExp(r'[òóôõöÒÓÔÕÖ]');
  static final RegExp accentURegExp = RegExp(r'[ùúûüÙÚÛÜ]');
  static final RegExp cedillaRegExp = RegExp(r'[çÇ]');
  static final RegExp tildeNRegExp = RegExp(r'[ñÑ]');
  static final RegExp yVariantsRegExp = RegExp(r'[ýÿÝŸ]');

  /// CPF com todos os dígitos iguais (inválido).
  static final RegExp cpfSameDigitRegExp = RegExp(r'^(\d)\1*$');

  /// Formato básico de e-mail.
  static final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

  /// Formato básico de telefone BR.
  static final RegExp phoneRegExp = RegExp(
    r'^\(?\d{2}\)?[\s-]?[\d\s-]{4,5}[\s-]?\d{4}$',
  );

  /// Pelo menos uma letra maiúscula (validação de senha).
  static final RegExp uppercaseLetterRegExp = RegExp(r'[A-Z]');

  /// Pelo menos uma letra minúscula (validação de senha).
  static final RegExp lowercaseLetterRegExp = RegExp(r'[a-z]');

  /// Pelo menos um dígito (validação de senha).
  static final RegExp digitRegExp = RegExp(r'[0-9]');

  /// Código de produto: apenas letras, números e hífen.
  static final RegExp productCodeValidRegExp = RegExp(r'^[a-zA-Z0-9\-]+$');

  /// Remove tudo que não é letra, número ou hífen (formatação de código).
  static final RegExp productCodeReplaceRegExp = RegExp(r'[^a-zA-Z0-9\-]');
  Constants._();
}
