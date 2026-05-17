# AGENTS.md

## Instrucoes do ambiente (Cursor Cloud)

As instrucoes canônicas do workspace ficam em `.github/copilot-instructions.md`.
Este arquivo permanece apenas como complemento de ambiente para execução em Linux no Cursor Cloud.

## Pre-requisitos do snapshot

- Flutter 3.41.2 (Dart 3.11.0) em `/opt/flutter/bin` (no `PATH` via `~/.bashrc`).
- Dependencias Linux desktop: `libgtk-3-dev`, `ninja-build`, `libsqlite3-dev`, `clang`, `cmake`, `pkg-config`.

## Comandos rapidos

- Instalar dependencias: `flutter pub get`
- Codegen: `dart run build_runner build --delete-conflicting-outputs`
- Lint: `dart analyze`
- Verificar formatacao: `dart format --set-exit-if-changed .`
- Testes: `flutter test`
- Run web server: `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
- Run linux: `flutter run -d linux`
- Listar devices: `flutter devices`

## Referencias

- Regras gerais de arquitetura e convencoes: `.github/copilot-instructions.md`
- Guia de contribuicao: `CONTRIBUTING.md`
- Visao geral e comandos: `README.md`
- Padrões Dart por arquivo: `.github/instructions/dartcode.instructions.md`
