# Análise arquitetural e plano de migração para Clean Architecture

## Diagnóstico atual

A base já tem uma boa estrutura por camadas, mas ainda está em um modelo híbrido entre arquitetura em camadas tradicional e Clean Architecture.

1. Apresentação está bem definida em `lib/screens/`, com BLoC/Cubit e UI Flutter.
2. Contratos de repositório estão em `lib/core/interface/`; implementações em `lib/domain/repository/` (não em `core`).
3. Infra de persistência está organizada em Drift/DAO em `lib/data/database/`.
4. DI centralizada (por exemplo `setupAppInjection` / GetIt); parte da UI ainda resolve dependências via service locator no composition root.

## O que já foi feito (evolução da arquitetura)

- **Repositórios concretos** já estão em `lib/domain/repository/`, não dentro de `core`.
- **Serialização JSON de configuração** com codecs na camada de dados (`lib/data/converter/`, por exemplo `system_configuration_codec.dart`, `address_codec.dart`, `price_configuration_codec.dart`); modelos de domínio em `core` permanecem sem `@JsonSerializable` nesses fluxos.
- **Modelos de domínio** `address.dart`, `price_configuration.dart` e `system_configuration.dart` em `core` **não** importam Drift; comentários no código apontam para codecs em `data` quando há import/export JSON.
- **Conversores CPF/CNPJ** (`JsonConverter`): removidos de `lib/core/models/document/`; implementação em `lib/data/converter/cpf_cnpj_json_converters.dart` (entrada `IndividualEntry` e demais usos via camada `data`).
- **`DocumentConverter`** (CPF/CNPJ genérico por tamanho) já reside em `lib/data/converter/document_converter.dart`.
- **`ProductCubit`** depende de `IProductRepository` (contrato), não de implementação concreta de repositório.
1. **Core depende de Flutter** em tema: `app_theme.dart`, `app_theme_settings.dart` (ideal: abstrações no domínio e implementação Material na apresentação ou infraestrutura).
4. **`AppSettings`** (`lib/core/settings/app_settings.dart` + `.g.dart`) usa `@JsonSerializable` em `core`; pela convenção do projeto, DTO/codec deveriam estar em `data`.
2. **`system_error_manager.dart`** em `lib/aplication/` (não em `core`, mas o fluxo de erro ainda pode ser alinhado a `ResultStatus` e contratos).
## Principais desalinhamentos com Clean Architecture (pendentes)


3. **Core ainda importa `data` em pontos específicos:**
   - `lib/core/services/code_generator_service.dart` importa DAOs (`ProductDao`, `InvoiceDao`).
5. **`lib/core/utils/string_extensions.dart`** importa `lib/aplication/utils/constants.dart` (fronteira `core` → `aplication` invertida em relação ao ideal).
6. **Tratamento de erro e repositório de configuração:** revisar `configuration_repository.dart` e convenção de não propagar exceções entre camadas (usar `ResultStatus` de forma consistente).
7. **Use cases / orquestração:** BLoCs/Cubits ainda podem depender diretamente de repositórios; introdução gradual de casos de uso é opcional mas alinha melhor à Clean Architecture.
8. **Service locator na UI:** reduzir onde fizer sentido em favor de injeção por construtor dos blocs/widgets.

## Lista do que ainda precisa ser alterado (prioridade sugerida)

Ordem por impacto e dependência.

1. Separar camadas de forma explícita onde ainda houver mistura (domínio puro, dados, apresentação).
2. **Tornar `core` mais puro:** eliminar imports `core` → `data` e `core` → `aplication` onde listados acima.
3. Mover ou duplicar **Theme/Settings** (tipos Flutter) para fora do núcleo de domínio, mantendo contratos enxutos em `core` se necessário.
4. **Refatorar `CodeGeneratorService`:** substituir DAOs por interfaces (portas) definidas no domínio ou na aplicação, implementadas na camada de dados.
5. **Desacoplar `SystemError`:** deixar entidade de domínio sem anotação de serialização; conversor/DTO em `data`.
6. **Migrar `AppSettings` serializável** para DTO + mapper em `data` (ou equivalente), mantendo em `core` apenas o que for regra/conceito estável.
7. Corrigir **interfaces** que hoje expõem tipos acoplados a JSON/Flutter (`i_configuration_repository`, `i_settings_service`) após os itens 5 e 6.
8. **Padronizar erros** com `ResultStatus` nas fronteiras de repositório.
9. Reduzir acoplamento do **GetIt** na UI; **testes de arquitetura** (regras de import) quando fizer sentido.

## Plano de execução prático (referência)

- **Sprint 1 (foco em core limpo):** itens 2, 4, 5, 6, 7 (ajustes em `SystemError`, `CodeGeneratorService`, `AppSettings`, extensões e interfaces).
- **Sprint 2:** itens 3, 8 (tema/settings e erros).
- **Sprint 3:** itens 1, 9 (use cases opcionais, DI na UI, testes de arquitetura).

O primeiro ganho de alto impacto continua sendo **eliminar dependências indevidas da camada `core`** (`data`, Flutter onde não for necessário, e serialização em entidades de domínio).
