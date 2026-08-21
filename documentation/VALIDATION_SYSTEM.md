# Sistema de Validação e Formatação

Este documento descreve o sistema de validação de campos e formatação de entrada implementado no System Loja.

## Visão Geral

O sistema fornece validadores reutilizáveis e formatadores de entrada para garantir que os dados inseridos pelos usuários sejam válidos e consistentes. Isso melhora a experiência do usuário e a integridade dos dados.

## Componentes

### 1. Validadores (`lib/core/utils/validators.dart`)

Os validadores são funções que retornam `null` se o valor for válido, ou uma mensagem de erro caso contrário.

#### Validadores Disponíveis

##### `validatePrice(String? value)`
Valida preços monetários.

**Regras:**
- Não pode ser vazio
- Deve ser um número válido
- Não pode ser negativo
- Máximo de 2 casas decimais
- Aceita vírgula ou ponto como separador decimal

**Exemplo:**
```dart
TextFormField(
  validator: validatePrice,
  // ...
)
```

**Valores Aceitos:**
- `10.50` ✅
- `10,50` ✅
- `0` ✅
- `100` ✅

**Valores Rejeitados:**
- `-10.50` ❌ (negativo)
- `abc` ❌ (não numérico)
- `10.505` ❌ (mais de 2 decimais)

##### `validateQuantity(String? value)`
Valida quantidades e contagens.

**Regras:**
- Não pode ser vazio
- Deve ser um número inteiro válido
- Não pode ser negativo

**Exemplo:**
```dart
TextFormField(
  validator: validateQuantity,
  // ...
)
```

##### `validateStock(String? value)`
Valida valores de estoque (idêntico a `validateQuantity`).

**Exemplo:**
```dart
TextFormField(
  validator: validateStock,
  // ...
)
```

##### `validateProductCode(String? value)`
Valida códigos de produto.

**Regras:**
- Não pode ser vazio
- Mínimo de 3 caracteres
- Máximo de 20 caracteres
- Apenas letras, números e hífens

**Exemplo:**
```dart
TextFormField(
  validator: validateProductCode,
  // ...
)
```

**Valores Aceitos:**
- `ABC-123` ✅
- `PROD001` ✅
- `12345` ✅

**Valores Rejeitados:**
- `AB` ❌ (muito curto)
- `ABC@123` ❌ (caractere inválido)
- `ABC_123` ❌ (underscore não permitido)

##### `validateRequired(String? value, String fieldName)`
Valida campos obrigatórios.

**Exemplo:**
```dart
TextFormField(
  validator: (value) => validateRequired(value, 'Nome'),
  // ...
)
```

##### `validateMinLength(String? value, int minLength, String fieldName)`
Valida comprimento mínimo.

**Exemplo:**
```dart
TextFormField(
  validator: (value) => validateMinLength(value, 3, 'Nome'),
  // ...
)
```

##### `combineValidators(List<String? Function(String?)> validators)`
Combina múltiplos validadores.

**Exemplo:**
```dart
TextFormField(
  validator: combineValidators([
    (value) => validateRequired(value, 'Nome'),
    (value) => validateMinLength(value, 3, 'Nome'),
  ]),
  // ...
)
```

### 2. Formatadores de Entrada (`lib/core/utils/input_formatters.dart`)

Os formatadores aplicam regras de formatação automaticamente enquanto o usuário digita, filtrando caracteres inválidos.

#### Formatadores Disponíveis

##### `PriceInputFormatter()`
Formata campos de preço.

**Características:**
- Permite apenas números e separador decimal (ponto ou vírgula)
- Converte vírgula para ponto automaticamente
- Limita a 2 casas decimais
- Permite apenas um separador decimal

**Exemplo:**
```dart
TextFormField(
  inputFormatters: [PriceInputFormatter()],
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  // ...
)
```

**Comportamento:**
- Input: `10,50` → Output: `10.50`
- Input: `10.505` → Output: `10.50`
- Input: `R$ 10.50` → Output: `10.50`

##### `QuantityInputFormatter()`
Formata campos de quantidade.

**Características:**
- Permite apenas dígitos
- Remove qualquer caractere não numérico

**Exemplo:**
```dart
TextFormField(
  inputFormatters: [QuantityInputFormatter()],
  keyboardType: TextInputType.number,
  // ...
)
```

**Comportamento:**
- Input: `10.5` → Output: `105`
- Input: `10a5` → Output: `105`

##### `ProductCodeInputFormatter()`
Formata códigos de produto.

**Características:**
- Permite apenas letras, números e hífens
- Converte para maiúsculas automaticamente
- Remove espaços e caracteres especiais

**Exemplo:**
```dart
TextFormField(
  inputFormatters: [ProductCodeInputFormatter()],
  // ...
)
```

**Comportamento:**
- Input: `abc-123` → Output: `ABC-123`
- Input: `ABC 123` → Output: `ABC123`
- Input: `ABC@123` → Output: `ABC123`

