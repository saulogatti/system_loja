# AGENTS.md

## Instruções do ambiente (Cursor Cloud)

As instruções canônicas do workspace ficam em `.github/copilot-instructions.md`.
Este arquivo permanece apenas como complemento de ambiente para execução em Linux no Cursor Cloud.

## Pré-requisitos

- **Constraint do app** (`pubspec.yaml`): Flutter `>=3.47.0`, Dart SDK `>=3.13.0 <4.0.0`.
- No snapshot Cloud, a ferramenta instalada pode diferir da constraint; use `flutter --version` e alinhe ao `pubspec` antes de builds/testes.
- Dependências Linux desktop: `libgtk-3-dev`, `ninja-build`, `libsqlite3-dev`, `clang`, `cmake`, `pkg-config`.

## Comandos rápidos

- Instalar dependências: `flutter pub get`
- Codegen: `dart run build_runner build`
- Lint: `dart analyze`
- Verificar formatação: `dart format --set-exit-if-changed .`
- Testes: `flutter test`
- Documentação da API: `dart doc -o docs/`
- Run web server: `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
- Run linux: `flutter run -d linux`
- Listar devices: `flutter devices`

## Referências

- Regras gerais de arquitetura e convenções: `.github/copilot-instructions.md`
- Regras específicas do projeto: `flutter_rules.md`
- Guia de contribuição: `CONTRIBUTING.md`
- Visão geral e comandos: `README.md`
- Padrões Dart por arquivo: `.github/instructions/dartcode.instructions.md`
