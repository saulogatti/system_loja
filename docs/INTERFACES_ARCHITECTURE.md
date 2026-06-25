# Arquitetura de Interfaces

## Indice

- [Visao Geral](#visao-geral)
- [Fluxo de Camadas](#fluxo-de-camadas)
- [Interfaces Principais](#interfaces-principais)
- [Padroes de Retorno e Erro](#padroes-de-retorno-e-erro)
- [Registro no GetIt](#registro-no-getit)
- [Boas Praticas](#boas-praticas)
- [Referencias](#referencias)

## Visao Geral

As interfaces em `lib/core/interface/` definem os contratos entre a camada de apresentacao e os repositorios/servicos.
A implementacao concreta fica fora da UI e e resolvida por injecao de dependencia.

## Fluxo de Camadas

Screen (BLoC/Cubit) -> Interface (`lib/core/interface/`) -> Repository (`lib/domain/repository/`) -> DAO Drift (`lib/data/database/dao/`) -> SQLite.

## Interfaces Principais

- `ICustomerRepository`
- `ICompanyRepository`
- `IProductRepository`
- `ISalesRepository`
- `ICategoryRepository`
- `IConfigurationRepository`
- `ILogRepository`
- `IUserRepository`
- `ISystemRepository`
- `IAnalyticsRepository`

As interfaces permanecem em `lib/core/interface/` e suas implementacoes em `lib/domain/repository/`.

## Padroes de Retorno e Erro

- Operacoes de repositorio retornam `ResultStatus<R, E>`.
- Repositorios capturam excecoes internamente e retornam `ResultStatus.error(...)` com mensagem amigavel.
- A camada de apresentacao nao deve envolver chamadas de repositorio em `try/catch`; deve tratar o `ResultStatus` com `when`/`switch`.

Exemplo resumido:

```dart
final result = await repository.getAllCustomers();
result.when(
  onSuccess: (customers) => emit(CustomerLoaded(customers)),
  onError: (message) => emit(CustomerError(message)),
);
```

## Registro no GetIt

As dependencias sao registradas em `setupAppInjection()` no arquivo `lib/application/app_injection.dart`.

Exemplo:

```dart
appInjection.registerSingleton<ICustomerRepository>(
  CustomerRepository(
    logRepository: appInjection.get<ILogRepository>(),
    customerDao: appInjection.get<AppDatabase>().customerDao,
  ),
);
```

## Boas Praticas

- Manter contratos de interface enxutos e orientados ao caso de uso.
- Evitar vazamento de detalhes de persistencia (DAO, Companion, SQL) para camadas acima.
- Manter nomenclatura consistente entre interface e implementacao.
- Priorizar metodos assincronos para operacoes de I/O.
- Em novos fluxos, evitar expandir caminhos legados baseados em managers JSON.

## Referencias

- `README.md`
- `.github/copilot-instructions.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `lib/application/app_injection.dart`
