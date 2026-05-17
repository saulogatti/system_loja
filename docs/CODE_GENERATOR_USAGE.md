# Gerador de Código - Documentação de Uso

## Visão Geral

O `CodeGeneratorService` é um serviço que fornece geração automática de códigos únicos para produtos e notas fiscais no System Loja. Ele garante que códigos não sejam duplicados e permite que usuários forneçam seus próprios códigos personalizados após validação.

## Características

- ✅ Geração automática de códigos únicos para produtos
- ✅ Geração automática de números únicos para notas fiscais
- ✅ Validação de códigos personalizados fornecidos pelo usuário
- ✅ Verificação de duplicatas no banco de dados
- ✅ Formato padronizado e legível
- ✅ Integração com Drift ORM

## Formatos de Código

### Produtos
**Formato**: `PRD-YYYYMMDD-NNNN`

**Exemplos**:
- `PRD-20260123-0001` - Primeiro produto do dia 23/01/2026
- `PRD-20260123-0002` - Segundo produto do dia 23/01/2026

### Notas Fiscais
**Formato**: `NF-YYYYMMDD-NNNN`

**Exemplos**:
- `NF-20260123-0001` - Primeira nota fiscal do dia 23/01/2026
- `NF-20260123-0002` - Segunda nota fiscal do dia 23/01/2026

## Como Usar

### 1. Acessar o Serviço

O serviço está registrado no **GetIt** (`appInjection`) após `setupAppInjection()` e pode ser acessado de várias formas:

#### Opção A: Diretamente via GetIt
```dart
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/domain/code_generator_service.dart';

final codeGenerator = appInjection.get<CodeGeneratorService>();
```

#### Opção B: Via ProductRepository
```dart
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';

final productRepository = appInjection.get<IProductRepository>();

// Gerar código
final code = await productRepository.generateProductCode();

// Validar código customizado
final validationResult = await productRepository.validateProductCode('MEU-CODIGO-001');
```

#### Opção C: Via SalesRepository
```dart
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_sales_repository.dart';

final salesRepository = appInjection.get<ISalesRepository>();

// Gerar número de nota
final invoiceNumber = await salesRepository.generateInvoiceNumber();

// Validar número customizado
final validationResult = await salesRepository.validateInvoiceNumber('NF-CUSTOM-001');
```

### 2. Gerar Código de Produto Automaticamente

```dart
import 'package:system_loja/aplication/app_injection.dart';
import 'package:system_loja/core/interface/i_product_repository.dart';

// Via repositório (recomendado)
final productRepository = appInjection.get<IProductRepository>();
final code = await productRepository.generateProductCode();

// Criar produto com o código gerado
final product = Product(
  name: 'Notebook Dell',
  description: 'Notebook Dell Inspiron 15',
  price: 3500.00,
  stockQuantity: 10,
  category: 'Eletrônicos',
  code: code, // Usar o código gerado
);

await productRepository.salvarProduto(product);
```

### 3. Usar Código Personalizado para Produto

```dart
final productRepository = appInjection.get<IProductRepository>();

// Código fornecido pelo usuário
final customCode = 'NOTEBOOK-DELL-001';

// Validar o código antes de usar
final validation = await productRepository.validateProductCode(customCode);

if (validation.isSuccessful) {
  // Código válido, pode usar
  final product = Product(
    name: 'Notebook Dell',
    description: 'Notebook Dell Inspiron 15',
    price: 3500.00,
    stockQuantity: 10,
    category: 'Eletrônicos',
    code: customCode,
  );
  
  await productRepository.salvarProduto(product);
} else {
  // Código inválido, mostrar erro ao usuário
  print('Erro: ${validation.asError}');
  // Exemplo: "Código já existe no banco de dados"
}
```

### 4. Gerar Número de Nota Fiscal Automaticamente

```dart
final salesRepository = appInjection.get<ISalesRepository>();

// Gerar número de nota automaticamente
final invoiceNumber = await salesRepository.generateInvoiceNumber();

// Criar nota fiscal com o número gerado
final invoice = Invoice(
  id: -1,
  data: InvoiceData(
    invoiceNumber: invoiceNumber, // Usar o número gerado
    customerId: 1,
    customerName: 'João Silva',
    customerCpf: '12345678900',
    items: [
      InvoiceItem(
        productCode: 'PRD-20260123-0001',
        productName: 'Notebook Dell',
        quantity: 1,
        unitPrice: 3500.00,
      ),
    ],
    paymentMethod: 'Cartão de Crédito',
  ),
);

await salesRepository.saveSale(invoice);
```

### 5. Usar Número Personalizado para Nota Fiscal

```dart
final salesRepository = appInjection.get<ISalesRepository>();

// Número fornecido pelo usuário
final customNumber = 'NF-VENDA-ESPECIAL-001';

// Validar o número antes de usar
final validation = await salesRepository.validateInvoiceNumber(customNumber);

if (validation.isValid) {
  // Número válido, pode usar
  final invoice = Invoice(
    id: -1,
    data: InvoiceData(
      invoiceNumber: customNumber,
      customerId: 1,
      customerName: 'João Silva',
      customerCpf: '12345678900',
      items: [
        InvoiceItem(
          productCode: 'PRD-20260123-0001',
          productName: 'Notebook Dell',
          quantity: 1,
          unitPrice: 3500.00,
        ),
      ],
      paymentMethod: 'Cartão de Crédito',
    ),
  );
  
  await salesRepository.saveSale(invoice);
} else {
  // Número inválido, mostrar erro ao usuário
  print('Erro: ${validation.message}');
  // Exemplo: "Número da nota já existe no banco de dados"
}
```