### 3. Exceções Customizadas

#### `ValidationException` (`lib/core/exceptions/validation_exception.dart`)
Representa erros de validação com mensagens detalhadas.

**Exemplo:**
```dart
throw ValidationException(
  'Preço inválido',
  field: 'preco',
  suggestion: 'Use apenas números positivos com até 2 casas decimais',
  invalidValue: -10.50,
);
```

#### `ProductException` (`lib/core/exceptions/product_exception.dart`)
Representa erros específicos de operações com produtos.

**Exemplo:**
```dart
throw ProductException.invalidPrice('PROD-001', -10.50);
throw ProductException.duplicateCode('PROD-001');
throw ProductException.insufficientStock('PROD-001', available: 5, requested: 10);
```

## Uso Prático

### Exemplo Completo: Campo de Preço

```dart
TextFormField(
  controller: _precoController,
  decoration: const InputDecoration(
    labelText: 'Preço (R\$) *',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.attach_money),
    helperText: 'Ex: 10.50',
  ),
  keyboardType: TextInputType.numberWithOptions(decimal: true),
  inputFormatters: [PriceInputFormatter()],
  validator: validatePrice,
)
```

### Exemplo Completo: Campo de Quantidade

```dart
TextFormField(
  controller: _quantidadeController,
  decoration: const InputDecoration(
    labelText: 'Quantidade *',
    border: OutlineInputBorder(),
    prefixIcon: Icon(Icons.inventory),
    helperText: 'Ex: 10',
  ),
  keyboardType: TextInputType.number,
  inputFormatters: [QuantityInputFormatter()],
  validator: validateQuantity,
)
```

### Exemplo Completo: Validadores Combinados

```dart
TextFormField(
  controller: _nomeController,
  decoration: const InputDecoration(
    labelText: 'Nome *',
    border: OutlineInputBorder(),
  ),
  validator: combineValidators([
    (value) => validateRequired(value, 'Nome'),
    (value) => validateMinLength(value, 3, 'Nome'),
  ]),
)
```

## Telas Atualizadas

As seguintes telas já foram atualizadas para usar o novo sistema de validação:

1. **Produtos** (`lib/screens/products/product_screen.dart`)
   - Campo de preço: `PriceInputFormatter` + `validatePrice`
   - Campo de estoque: `QuantityInputFormatter` + `validateStock`
   - Campo de código: `ProductCodeInputFormatter` + `validateProductCode`

2. **Vendas** (`lib/screens/sales/sales_screen.dart`)
   - Campo de quantidade: `QuantityInputFormatter` + validação de estoque
   - Campos obrigatórios: `validateRequired`

3. **Clientes** (`lib/screens/customer/customer_view.dart`)
   - Campo de nome: validação combinada (required + minLength)

4. **Usuários** (`lib/screens/usuario_screen.dart`)
   - Campo de nome: validação combinada (required + minLength)

## Testes

Os validadores e formatadores possuem testes abrangentes:

- **Validadores**: `test/validators_test.dart` (40+ casos de teste)
- **Formatadores**: `test/input_formatters_test.dart` (35+ casos de teste)

Execute os testes com:
```bash
flutter test test/validators_test.dart
flutter test test/input_formatters_test.dart
```

## Boas Práticas

1. **Sempre combine formatadores com validadores**
   - Formatadores previnem entrada inválida
   - Validadores garantem que o valor final é correto

2. **Use helper text para orientar o usuário**
   - Forneça exemplos de formato esperado
   - Indique limitações (ex: estoque disponível)

3. **Mensagens de erro específicas**
   - Use os validadores fornecidos que já têm mensagens claras
   - Evite mensagens genéricas como "Valor inválido"

4. **Validação progressiva**
   - Use `combineValidators` para aplicar múltiplas regras em ordem
   - A primeira regra que falhar retorna sua mensagem

5. **Consistência**
   - Use os mesmos validadores e formatadores em contextos similares
   - Mantenha o padrão de mensagens de erro

## Próximos Passos

Para adicionar validação a uma nova tela:

1. Importe os utilitários necessários:
   ```dart
   import 'package:system_loja/core/utils/validators.dart';
   import 'package:system_loja/core/utils/input_formatters.dart';
   ```

2. Adicione formatadores aos campos:
   ```dart
   inputFormatters: [PriceInputFormatter()],
   ```

3. Adicione validadores aos campos:
   ```dart
   validator: validatePrice,
   ```

4. Teste a validação manualmente e adicione testes automatizados se necessário.

## Contribuindo

Ao adicionar novos validadores ou formatadores:

1. Documente o comportamento esperado
2. Adicione exemplos de uso
3. Escreva testes abrangentes
4. Atualize esta documentação
5. Mantenha mensagens de erro em português
6. Siga o padrão existente de nomenclatura
