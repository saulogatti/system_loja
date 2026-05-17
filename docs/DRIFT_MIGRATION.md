# DRIFT_MIGRATION

## Visao Geral

Este documento consolida orientacoes de migracao de schema Drift no System Loja.

## Estado Atual dos Bancos

- `AppDatabase`: `schemaVersion => 12`
- `SystemDatabase`: `schemaVersion => 1`

## Quando criar migracao

Crie ou ajuste migracao sempre que houver alteracao em:

- tabelas Drift (`lib/data/database/table/`)
- DAOs (`lib/data/database/dao/`)
- relacionamentos/constraints
- tipos persistidos por converter/custom type

## Processo Recomendado

1. Atualizar tabela(s) e/ou DAO(s).
1. Incrementar `schemaVersion` no banco correto.
1. Implementar `onUpgrade` com os passos de migracao necessarios.
1. Gerar codigo:

```bash
dart run build_runner build --delete-conflicting-outputs
```

1. Validar qualidade:

```bash
dart analyze
flutter test
```

## Boas Praticas

- Manter migracoes pequenas e incrementais.
- Evitar logica de negocio na camada de migracao.
- Preservar dados quando aplicavel; em cenarios pre-producao, breaking changes sao aceitaveis quando alinhados ao time.
- Registrar no PR quais versoes de schema foram alteradas e por que.

## Troubleshooting

### Falha no build_runner

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

### Conflito de schema local

- Remover instalacao local do app para criar banco limpo quando apropriado.
- Confirmar se o `onUpgrade` cobre todos os passos entre versoes.

## Referencias

- `README.md`
- `docs/DRIFT_ARCHITECTURE.md`
- `.github/copilot-instructions.md`
