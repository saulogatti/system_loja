# Testing Guide - System Loja

## Contents

- [Overview](#overview)
- [Prerequisites](#prerequisites)
- [Main Commands](#main-commands)
- [Recommended Workflow](#recommended-workflow)
- [Running Tests by Scope](#running-tests-by-scope)
- [Troubleshooting](#troubleshooting)
- [References](#references)

## Overview

This document summarizes the project's code validation process.
Use this guide after changes to business logic, the UI, the Drift database, JSON serialization, or routes.

## Prerequisites

From the repository root, run:

```bash
flutter pub get
```

If you changed `@freezed`, `@JsonSerializable`, Drift, or `auto_route`, also run:

```bash
dart run build_runner build
```

## Main Commands

Static analysis:

```bash
dart analyze
```

Formatting check:

```bash
dart format --set-exit-if-changed .
```

Tests:

```bash
flutter test
```

## Recommended Workflow

1. Update dependencies and generate code when needed.
2. Run `dart analyze`.
3. Run `flutter test`.
4. Run tests for the changed scope to iterate faster.
5. For persistence changes, validate migrations and read/write scenarios.

## Running Tests by Scope

Run a single test file:

```bash
flutter test test/<file>_test.dart
```

Run tests in a directory:

```bash
flutter test test/screens/
flutter test test/domain/
flutter test test/data/
```

## Troubleshooting

Failure caused by outdated generated files:

```bash
dart run build_runner clean
dart run build_runner build
```

Environment or local cache failure:

```bash
flutter clean
flutter pub get
```

Important: the repository may contain pre-existing test failures outside the scope of your changes. Validate the changed scope first before addressing legacy failures.

## References

- `README.md`
- `documentation/TESTING_VALIDATION.md`
- `documentation/historico/BUILD_INSTRUCTIONS.md`
- `.github/copilot-instructions.md`