## Integração com Interface de Usuário (UI)

### Exemplo: Tela de Cadastro de Produto

```dart
class ProductRegistrationScreen extends StatefulWidget {
  @override
  _ProductRegistrationScreenState createState() => 
      _ProductRegistrationScreenState();
}

class _ProductRegistrationScreenState extends State<ProductRegistrationScreen> {
  final _codeController = TextEditingController();
  final _productRepository = appInjection.get<IProductRepository>();
  bool _useAutoCode = true;
  
  Future<void> _generateCode() async {
    final code = await _productRepository.generateProductCode();
    setState(() {
      _codeController.text = code;
    });
  }
  
  Future<void> _saveProduct() async {
    String code;
    
    if (_useAutoCode) {
      // Usar código gerado automaticamente
      code = await _productRepository.generateProductCode();
    } else {
      // Validar código fornecido pelo usuário
      final validation = await _productRepository.validateProductCode(
        _codeController.text,
      );
      
      if (!validation.isSuccessful) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erro: ${validation.asError}')),
        );
        return;
      }
      
      code = _codeController.text;
    }
    
    // Criar e salvar produto com o código validado
    final product = Product(
      name: _nameController.text,
      description: _descriptionController.text,
      price: double.parse(_priceController.text),
      stockQuantity: int.parse(_stockController.text),
      category: _categoryController.text,
      code: code,
    );
    
    await _productRepository.salvarProduto(product);
    
    // Mostrar sucesso
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Produto salvo com sucesso!')),
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Cadastrar Produto')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            // Toggle para escolher entre código automático ou manual
            SwitchListTile(
              title: Text('Gerar código automaticamente'),
              value: _useAutoCode,
              onChanged: (value) {
                setState(() {
                  _useAutoCode = value;
                  if (value) {
                    _generateCode();
                  } else {
                    _codeController.clear();
                  }
                });
              },
            ),
            
            // Campo de código (desabilitado se auto)
            TextField(
              controller: _codeController,
              enabled: !_useAutoCode,
              decoration: InputDecoration(
                labelText: 'Código do Produto',
                suffixIcon: _useAutoCode 
                  ? Icon(Icons.lock)
                  : IconButton(
                      icon: Icon(Icons.refresh),
                      onPressed: _generateCode,
                    ),
              ),
            ),
            
            // ... outros campos ...
            
            ElevatedButton(
              onPressed: _saveProduct,
              child: Text('Salvar Produto'),
            ),
          ],
        ),
      ),
    );
  }
}
```

## Regras de Validação

### Códigos de Produto

- ✅ **Mínimo**: 3 caracteres
- ✅ **Máximo**: 50 caracteres
- ✅ **Não pode ser vazio**
- ✅ **Deve ser único** no banco de dados

### Números de Nota Fiscal

- ✅ **Mínimo**: 3 caracteres
- ✅ **Máximo**: 50 caracteres
- ✅ **Não pode ser vazio**
- ✅ **Deve ser único** no banco de dados

## Mensagens de Erro

### Validação de Código de Produto

| Situação | Mensagem |
|----------|----------|
| Código vazio | "Código não pode ser vazio" |
| Código muito curto | "Código deve ter no mínimo 3 caracteres" |
| Código muito longo | "Código deve ter no máximo 50 caracteres" |
| Código duplicado | "Código já existe no banco de dados" |
| Código válido | "Código válido" |

### Validação de Número de Nota Fiscal

| Situação | Mensagem |
|----------|----------|
| Número vazio | "Número da nota não pode ser vazio" |
| Número muito curto | "Número da nota deve ter no mínimo 3 caracteres" |
| Número muito longo | "Número da nota deve ter no máximo 50 caracteres" |
| Número duplicado | "Número da nota já existe no banco de dados" |
| Número válido | "Número da nota válido" |

## Tratamento de Colisões

O serviço implementa um mecanismo automático de resolução de colisões:

1. **Tentativa incremental**: Se um código já existe, incrementa o contador (0001 → 0002 → 0003...)
2. **Limite de segurança**: Após 9999 tentativas, adiciona timestamp em milissegundos
3. **Verificação no banco**: Cada código é verificado no banco antes de ser retornado

## Testes

O serviço possui cobertura completa de testes unitários em `test/code_generator_service_test.dart`:

- ✅ Geração de códigos de produto
- ✅ Geração de números de nota fiscal
- ✅ Validação de códigos personalizados
- ✅ Verificação de duplicatas
- ✅ Tratamento de colisões
- ✅ Mensagens de erro adequadas

Para executar os testes:

```bash
flutter test test/code_generator_service_test.dart
```

## Migração de Código Legado

Se você tem produtos ou notas fiscais com códigos no formato antigo, eles continuarão funcionando normalmente. O serviço apenas garante que novos códigos sejam únicos, independentemente do formato.

## Performance

- **Geração de código**: O(n) onde n é o número de colisões (raramente > 1)
- **Validação**: O(1) - Uma única query no banco
- **Verificação de duplicata**: O(1) - Query indexada no banco

A coluna `code` em `ProductsRecords` possui constraint `UNIQUE`, garantindo integridade no nível do banco de dados.

## Suporte

Para dúvidas ou problemas, consulte:
- Código fonte: `lib/domain/code_generator_service.dart`
- DI: `lib/aplication/app_injection.dart`
- Testes: `test/code_generator_service_test.dart`
- Repositórios: `lib/domain/repository/product_repository.dart` e `lib/domain/repository/sales_repository.dart`
