# Guia de Testes - System Loja

## Índice

- [Visão Geral](#visão-geral)
- [Pré-requisitos](#pré-requisitos)
- [Comandos Principais](#comandos-principais)
- [Fluxo Recomendado](#fluxo-recomendado)
- [Execução por Escopo](#execução-por-escopo)
- [Troubleshooting](#troubleshooting)
- [Referências](#referências)

## Visão Geral

Este documento consolida o processo de validação de código para o projeto.
Use este guia após alterações em lógica de negócio, UI, banco Drift, serialização JSON ou rotas.

## Pré-requisitos

Na raiz do repositório, execute:

```bash
flutter pub get
```

Se houver alterações em `@freezed`, `@JsonSerializable`, Drift ou `auto_route`, rode também:

```bash
dart run build_runner build --delete-conflicting-outputs
```

## Comandos Principais

Validação estática:

```bash
dart analyze
```

Verificação de formatação:

```bash
dart format --set-exit-if-changed .
```

Testes:

```bash
flutter test
```

## Fluxo Recomendado

1. Atualize dependências e gere código quando necessário.
2. Execute `dart analyze`.
3. Execute `flutter test`.
4. Rode testes específicos do escopo alterado para acelerar iteração.
5. Em mudanças de persistência, valide migrações e cenários de leitura/escrita.

## Execução por Escopo

Executar um único arquivo de teste:

```bash
flutter test test/<arquivo>_test.dart
```

Executar por pasta:

```bash
flutter test test/screens/
flutter test test/domain/
flutter test test/data/
```

## Troubleshooting

Falha por arquivos gerados desatualizados:

```bash
dart run build_runner clean
dart run build_runner build --delete-conflicting-outputs
```

Falha de ambiente/local cache:

```bash
flutter clean
flutter pub get
```

Observação importante: o repositório pode conter testes com falhas preexistentes fora do escopo da sua alteração. Priorize validar primeiro o escopo alterado antes de tratar falhas legadas.

## Referências

- `README.md`
- `docs/TESTING_VALIDATION.md`
- `docs/BUILD_INSTRUCTIONS.md`
- `.github/copilot-instructions.md`
