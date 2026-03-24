---
name: flutter-bloc-widget-builder
description: Implement Flutter widgets and feature UI flows with BLoC, clean architecture, and small maintainable components. Use when Codex needs to create or refactor Flutter screens, forms, lists, dialogs, states, or reusable widgets while keeping presentation, domain, and data layers separated, avoiding oversized files, and favoring readable code over clever abstractions.
---

# Flutter Bloc Widget Builder

## Overview

Implement Flutter UI with `bloc` or `flutter_bloc` while keeping the code simple, modular, and aligned with clean architecture. Favor small widgets, predictable state flow, explicit dependencies, and files that are easy to read in isolation.

## Workflow

1. Inspect the existing feature structure before editing.
2. Preserve project conventions when they already match clean architecture.
3. Split the solution into `presentation`, `domain`, and `data` when creating a new feature or when the current structure is unclear.
4. Keep widgets focused on rendering and user interaction.
5. Keep business rules out of widgets and out of `BlocBuilder` callbacks.
6. Extract widgets when a `build` method becomes long, visually dense, or mixes unrelated concerns.
7. Prefer a few clear classes over generic abstractions that make the code harder to follow.
8. Finish by checking whether the UI code, bloc, and data flow can be understood quickly by another engineer.

## Architecture Rules

- Keep `presentation` responsible for pages, widgets, bloc, cubit, events, and states.
- Keep `domain` responsible for entities, repository contracts, and use cases.
- Keep `data` responsible for DTOs, mappers, datasources, and repository implementations.
- Inject dependencies from the outer layer inward.
- Depend on abstractions in `domain`, not concrete implementations from `data`.
- Avoid calling APIs, parsing JSON, or applying business rules directly inside widgets or blocs unless the rule is truly presentation-only.
- Avoid creating a bloc for a purely local ephemeral state if a simpler Flutter mechanism is enough.

## Widget Rules

- Keep each widget with one clear responsibility.
- Extract sections such as header, filters, list item, form body, footer, and empty state into separate widgets when that improves readability.
- Prefer `StatelessWidget` by default.
- Use `StatefulWidget` only for local UI concerns that should not live in the bloc.
- Keep constructor parameters explicit and small.
- Avoid passing the entire bloc state to deeply nested widgets when only one or two fields are needed.
- Avoid giant `build` methods, nested ternaries, and long inline callbacks.
- Reuse widgets only when the reuse is real; do not generalize too early.

## BLoC Rules

- Model states so the UI can render clearly for loading, success, empty, and error cases.
- Keep events and methods intention-revealing.
- Trigger use cases from the bloc, then map the result into presentation state.
- Keep bloc files short and readable; split event, state, and bloc definitions when the file grows too much or the project already follows that style.
- Use `BlocBuilder`, `BlocSelector`, `BlocListener`, and `BlocConsumer` intentionally to reduce unnecessary rebuilds.
- Put navigation, snackbars, dialogs, and one-off effects in listeners or effect handlers, not inside pure render branches.

## Simplicity Heuristics

- Prefer descriptive names over comments.
- Prefer straightforward branching over clever helper layers.
- Prefer one feature-specific widget over a configurable mega-widget.
- Prefer extracting a private widget before extracting utility methods with many parameters.
- If a file feels difficult to scan, split it.
- If a widget needs many booleans to vary behavior, reconsider the design.

## Output Expectations

- Deliver code that is easy to evolve by feature.
- Keep each file narrowly scoped.
- Add brief comments only when the intent is not obvious from the code itself.
- When creating a new feature, mirror the structure in [references/flutter-feature-template.md](references/flutter-feature-template.md).
- When refactoring existing code, improve separation incrementally instead of forcing a full rewrite unless the user asks for it.

## Review Checklist

- Confirm that widgets do not contain domain or data logic.
- Confirm that bloc state models the UI states explicitly.
- Confirm that dependencies flow from presentation to domain abstractions to data implementations.
- Confirm that long widgets were split where it meaningfully improves readability.
- Confirm that the final code is simpler than the starting point.
