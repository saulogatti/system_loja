# Serviços de Domínio do System Loja

Este diretório contém serviços de domínio e implementações de repositórios que orquestram DAOs e regras de negócio.

## Serviços Disponíveis

### CodeGeneratorService

**Arquivo**: `code_generator_service.dart`

**Propósito**: Geração automática e validação de códigos únicos para produtos e notas fiscais.

**Principais Funcionalidades**:
- Geração de códigos de produto no formato `PRD-YYYYMMDD-NNNN`
- Geração de números de nota fiscal no formato `NF-YYYYMMDD-NNNN`
- Validação de códigos personalizados fornecidos pelo usuário
- Verificação de duplicatas no banco de dados
- Garantia de unicidade através de verificação no banco

**Quando usar**:
- ✅ Ao criar um novo produto sem código definido
- ✅ Ao criar uma nova nota fiscal sem número definido
- ✅ Ao validar códigos fornecidos pelo usuário antes de salvar
- ✅ Ao verificar se um código já existe no sistema

**Como usar**:

```dart
// Acesso direto
final codeGenerator = appInjection.get<CodeGeneratorService>();

// Via repository (recomendado)
final productRepository =  appInjection.get<ProductRepository>();
final code = await productRepository.generateProductCode();

final salesRepository = appInjection.get<SalesRepository>();
final invoiceNumber = await salesRepository.generateInvoiceNumber();
```

**Documentação completa**: Ver `/docs/CODE_GENERATOR_USAGE.md`

**Exemplos de uso**: Ver `code_generator_examples.dart`

**Testes**: Ver `/test/code_generator_service_test.dart`

---

## Padrões de Implementação

### Injeção de Dependência

Todos os serviços devem ser registrados no `AppInjection` para facilitar o acesso:

```dart
// Em app_injection.dart
late final MeuServicoService meuServico = MeuServicoService(
  dependencia1: ...,
  dependencia2: ...,
);
```

### Documentação

Todos os serviços devem:
1. Ter comentários `///` em português descrevendo sua funcionalidade
2. Documentar todos os métodos públicos
3. Incluir exemplos de uso quando apropriado
4. Ter testes unitários cobrindo cenários principais

### Nomenclatura

- Classes de serviço devem terminar com `Service` (ex: `CodeGeneratorService`)
- Métodos devem ser verbos claros em inglês (ex: `generateProductCode`, `validateInvoiceNumber`)
- Comentários e strings de usuário devem estar em português

### Estrutura Típica de um Serviço

```dart
import 'dependencies';

/// Descrição breve do serviço.
///
/// Descrição detalhada de funcionalidades e casos de uso.
class MeuServicoService {
  final Dependency1 _dependency1;
  final Dependency2 _dependency2;

  MeuServicoService({
    required Dependency1 dependency1,
    required Dependency2 dependency2,
  })  : _dependency1 = dependency1,
        _dependency2 = dependency2;

  /// Descrição do método.
  ///
  /// [param1] Descrição do parâmetro.
  /// Retorna descrição do retorno.
  Future<ReturnType> publicMethod(ParamType param1) async {
    // Implementação
  }

  /// Método auxiliar privado
  TypeReturn _privateHelper(ParamType param) {
    // Implementação
  }
}

/// Classes auxiliares relacionadas ao serviço
class ServiceResult {
  final bool isSuccess;
  final String message;

  ServiceResult({
    required this.isSuccess,
    required this.message,
  });
}
```

## Testes

Cada serviço deve ter seu arquivo de teste correspondente em `/test/`:

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:system_loja/core/services/meu_servico_service.dart';

void main() {
  late MeuServicoService service;

  setUp(() {
    // Setup antes de cada teste
    service = MeuServicoService(...);
  });

  tearDown(() {
    // Cleanup após cada teste
  });

  group('MeuServicoService', () {
    test('deve fazer algo específico', () async {
      // Arrange
      final input = ...;
      
      // Act
      final result = await service.metodo(input);
      
      // Assert
      expect(result, equals(esperado));
    });
  });
}
```

## Diretrizes de Desenvolvimento

### Quando Criar um Novo Serviço

Crie um novo serviço quando:
- ✅ A funcionalidade é usada por múltiplos repositórios ou telas
- ✅ A lógica é complexa e merece ser isolada
- ✅ A funcionalidade não se encaixa naturalmente em um repository
- ✅ Você precisa coordenar múltiplas fontes de dados

**NÃO** crie um serviço quando:
- ❌ A lógica é específica de um único repository (coloque no repository)
- ❌ É apenas uma função auxiliar simples (use utils)
- ❌ É transformação de dados (use extensions)
- ❌ É validação simples (use validators em utils)

### Diferença entre Service e Repository

| Aspecto | Service | Repository |
|---------|---------|------------|
| **Propósito** | Lógica de negócio transversal | Acesso a dados de uma entidade |
| **Dependências** | Pode depender de múltiplos DAOs/APIs | Geralmente um DAO principal |
| **Escopo** | Múltiplas entidades/domínios | Uma entidade específica |
| **Exemplo** | CodeGeneratorService, NotificationService | ProductRepository, CustomerRepository |

### Performance e Async

- Use `async/await` para operações assíncronas
- Evite operações síncronas que bloqueiam a UI
- Para operações pesadas, considere usar isolates
- Cache resultados quando apropriado

### Tratamento de Erros

Repositórios e serviços devem:
1. Usar `try/catch` internamente — **nunca** relançar exceções para BLoC/Cubit
2. Retornar `ResultStatus<R, String>` com mensagens amigáveis via `mensagemErroRepositorio()` (`lib/core/utils/repository_error_mapper.dart`)
3. Logar erros quando apropriado (via `LoggerClassMixin` ou similar)
4. Fornecer mensagens de erro claras em português

Exemplo (repositório):
```dart
Future<ResultStatus<Customer, String>> buscar(int id) async {
  try {
    final row = await _dao.getById(id);
    return ResultStatus.success(row!.toCustomer());
  } catch (e) {
    return ResultStatus.error(
      mensagemErroRepositorio(e, contexto: 'Falha ao buscar cliente'),
    );
  }
}
```

A camada de apresentação **não** envolve chamadas ao repositório em `try/catch`; usa `when` ou `switch` no `ResultStatus`.

## Contribuindo

Ao adicionar um novo serviço:

1. ✅ Crie o arquivo em `lib/domain/nome_servico_service.dart`
2. ✅ Documente todos os métodos públicos em português
3. ✅ Registre no `AppInjection`
4. ✅ Crie testes em `test/nome_servico_service_test.dart`
5. ✅ Atualize este README com informações do novo serviço
6. ✅ Se complexo, crie documentação adicional em `/docs/`
7. ✅ Considere criar exemplos de uso

## Recursos Adicionais

- **Documentação de Arquitetura**: `/.github/copilot-instructions.md`
- **Padrões de Código Dart**: `/.github/instructions/dartcode.instructions.md`
- **Build Runner**: Execute `dart run build_runner build --delete-conflicting-outputs` após mudanças em serviços que usam geração de código
