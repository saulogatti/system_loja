# Instrucoes de Build e Validacao

## Visao Geral

Este documento centraliza os comandos de geracao de codigo e validacao do projeto.
Use estas instrucoes apos alterar classes com `@freezed`, `@JsonSerializable`, Drift (tabelas/DAOs) ou rotas do `auto_route`.

## Geracao de Codigo (Obrigatorio)

Execute no diretorio raiz do projeto:

```bash
dart run build_runner build --delete-conflicting-outputs
```

Arquivos normalmente atualizados pela geracao:

- `*.freezed.dart`
- `*.g.dart` (json_serializable e Drift)
- `lib/screens/route/route_app.gr.dart`

## Qualidade

Depois da geracao, rode as validacoes:

```bash
dart analyze
flutter test
```

Para validar formatacao sem alterar arquivos:

```bash
dart format --set-exit-if-changed .
```

## Referencia de Banco (estado atual)

- `AppDatabase`: `schemaVersion => 12`
- `SystemDatabase`: `schemaVersion => 1`

Se houver alteracao de schema Drift, atualize o `schemaVersion` no banco correto e a estrategia de migracao correspondente.
