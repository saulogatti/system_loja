import 'package:log_custom_printer/log_custom_printer.dart';
import 'package:system_loja/core/models/invoice.dart';
import 'package:system_loja/core/models/invoice_item.dart';
import 'package:system_loja/core/models/product.dart';
import 'package:system_loja/screens/injection/app_injection.dart';

/// Exemplos práticos de uso do CodeGeneratorService
///
/// Este arquivo demonstra diferentes cenários de uso do gerador de código
/// para produtos e notas fiscais.
class CodeGeneratorExamples with LoggerClassMixin {
  /// Exemplo 1: Criar produto com código gerado automaticamente
  Future<void> example1CreateProductWithAutoCode() async {
    final productRepository = AppInjection.instance.productRepository;

    // Gerar código automaticamente
    final code = await productRepository.generateProductCode();
    logDebug('Código gerado: $code'); // Exemplo: PRD-20260123-0001

    // Criar produto com o código gerado
    final product = Product(
      name: 'Notebook Dell Inspiron 15',
      description: 'Notebook Dell com 16GB RAM e SSD 512GB',
      price: 3500.00,
      stockQuantity: 10,
      category: 'Eletrônicos',
      code: code,
    );

    // Salvar no banco
    final result = await productRepository.salvarProduto(product);
    if (result.isSuccessful) {
      logInfo('Produto salvo com sucesso!');
    }
  }

  /// Exemplo 2: Criar produto com código personalizado
  Future<void> example2CreateProductWithCustomCode() async {
    final productRepository = AppInjection.instance.productRepository;

    // Código fornecido pelo usuário
    final customCode = 'NOTEBOOK-DELL-001';

    // Validar código personalizado
    final validation = await productRepository.validateProductCode(customCode);

    if (validation.isSuccessful) {
      // Código válido - pode usar
      final product = Product(
        name: 'Notebook Dell Inspiron 15',
        description: 'Notebook Dell com 16GB RAM e SSD 512GB',
        price: 3500.00,
        stockQuantity: 10,
        category: 'Eletrônicos',
        code: customCode,
      );

      await productRepository.salvarProduto(product);
      logInfo('Produto salvo com código personalizado: $customCode');
    } else {
      // Código inválido - mostrar erro
      logWarning('Erro ao validar código: ${validation.asError}');
      // Possíveis erros:
      // - "Código não pode ser vazio"
      // - "Código deve ter no mínimo 3 caracteres"
      // - "Código deve ter no máximo 50 caracteres"
      // - "Código já existe no banco de dados"
    }
  }

  /// Exemplo 3: Criar produto com validação e fallback para código automático
  Future<void> example3CreateProductWithValidationFallback() async {
    final productRepository = AppInjection.instance.productRepository;

    // Código fornecido pelo usuário
    final String userProvidedCode = 'MOUSE-001'; // Pode vir de um TextField

    String finalCode;

    if (userProvidedCode.isNotEmpty) {
      // Usuário forneceu código - validar
      final validation = await productRepository.validateProductCode(
        userProvidedCode,
      );

      if (validation.isSuccessful) {
        finalCode = userProvidedCode;
        logInfo('Usando código personalizado: $finalCode');
      } else {
        // Código inválido - usar código automático como fallback
        logWarning('Código personalizado inválido, gerando automaticamente...');
        finalCode = await productRepository.generateProductCode();
        logInfo('Código automático gerado: $finalCode');
      }
    } else {
      // Usuário não forneceu código - gerar automaticamente
      finalCode = await productRepository.generateProductCode();
      logInfo('Código gerado automaticamente: $finalCode');
    }

    // Criar e salvar produto
    final product = Product(
      name: 'Mouse Logitech',
      description: 'Mouse sem fio Logitech MX Master 3',
      price: 450.00,
      stockQuantity: 25,
      category: 'Periféricos',
      code: finalCode,
    );

    await productRepository.salvarProduto(product);
    logInfo('Produto salvo com código: $finalCode');
  }

  /// Exemplo 4: Criar nota fiscal com número gerado automaticamente
  Future<void> example4CreateInvoiceWithAutoNumber() async {
    final salesRepository = AppInjection.instance.salesRepository;

    // Gerar número de nota automaticamente
    final invoiceNumber = await salesRepository.generateInvoiceNumber();
    logInfo(
      'Número de nota gerado: $invoiceNumber',
    ); // Exemplo: NF-20260123-0001

    // Criar nota fiscal com o número gerado
    final invoice = Invoice(
      // Será gerado pelo banco
      data: InvoiceData(
        invoiceNumber: invoiceNumber,
        customerId: 1,
        customerName: 'João Silva',
        customerCpf: '12345678900',
        items: [
          InvoiceItem(
            productId: -1,
            productCode: 'PRD-20260123-0001',
            productName: 'Notebook Dell Inspiron 15',
            quantity: 1,
            unitPrice: 3500.00,
          ),
          InvoiceItem(
            productId: -1,
            productCode: 'MOUSE-001',
            productName: 'Mouse Logitech MX Master 3',
            quantity: 2,
            unitPrice: 450.00,
          ),
        ],
        paymentMethod: 'Cartão de Crédito',
      ),
    );

    // Salvar nota fiscal
    await salesRepository.saveSale(invoice);
    logInfo('Nota fiscal salva com sucesso!');
  }

