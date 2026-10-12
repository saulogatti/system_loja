# AGENTS.md

## Environment instructions (Cursor Cloud)

The canonical workspace instructions are in `.github/copilot-instructions.md`.
This file serves only as supplementary environment guidance for running on Linux in Cursor Cloud.

## Prerequisites

- **App constraints** (`pubspec.yaml`): Flutter `>=3.47.0`, Dart SDK `>=3.13.0 <4.0.0`.
- In the Cloud snapshot, the installed toolchain may differ from these constraints; run `flutter --version` and align it with `pubspec.yaml` before building or testing.
- Linux desktop dependencies: `libgtk-3-dev`, `ninja-build`, `libsqlite3-dev`, `clang`, `cmake`, `pkg-config`.

## Quick commands

- Install dependencies: `flutter pub get`
- Code generation: `dart run build_runner build`
- Lint: `dart analyze`
- Check formatting: `dart format --set-exit-if-changed .`
- Tests: `flutter test`
- API documentation: `dart doc -o docs/`
- Run the web server: `flutter run -d web-server --web-port=8080 --web-hostname=0.0.0.0`
- Run on Linux: `flutter run -d linux`
- List devices: `flutter devices`

## References

- General architecture and conventions: `.github/copilot-instructions.md`
- Project-specific rules: `flutter_rules.md`
- Contribution guide: `CONTRIBUTING.md`
- Overview and commands: `README.md`
- File-specific Dart conventions: `.github/instructions/dartcode.instructions.md`
