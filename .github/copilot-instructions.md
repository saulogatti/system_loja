# System Loja - Copilot Instructions

## Big Picture
- App Flutter multiplataforma (Windows/macOS/iOS/Android) com UI em `lib/screens/`.
- Fluxo principal: **Screen (Bloc/Cubit)** → **Interface** (`lib/core/interface/`) → **Repository** (`lib/core/repository/`) → **DAO Drift** (`lib/data/database/dao/`) → SQLite.
- Há código legado em `lib/core/managers/` e configuração em JSON ainda em uso pontual (`ConfigurationRepository`). Não remover sem validar impacto.

## Arquitetura e integrações críticas
- DI usa `GetIt` com bootstrap síncrono em `setupAppInjection()` chamado no `main()`.
- Navegação usa `auto_route` com root router em `lib/screens/route/route_app.dart` e gerado em `route_app.gr.dart`.
- Existem **dois bancos Drift**:
  - `AppDatabase` (`lib/data/database/app_database.dart`) com `schemaVersion => 10`.
  - `SystemDatabase` (`lib/data/database/system_database.dart`) com `schemaVersion => 2`.
- Dependências centrais: `drift`, `flutter_bloc`, `freezed`, `json_serializable`, `auto_route`, `get_it`.

## Padrões do projeto (não genéricos)
- Resultado de operações usa `ResultStatus<R, E>` (`lib/core/utils/command_result.dart`), com `isSuccessful`, `hasError`, `asSuccess`, `asError` e `when(...)`.
- Em várias tabelas Drift, o domínio é ligado via `@UseRowClass(...)` (ex.: `customer_records.dart`, `products_records.dart`), reduzindo conversões manuais.
- Convenção de nomes Drift: tabela `XxxRecords`, linha gerada `XxxRecord`, DAO `XxxDao`.
- Código em inglês; documentação/comentários com `///` em português.

## Workflow obrigatório para agentes
- Rodar codegen sempre que alterar anotações/rotas/modelos/DAOs:
  - `dart run build_runner build --delete-conflicting-outputs`
- Casos típicos de codegen neste projeto:
  - `@freezed` (bloc state/event)
  - `@JsonSerializable` (modelos)
  - `@DriftDatabase`, `@DriftAccessor`, tabelas/DAOs
  - `@RoutePage` / mudanças de rotas `auto_route`

## Comandos úteis (confirmados)
- Executar app: `flutter run -d windows` ou `flutter run -d chrome`
- Testes: `flutter test` e `flutter test test/<arquivo>_test.dart`
- Qualidade: `dart analyze` e `dart format .`

## Checklist antes de concluir alteração
- Se mudou schema Drift, atualizar `schemaVersion` e estratégia de migração no banco correto.
- Se mudou rotas/DI, conferir `setupAppInjection()` e router usado em `MaterialApp.router`.
- Se mudou código com geração, executar build_runner e revisar arquivos gerados.
- Não migrar/remover fluxo legado (`core/managers`) sem confirmar uso atual em repositório/interface/UI.