  /// Exemplo 5: Criar nota fiscal com número personalizado
  Future<void> example5CreateInvoiceWithCustomNumber() async {
    final salesRepository = AppInjection.instance.salesRepository;

    // Número fornecido pelo usuário
    final customNumber = 'NF-VENDA-ESPECIAL-001';

    // Validar número personalizado
    final validation = await salesRepository.validateInvoiceNumber(
      customNumber,
    );

    if (validation.isValid) {
      // Número válido - pode usar
      final invoice = Invoice(
        id: -1,
        data: InvoiceData(
          invoiceNumber: customNumber,
          customerId: 2,
          customerName: 'Maria Santos',
          customerCpf: '98765432100',
          items: [
            InvoiceItem(
              productId: -1,
              productCode: 'PRD-20260123-0001',
              productName: 'Notebook Dell Inspiron 15',
              quantity: 1,
              unitPrice: 3500.00,
            ),
          ],
          paymentMethod: 'Pix',
        ),
      );

      await salesRepository.saveSale(invoice);
      logInfo('Nota fiscal salva com número personalizado: $customNumber');
    } else {
      // Número inválido - mostrar erro
      logWarning('Erro ao validar número: ${validation.message}');
    }
  }

  /// Exemplo 6: Verificar se um código já existe antes de usar
  Future<void> example6CheckCodeExistence() async {
    final codeGenerator = AppInjection.instance.codeGeneratorService;

    // Código a ser verificado
    final codeToCheck = 'PRD-20260123-0001';

    // Verificar se existe
    final exists = await codeGenerator.checkProductCodeExists(codeToCheck);

    if (exists) {
      logWarning('Código $codeToCheck já existe no banco de dados');
      // Sugerir código automático
      final newCode = await codeGenerator.generateProductCode();
      logInfo('Sugestão de código disponível: $newCode');
    } else {
      logInfo('Código $codeToCheck está disponível');
    }
  }

  /// Exemplo 7: Gerar múltiplos códigos em lote
  Future<void> example7GenerateMultipleCodes() async {
    final productRepository = AppInjection.instance.productRepository;

    logInfo('Gerando 5 códigos de produto...');

    for (int i = 0; i < 5; i++) {
      final code = await productRepository.generateProductCode();
      logInfo('Código ${i + 1}: $code');
      // Criar produto para ocupar o código
      final product = Product(
        name: 'Produto $i',
        description: 'Descrição do produto $i',
        price: 100.0 + (i * 50),
        stockQuantity: 10,
        category: 'Teste',
        code: code,
      );

      await productRepository.salvarProduto(product);
    }

    logInfo('5 produtos criados com códigos únicos!');
  }

  /// Exemplo 8: Tratamento completo com try-catch
  Future<void> example8CompleteErrorHandling() async {
    final productRepository = AppInjection.instance.productRepository;

    try {
      // Tentar usar código fornecido pelo usuário
      final userCode = 'CUSTOM-PRODUCT-001';
      final validation = await productRepository.validateProductCode(userCode);

      String finalCode;

      if (validation.isSuccessful) {
        finalCode = userCode;
      } else {
        // Fallback para código automático
        finalCode = await productRepository.generateProductCode();
        logWarning(
          'Aviso: Usando código automático ($finalCode) porque: ${validation.asError}',
        );
      }

      // Criar produto
      final product = Product(
        name: 'Produto Exemplo',
        description: 'Descrição exemplo',
        price: 299.99,
        stockQuantity: 15,
        category: 'Diversos',
        code: finalCode,
      );

      // Salvar produto
      final result = await productRepository.salvarProduto(product);

      if (result.isSuccessful) {
        logInfo('✅ Produto salvo com sucesso com código: $finalCode');
      } else {
        logWarning('❌ Erro ao salvar produto: ${result.asError}');
      }
    } catch (e, stack) {
      logError('❌ Erro inesperado: $e', stack);
    }
  }
}

/// Exemplo de uso em um Widget Flutter
///
/// ```dart
/// class ProductFormWidget extends StatefulWidget {
///   @override
///   _ProductFormWidgetState createState() => _ProductFormWidgetState();
/// }
///
/// class _ProductFormWidgetState extends State<ProductFormWidget> {
///   final _codeController = TextEditingController();
///   bool _useAutoCode = true;
///   
///   @override
///   void initState() {
///     super.initState();
///     if (_useAutoCode) {
///       _generateCode();
///     }
///   }
///   
///   Future<void> _generateCode() async {
///     final repository = AppInjection.instance.productRepository;
///     final code = await repository.generateProductCode();
///     setState(() {
///       _codeController.text = code;
///     });
///   }
///   
///   @override
///   Widget build(BuildContext context) {
///     return Column(
///       children: [
///         SwitchListTile(
///           title: Text('Gerar código automaticamente'),
///           value: _useAutoCode,
///           onChanged: (value) {
///             setState(() {
///               _useAutoCode = value;
///               if (value) _generateCode();
///             });
///           },
///         ),
///         TextField(
///           controller: _codeController,
///           enabled: !_useAutoCode,
///           decoration: InputDecoration(
///             labelText: 'Código do Produto',
///             suffixIcon: !_useAutoCode 
///               ? IconButton(
///                   icon: Icon(Icons.refresh),
///                   onPressed: _generateCode,
///                 )
///               : null,
///           ),
///         ),
///       ],
///     );
///   }
/// }
/// ```
