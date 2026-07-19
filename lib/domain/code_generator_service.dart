import 'package:system_loja/data/database/dao/invoice_dao.dart';
import 'package:system_loja/data/database/dao/product_dao.dart';

/// Serviço para geração de códigos únicos para produtos e notas fiscais.
///
/// Este serviço fornece métodos para gerar códigos automáticos sequenciais
/// ou validar códigos fornecidos pelo usuário, garantindo unicidade no banco.
class CodeGeneratorService {

  CodeGeneratorService({required ProductDao productDao, required InvoiceDao invoiceDao})
    : _productDao = productDao,
      _invoiceDao = invoiceDao;
  final ProductDao _productDao;
  final InvoiceDao _invoiceDao;

  /// Verifica se um número de nota fiscal já existe no banco de dados.
  ///
  /// [invoiceNumber] Número da nota fiscal a ser verificado.
  /// Retorna true se o número já existe, false caso contrário.
  Future<bool> checkInvoiceNumberExists(String invoiceNumber) async {
    final invoice = await _invoiceDao.getByInvoiceNumber(invoiceNumber);
    return invoice != null;
  }

  /// Verifica se um código de produto já existe no banco de dados.
  ///
  /// [code] Código do produto a ser verificado.
  /// Retorna true se o código já existe, false caso contrário.
  Future<bool> checkProductCodeExists(String code) async {
    final product = await _productDao.getByCode(code);
    return product != null;
  }

  /// Gera um número único para nota fiscal baseado no timestamp e contador.
  ///
  /// Formato: NF-YYYYMMDD-NNNN
  /// Exemplo: NF-20260123-0001
  ///
  /// Verifica se o número já existe no banco antes de retornar.
  /// Se existir, incrementa o contador até encontrar um número disponível.
  Future<String> generateInvoiceNumber() async {
    final now = DateTime.now();
    final datePrefix = 'NF-${now.year}${_padLeft(now.month)}${_padLeft(now.day)}';

    var counter = 1;
    String invoiceNumber;

    do {
      invoiceNumber = '$datePrefix-${_padLeft(counter, 4)}';
      final exists = await checkInvoiceNumberExists(invoiceNumber);
      if (!exists) {
        return invoiceNumber;
      }
      counter++;
    } while (counter < 10000); // Limite de segurança

    // Se atingir o limite, adiciona timestamp em milissegundos
    return '$datePrefix-${now.millisecondsSinceEpoch % 10000}';
  }

  /// Gera um código único para produto baseado no timestamp e contador.
  ///
  /// Formato: PRD-YYYYMMDD-NNNN
  /// Exemplo: PRD-20260123-0001
  ///
  /// Verifica se o código já existe no banco antes de retornar.
  /// Se existir, incrementa o contador até encontrar um código disponível.
  Future<String> generateProductCode() async {
    final now = DateTime.now();
    final datePrefix = 'PRD-${now.year}${_padLeft(now.month)}${_padLeft(now.day)}';

    var counter = 1;
    String code;

    do {
      code = '$datePrefix-${_padLeft(counter, 4)}';
      final exists = await checkProductCodeExists(code);
      if (!exists) {
        return code;
      }
      counter++;
    } while (counter < 10000); // Limite de segurança

    // Se atingir o limite, adiciona timestamp em milissegundos
    return '$datePrefix-${now.millisecondsSinceEpoch % 10000}';
  }

  /// Valida um número de nota fiscal fornecido pelo usuário.
  ///
  /// [invoiceNumber] Número fornecido pelo usuário.
  /// Retorna um [CodeValidationResult] com o status da validação.
  ///
  /// Regras de validação:
  /// - Não pode ser vazio
  /// - Deve ter entre 3 e 50 caracteres
  /// - Não pode já existir no banco de dados
  Future<CodeValidationResult> validateInvoiceNumber(String invoiceNumber) async {
    // Verifica se está vazio
    if (invoiceNumber.trim().isEmpty) {
      return CodeValidationResult(isValid: false, message: 'Número da nota não pode ser vazio');
    }

    // Verifica tamanho
    if (invoiceNumber.length < 3) {
      return CodeValidationResult(
        isValid: false,
        message: 'Número da nota deve ter no mínimo 3 caracteres',
      );
    }

    if (invoiceNumber.length > 50) {
      return CodeValidationResult(
        isValid: false,
        message: 'Número da nota deve ter no máximo 50 caracteres',
      );
    }

    // Verifica se já existe
    final exists = await checkInvoiceNumberExists(invoiceNumber);
    if (exists) {
      return CodeValidationResult(
        isValid: false,
        message: 'Número da nota já existe no banco de dados',
      );
    }

    return CodeValidationResult(isValid: true, message: 'Número da nota válido');
  }

  /// Valida um código de produto fornecido pelo usuário.
  ///
  /// [code] Código fornecido pelo usuário.
  /// Retorna um [CodeValidationResult] com o status da validação.
  ///
  /// Regras de validação:
  /// - Não pode ser vazio
  /// - Deve ter entre 3 e 50 caracteres
  /// - Não pode já existir no banco de dados
  Future<CodeValidationResult> validateProductCode(String code) async {
    // Verifica se está vazio
    if (code.trim().isEmpty) {
      return CodeValidationResult(isValid: false, message: 'Código não pode ser vazio');
    }

    // Verifica tamanho
    if (code.length < 3) {
      return CodeValidationResult(
        isValid: false,
        message: 'Código deve ter no mínimo 3 caracteres',
      );
    }

    if (code.length > 50) {
      return CodeValidationResult(
        isValid: false,
        message: 'Código deve ter no máximo 50 caracteres',
      );
    }

    // Verifica se já existe
    final exists = await checkProductCodeExists(code);
    if (exists) {
      return CodeValidationResult(isValid: false, message: 'Código já existe no banco de dados');
    }

    return CodeValidationResult(isValid: true, message: 'Código válido');
  }

  /// Método auxiliar para adicionar zeros à esquerda.
  String _padLeft(int value, [int width = 2]) => value.toString().padLeft(width, '0');
}

/// Resultado da validação de código.
class CodeValidationResult {

  CodeValidationResult({required this.isValid, required this.message});
  /// Indica se o código é válido.
  final bool isValid;

  /// Mensagem descritiva do resultado da validação.
  final String message;
}
