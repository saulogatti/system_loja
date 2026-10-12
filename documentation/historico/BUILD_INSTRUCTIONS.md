# Build and Validation Instructions

## Overview

This document collects the project's code-generation and validation commands.
Use these instructions after changing classes with `@freezed`, `@JsonSerializable`, Drift (tables/DAOs), or `auto_route` routes.

## Code Generation (Required)

Run this command from the project root:

```bash
dart run build_runner build
```

Files commonly updated by code generation:

- `*.freezed.dart`
- `*.g.dart` (json_serializable and Drift)
- `lib/screens/route/route_app.gr.dart`

## Quality Checks

After code generation, run these checks:

```bash
dart analyze
flutter test
```

To check formatting without changing files:

```bash
dart format --set-exit-if-changed .
```

## Database Reference (Current State)

- `AppDatabase`: `schemaVersion => 12`
- `SystemDatabase`: `schemaVersion => 1`

When changing a Drift schema, update `schemaVersion` in the correct database and update its migration strategy.
