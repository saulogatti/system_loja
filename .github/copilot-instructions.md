# System Loja - Copilot Instructions

## Build and Test
- Instalar dependências: `flutter pub get`.
- Rodar codegen quando houver alteração em `@freezed`, `@JsonSerializable`, Drift (`@DriftDatabase`, `@DriftAccessor`, tabelas/DAOs) ou `auto_route` (`@RoutePage`):
  - `dart run build_runner build --delete-conflicting-outputs`
- Executar app: `flutter run -d windows`, `flutter run -d chrome` ou `flutter run -d linux`.
- Testes: `flutter test` e `flutter test test/<arquivo>_test.dart`.
- Qualidade: `dart analyze` e `dart format --set-exit-if-changed .`.

## Architecture
- App Flutter multiplataforma com UI em `lib/screens/`.
- Fluxo principal: **Screen (Bloc/Cubit)** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/domain/repository/`) → **DAO Drift** (`lib/data/database/dao/`) → SQLite.
- DI com `GetIt` via `setupAppInjection()` em `lib/aplication/app_injection.dart` (chamado no `main()`).
- Navegação com `auto_route` em `lib/screens/route/route_app.dart` (gerado em `route_app.gr.dart`).
- Existem dois bancos Drift:
  - `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 11`.
  - `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 1`.

## Arquitetura limpa (obrigatório)
O código deve seguir **Clean Architecture** de forma consistente. Isso explica refactors maiores quando se desacoplam camadas (por exemplo: entidades de domínio em `lib/core/` sem serialização; DTOs, codecs e Drift em `lib/data/`; contratos em `lib/core/interface/`).

- **Domínio / core** (`lib/core/`): modelos de negócio, regras e interfaces de repositório. Evitar dependências da camada de dados (pacote `data`, `json_serializable` em entidades puras, Drift) quando o objetivo for manter o núcleo independente.
- **Dados** (`lib/data/`): persistência (Drift), DAOs, conversores, DTOs/entries com `json_serializable`/`build_runner`, cache e mapeamento para o domínio. **Não importar** `lib/domain/` nem `lib/aplication/` a partir de `lib/data/`.
- **Apresentação** (`lib/screens/`): UI, BLoC/Cubit, roteamento. Depende de interfaces e casos de uso, não de implementações concretas de banco.
- **Domínio / aplicação** (`lib/domain/`): implementações de repositórios que orquestram DAOs e regras.

Priorizar fronteiras claras mesmo que o diff seja grande; a manutenção e os testes compensam.

## Compatibilidade com versões anteriores
O projeto **ainda está em desenvolvimento**. **Não é necessário** preservar compatibilidade com formatos antigos de JSON, estruturas de modelo legadas ou schemas de banco anteriores só por compatibilidade retroativa. Pode-se alterar contratos e migrações quando a arquitetura limpa ou o modelo de domínio exigirem — desde que o código gerado (`build_runner`) e os testes do escopo alterado sejam atualizados.

## Conventions
- Retorno de operações usa `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`, usa `package:meta`) com `isSuccessful`, `hasError`, `asSuccess`, `asError` e `when(...)`.
- Não propagar exceções entre camadas de interface/repositório; retornar `ResultStatus`. Repositórios usam `try/catch` internamente e devolvem `ResultStatus.error(mensagemErroRepositorio(erro, contexto: '...'))` com mensagens de texto amigáveis (ver `lib/core/utils/repository_error_mapper.dart`).
- A camada de apresentação (BLoC/Cubit/Screen) **não** envolve chamadas ao repositório em `try/catch`; usa `when` / `switch` no `ResultStatus` e emite estado de erro com a mensagem já tratada. `try/catch` na UI fica reservado a operações locais (seletor de arquivo, escrita em `File`) que não passam pelo contrato do repositório.
- `CacheManager` é registrado via `GetIt` (DI); **não** usar `CacheManager.instance` — repositórios o recebem por injeção de construtor.
- Drift: convenção tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`.
- **Não** usar `@UseRowClass` apontando para entidades de `lib/core/models/`; manter linhas Drift como dados de persistência e mapear para domínio em `lib/data/database/mapper/` (ou política equivalente nos DAOs/repositórios).
- `SystemDatabase` aceita `QueryExecutor` opcional no construtor para facilitar testes com banco em memória.
- Código em inglês; documentação e comentários com `///` em português.
- Formato de commit: `<tipo>: <descrição concisa>`.
- Tipos de commit: `feat`, `fix`, `docs`, `style`, `refactor`, `test`.
- Mensagem de commit em português; incluir nome da classe alterada quando fizer sentido.

## Pitfalls
- Há código legado em `lib/core/managers/` e configuração em JSON ainda em uso pontual; refatorar em direção à arquitetura limpa tem prioridade sobre manter comportamento legado, salvo risco claro ao fluxo atual. Os arquivos de dados estáticos anteriores (`data/*.json`) foram removidos.
- Em mudanças de schema Drift, atualizar `schemaVersion` e estratégia de migração no banco correto (não é obrigatório manter dados antigos compatíveis — ver seção **Compatibilidade com versões anteriores**).
- No Web, Drift depende de `web/sqlite3.wasm` e `web/drift_worker.js`.
- Existem alguns testes com falhas pré-existentes no repositório; valide o escopo alterado antes de tratar falhas fora da tarefa.