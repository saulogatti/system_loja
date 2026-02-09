# Arquitetura de Interfaces

## 📋 Índice
- [Visão Geral](#visão-geral)
- [Interfaces Disponíveis](#interfaces-disponíveis)
- [Padrões e Convenções](#padrões-e-convenções)
- [Implementação](#implementação)
- [Exemplos de Uso](#exemplos-de-uso)
- [Boas Práticas](#boas-práticas)

## Visão Geral

As interfaces em `lib/core/interface/` definem contratos para as operações de repositório e serviços do System Loja. Elas permitem:

- **Desacoplamento**: Separação entre definição e implementação
- **Testabilidade**: Facilita criação de mocks para testes
- **Flexibilidade**: Permite múltiplas implementações (Drift, JSON, In-Memory)
- **Type Safety**: Garante contratos consistentes em toda a aplicação

### Estrutura

```
lib/core/interface/
├── i_category_repository.dart      # Operações de categorias
├── i_company_repository.dart       # Operações de empresas
├── i_configuration_repository.dart # Configurações da aplicação
├── i_customer_repository.dart      # Operações de clientes
├── i_log_repository.dart          # Sistema de auditoria/logs
├── i_product_repository.dart      # Operações de produtos
├── i_sales_repository.dart        # Operações de vendas
├── i_settings_service.dart        # Serviço de tema/configurações UI
├── i_system_repository.dart       # Configurações do sistema
└── i_user_repository.dart         # Operações de usuários
```

## Interfaces Disponíveis

### 1. ICategoryRepository
Gerencia categorias de produtos.

**Operações principais:**
- CRUD completo de categorias
- Validação de uso (verifica se categoria está vinculada a produtos)
- Busca por nome

**Uso típico:**
```dart
final repository = AppInjection.instance.categoryRepository;
final result = await repository.createCategory(
  name: 'Eletrônicos',
  description: 'Produtos eletrônicos em geral',
);
```

### 2. ICompanyRepository
Gerencia cadastro de empresas.

**Operações principais:**
- CRUD completo de empresas
- Busca por CNPJ
- Mapeamento de empresas por ID

**Uso típico:**
```dart
final repository = AppInjection.instance.companyRepository;
final result = await repository.findByCnpj(cnpj: '12345678000199');
if (result.isSuccessful && result.asSuccess != null) {
  print('Empresa: ${result.asSuccess!.fantasyName}');
}
```

### 3. IConfigurationRepository
Gerencia configurações globais da aplicação.

**Operações principais:**
- Backup e restore de dados
- Limpeza de dados e logs antigos
- Reset para configurações padrão
- Gerenciamento de AppSettings

**Uso típico:**
```dart
final repository = AppInjection.instance.configurationRepository;
await repository.createBackup('/caminho/do/backup');
```

### 4. ICustomerRepository
Gerencia cadastro de clientes.

**Operações principais:**
- CRUD completo de clientes
- Busca por CPF
- Mapeamento de clientes por ID

**Uso típico:**
```dart
final repository = AppInjection.instance.customerRepository;
final result = await repository.findWith(cpf: '12345678900');
```

### 5. ILogRepository
Sistema de auditoria e logs de atividades.

**Operações principais:**
- Registro de ações (create, update, delete)
- Consulta por usuário, período, tipo de ação, entidade
- Limpeza de logs antigos

**Uso típico:**
```dart
final repository = AppInjection.instance.logRepository;
await repository.createAndLogEntry(
  logActionType: ActionType.create,
  entityName: 'Customer',
  userId: currentUser.id,
  username: currentUser.name,
  logDetails: 'Cliente João Silva cadastrado',
);
```

### 6. IProductRepository
Gerencia cadastro de produtos.

**Operações principais:**
- CRUD completo de produtos
- Geração automática de código de produto
- Validação de códigos únicos
- Busca por código

**Uso típico:**
```dart
final repository = AppInjection.instance.productRepository;
final codigo = await repository.generateProductCode();
final result = await repository.saveProduct(product);
```

### 7. ISalesRepository
Gerencia vendas/notas fiscais.

**Operações principais:**
- CRUD completo de vendas
- Geração automática de número de nota fiscal
- Validação de números únicos
- Mapeamento de vendas por ID

**Uso típico:**
```dart
final repository = AppInjection.instance.salesRepository;
final numeroNota = await repository.generateInvoiceNumber();
await repository.saveSale(invoice);
```

### 8. ISettingsService
Serviço de configurações de tema da UI.

**Operações principais:**
- Atualização de cor primária
- Toggle de tema escuro/claro

**Uso típico:**
```dart
final service = AppInjection.instance.settingsService;
service.updateSettings(
  EnumColorAppThemeSettings.blue,
  true, // tema escuro
);
```

### 9. ISystemRepository
Configurações técnicas do sistema.

**Operações principais:**
- Leitura e gravação de SystemConfiguration
- Metadados de versão e inicialização

**Uso típico:**
```dart
final repository = AppInjection.instance.systemRepository;
final config = await repository.getSystemConfiguration();
```

### 10. IUserRepository
Gerencia usuários do sistema.

**Operações principais:**
- CRUD completo de usuários
- Busca por email ou ID
- Validação de email
- Autenticação (em conjunto com outros serviços)

**Uso típico:**
```dart
final repository = AppInjection.instance.userRepository;
final user = await repository.obterUsuarioPorEmail('admin@system.com');
if (user != null && repository.validarEmail(user.email)) {
  // autenticar
}
```

## Padrões e Convenções

### 1. ResultStatus vs Retorno Direto

A maioria das operações usa `ResultStatus<Success, Error>` para tratamento type-safe de erros:

```dart
// ✅ Com ResultStatus
Future<ResultStatus<Customer, String>> findCustomerById(int id);

// Uso:
final result = await repository.findCustomerById(1);
if (result.isSuccessful) {
  final customer = result.asSuccess;
  // processar customer
} else {
  final erro = result.asError;
  // tratar erro
}
```

Exceções:
- Métodos de configuração retornam `Future<AppSettings>` diretamente
- Métodos de validação simples retornam `bool`
- Métodos do system repository retornam objetos diretamente

### 2. Nomenclatura

#### Operações CRUD
- **Create**: `save`, `create`, `adicionar`
- **Read**: `get`, `find`, `fetch`, `obter`, `load`
- **Update**: `update`, `atualizar`
- **Delete**: `delete`, `remove`, `remover`

#### Operações Especiais
- **Geração**: `generate` (códigos, números)
- **Validação**: `validate`, `validar`, `is` (booleanos)
- **Mapeamento**: `fetchMapped`, `loadAll` (retorna Map<int, Entity>)

#### Português vs Inglês
- **Interfaces e métodos novos**: inglês (padrão do projeto)
- **Métodos legados** (especialmente IUserRepository): português (mantido para compatibilidade)
- **Documentação**: sempre em português

### 3. Async/Await

Todas as operações de I/O são assíncronas:

```dart
// ✅ Correto
Future<ResultStatus<List<Product>, String>> fetchProducts();

// ❌ Incorreto
List<Product> fetchProducts(); // operação de I/O deve ser async
```

Exceção: Operações in-memory ou validações simples:
```dart
// ✅ OK para validação in-memory
bool validarEmail(String email);
```

### 4. Parâmetros Nomeados vs Posicionais

**Use parâmetros nomeados quando:**
- Há múltiplos parâmetros
- Parâmetros opcionais
- Parâmetros do mesmo tipo (evita confusão)

```dart
// ✅ Parâmetros nomeados
Future<ResultStatus<int, String>> createCategory({
  required String name,
  String? description,
});

// ✅ Parâmetro posicional único
Future<ResultStatus<bool, String>> deleteCategory(int id);
```

## Implementação

### Onde as Interfaces São Implementadas

```
lib/core/repository/
├── category_repository.dart        # Implementa ICategoryRepository
├── company_repository.dart         # Implementa ICompanyRepository
├── configuration_repository.dart   # Implementa IConfigurationRepository
├── customer_repository.dart        # Implementa ICustomerRepository
├── log_repository.dart            # Implementa ILogRepository
├── product_repository.dart        # Implementa IProductRepository
├── sales_repository.dart          # Implementa ISalesRepository
└── user_repository.dart           # Implementa IUserRepository

lib/core/services/
├── settings_service.dart          # Implementa ISettingsService
└── system_repository.dart         # Implementa ISystemRepository
```

### Exemplo de Implementação

```dart
// Interface (lib/core/interface/i_customer_repository.dart)
abstract interface class ICustomerRepository {
  Future<ResultStatus<List<Customer>, String>> getAllCustomers();
}

// Implementação (lib/core/repository/customer_repository.dart)
class CustomerRepository implements ICustomerRepository {
  final ClienteDao _dao;

  CustomerRepository(this._dao);

  @override
  Future<ResultStatus<List<Customer>, String>> getAllCustomers() async {
    try {
      final customers = await _dao.getAll();
      return ResultStatus.success(customers);
    } catch (e) {
      return ResultStatus.failure('Erro ao buscar clientes: $e');
    }
  }
}
```

### Registro no AppInjection

```dart
class AppInjection {
  // DAOs
  final AppDatabase appDatabase = AppDatabase();
  
  // Repositories (implementam interfaces)
  late final ICustomerRepository customerRepository = 
      CustomerRepository(ClienteDao(appDatabase));
  
  late final IProductRepository productRepository = 
      ProductRepository(ProductDao(appDatabase));
  
  // ... outros repositories
}
```

## Exemplos de Uso

### 1. Cadastro de Cliente Completo

```dart
// BLoC/Cubit
class CustomerBloc extends Bloc<CustomerEvent, CustomerState> {
  final ICustomerRepository _repository;

  CustomerBloc(this._repository) : super(CustomerInitial()) {
    on<SaveCustomer>(_onSaveCustomer);
  }

  Future<void> _onSaveCustomer(
    SaveCustomer event,
    Emitter<CustomerState> emit,
  ) async {
    emit(CustomerLoading());

    // 1. Validar CPF único
    final existente = await _repository.findWith(cpf: event.customer.cpf);
    if (existente.isSuccessful && existente.asSuccess != null) {
      emit(CustomerError('CPF já cadastrado'));
      return;
    }

    // 2. Salvar cliente
    final resultado = await _repository.saveCustomer(event.customer);
    if (resultado.isSuccessful) {
      // 3. Registrar log
      await AppInjection.instance.logRepository.createAndLogEntry(
        logActionType: ActionType.create,
        entityName: 'Customer',
        userId: currentUser.id,
        username: currentUser.name,
        logDetails: 'Cliente ${event.customer.name} cadastrado',
      );

      emit(CustomerSaved());
    } else {
      emit(CustomerError(resultado.asError));
    }
  }
}
```

### 2. Relatório de Vendas com Logs

```dart
Future<void> gerarRelatorioVendas() async {
  final salesRepo = AppInjection.instance.salesRepository;
  final logRepo = AppInjection.instance.logRepository;

  // Buscar vendas
  final vendasResult = await salesRepo.loadAllSales();
  if (!vendasResult.isSuccessful) {
    print('Erro: ${vendasResult.asError}');
    return;
  }

  final vendas = vendasResult.asSuccess;
  print('Total de vendas: ${vendas.length}');

  // Buscar logs de vendas do período
  final logsResult = await logRepo.fetchLogsByPeriod(
    DateTime.now().subtract(Duration(days: 30)),
    DateTime.now(),
  );

  if (logsResult.isSuccessful) {
    final logs = logsResult.asSuccess
        .where((log) => log.entity == 'Invoice')
        .toList();
    print('Operações de venda no período: ${logs.length}');
  }
}
```

### 3. Backup Completo do Sistema

```dart
Future<void> realizarBackupCompleto(String diretorio) async {
  final configRepo = AppInjection.instance.configurationRepository;
  final logRepo = AppInjection.instance.logRepository;

  try {
    // 1. Limpar logs antigos (liberar espaço)
    await configRepo.clearOldLogs();

    // 2. Criar backup
    final settings = await configRepo.createBackup(diretorio);
    print('Backup criado com sucesso em: $diretorio');
    print('Última atualização: ${settings.lastUpdatedDate}');

    // 3. Registrar operação
    await logRepo.createAndLogEntry(
      logActionType: ActionType.other,
      entityName: 'System',
      userId: currentUser.id,
      username: currentUser.name,
      logDetails: 'Backup criado em $diretorio',
    );
  } catch (e) {
    print('Erro ao criar backup: $e');
  }
}
```

## Boas Práticas

### ✅ Sempre Faça

1. **Use ResultStatus para operações que podem falhar**
   ```dart
   Future<ResultStatus<Customer, String>> findCustomerById(int id);
   ```

2. **Valide antes de persistir**
   ```dart
   // Verificar se CPF já existe
   final existente = await repository.findWith(cpf: cpf);
   if (existente.isSuccessful && existente.asSuccess != null) {
     return ResultStatus.failure('CPF já cadastrado');
   }
   ```

3. **Registre operações críticas nos logs**
   ```dart
   await logRepository.createAndLogEntry(
     logActionType: ActionType.delete,
     entityName: 'Customer',
     userId: userId,
     username: username,
     logDetails: 'Cliente ${customer.name} removido',
   );
   ```

4. **Use AppInjection para acessar repositórios**
   ```dart
   final repository = AppInjection.instance.customerRepository;
   ```

5. **Documente comportamentos especiais**
   ```dart
   /// **ATENÇÃO**: Esta operação remove todos os dados e é irreversível.
   Future<AppSettings> clearAllData();
   ```

### ❌ Evite

1. **Não capture exceções genericamente sem contexto**
   ```dart
   // ❌ Evite
   try {
     await repository.save(entity);
   } catch (e) {
     print('Erro'); // mensagem genérica
   }

   // ✅ Prefira
   final result = await repository.save(entity);
   if (!result.isSuccessful) {
     print('Erro ao salvar: ${result.asError}');
   }
   ```

2. **Não ignore ResultStatus**
   ```dart
   // ❌ Evite
   await repository.saveCustomer(customer); // não verifica resultado

   // ✅ Prefira
   final result = await repository.saveCustomer(customer);
   if (result.isSuccessful) {
     // sucesso
   }
   ```

3. **Não crie instâncias diretas dos repositories**
   ```dart
   // ❌ Evite
   final dao = ClienteDao(AppDatabase());
   final repository = CustomerRepository(dao);

   // ✅ Prefira
   final repository = AppInjection.instance.customerRepository;
   ```

4. **Não misture lógica de negócio na interface**
   ```dart
   // ❌ Interfaces devem ser contratos puros
   abstract interface class ICustomerRepository {
     Future<bool> saveCustomer(Customer customer) {
       // implementação aqui - ERRADO!
     }
   }
   ```

## Veja Também

- [DRIFT_ARCHITECTURE.md](DRIFT_ARCHITECTURE.md) - Arquitetura do banco de dados
- [DRIFT_MIGRATION.md](DRIFT_MIGRATION.md) - Guia de migração para Drift
- [VALIDATION_SYSTEM.md](VALIDATION_SYSTEM.md) - Sistema de validação
- [REFACTORING_BLOC.md](REFACTORING_BLOC.md) - Padrões de BLoC

---

**Status**: ✅ Documentação completa  
**Última atualização**: 2024  
**Interfaces**: 10 documentadas
