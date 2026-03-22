# Análise arquitetural e plano de migração para Clean Architecture

## Diagnóstico atual

A base já tem uma boa estrutura por camadas, mas ainda há pontos em evolução em direção a uma Clean Architecture mais estrita.

1. Apresentação está em `lib/screens/`, com BLoC/Cubit e UI Flutter.
2. Contratos de repositório estão em `lib/core/interface/`; implementações em `lib/domain/repository/`.
3. Infra de persistência está em Drift/DAO em `lib/data/database/`.
4. DI centralizada (por exemplo `setupAppInjection` / GetIt); parte da UI ainda resolve dependências via service locator no composition root.

## O que já foi feito (evolução da arquitetura)

- **Repositórios concretos** em `lib/domain/repository/`, não dentro de `core`.
- **Serialização JSON de configuração** com codecs na camada de dados (`lib/data/converter/`: por exemplo `system_configuration_codec.dart`, `address_codec.dart`, `price_configuration_codec.dart`); modelos de domínio em `core` permanecem sem `@JsonSerializable` nesses fluxos.
- **Modelos de domínio** `address.dart`, `price_configuration.dart` e `system_configuration.dart` em `core` **não** importam Drift; comentários no código apontam para codecs em `data` quando há import/export JSON.
- **Conversores CPF/CNPJ** (`JsonConverter`): removidos de `lib/core/models/document/`; implementação em `lib/data/converter/cpf_cnpj_json_converters.dart` (por exemplo `IndividualEntry` e demais usos pela camada `data`).
- **`DocumentConverter`** (documento genérico por tamanho) em `lib/data/converter/document_converter.dart`.
- **`ProductCubit`** depende de `IProductRepository` (contrato), não de implementação concreta de repositório.
- **`SystemError`** (`lib/core/models/system_errors/system_error.dart`): entidade pura, **sem** import de `lib/data/` e **sem** anotações de serialização; `StackTrace` é campo normal.
- **`AppSettings`** (`lib/core/settings/app_settings.dart`): modelo Dart **sem** `@JsonSerializable` e **sem** `app_settings.g.dart` em `core`; preferências de cor usam `EnumColorAppThemeSettings` em `lib/core/settings/enum_color_app_theme_settings.dart` (enum **sem** `Color` do Flutter).
- **Tema Material**: `AppTheme` está em `lib/screens/settings/app_theme.dart`; a camada **`lib/core/` não importa `package:flutter`** (verificado com busca por `flutter/material`).
- **`string_extensions`** (por exemplo `hashPassword`) foi movido para `lib/screens/utils/string_extensions.dart`; **não há mais** dependência `core` → `aplication` por esse arquivo.
- **`CodeGeneratorService`** **saiu de `lib/core/`** e está em **`lib/domain/code_generator_service.dart`** (ainda depende de DAOs; ver pendências abaixo).
3. ~~**Tratamento de erro e repositório de configuração:** revisar `configuration_repository.dart` e a convenção de não propagar exceções entre camadas (usar `ResultStatus` de forma consistente).~~ **Concluído**: `ConfigurationRepository`, `SystemRepository` e `UserRepository` agora retornam `ResultStatus` em todos os métodos; `CacheManager` é injetado via DI; `mensagemErroRepositorio()` padroniza mensagens.
## Principais desalinhamentos com Clean Architecture (pendentes)

1. **`CodeGeneratorService`** (em `lib/domain/`): continua importando **`ProductDao`** e **`InvoiceDao`** (`lib/data/`). O ideal é substituir por **portas** (interfaces no domínio ou aplicação) implementadas na camada de dados, para `domain` não depender de Drift.
2. ~~**`system_error_manager.dart`** em `lib/aplication/`: o fluxo de erro ainda pode ser alinhado a `ResultStatus` e aos contratos de repositório de forma uniforme.~~ **Concluído parcialmente**: repositórios agora usam `try/catch` + `mensagemErroRepositorio()` e retornam `ResultStatus.error(...)` de forma consistente. Resta alinhar `system_error_manager`.

4. **Use cases / orquestração:** BLoCs/Cubits ainda podem depender diretamente de repositórios; introdução gradual de casos de uso é opcional, mas alinha melhor à Clean Architecture.
5. **Service locator na UI:** reduzir onde fizer sentido em favor de injeção por construtor dos blocos/widgets.
6. **Interfaces** após futuras mudanças de DTO: garantir que `i_configuration_repository` e serviços relacionados continuem expondo tipos de domínio estáveis se novos DTOs forem introduzidos para persistência.

## Lista do que ainda precisa ser alterado (prioridade sugerida)

Ordem por impacto e dependência.

1. **Refatorar `CodeGeneratorService`:** eliminar dependência direta de DAOs; definir interfaces de leitura de unicidade de código (ou equivalente) e implementá-las em `lib/data/`.
2. ~~**Padronizar erros** com `ResultStatus` nas fronteiras de repositório e revisar fluxo em `configuration_repository` / `system_error_manager`.~~ **Concluído**: repositórios retornam `ResultStatus` de forma consistente; `mensagemErroRepositorio()` centraliza mensagens; `CacheManager` injetado via DI; apresentação não usa `try/catch` para repositórios.
3. **Tornar camadas mais explícitas** onde ainda houver mistura (domínio puro, dados, apresentação).
4. **Opcional:** use cases entre BLoC e repositório; reduzir GetIt na UI; **testes de arquitetura** (regras de import, por exemplo `domain`/`core` sem `data`).

## Plano de execução prático (referência)

- **Sprint 1 (foco em dependências):** item 1 (`CodeGeneratorService` e portas). Item 2 (erros / `ResultStatus`) já concluído.
- **Sprint 2:** item 3 (clareza de camadas) e revisão de interfaces/DTOs conforme necessidade.
- **Sprint 3:** item 4 (use cases, DI na UI, testes de arquitetura).

O **próximo ganho de alto impacto** é **`CodeGeneratorService` sem DAOs**; a camada **`core` já está mais alinhada** (sem Flutter, sem `data`, sem JSON gerado em settings, `SystemError` e CPF/CNPJ desacoplados como descrito acima).
