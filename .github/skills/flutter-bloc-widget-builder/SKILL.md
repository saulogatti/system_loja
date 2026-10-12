---
name: flutter-bloc-widget-builder
description: "Creates and refactors Flutter screens with BLoC/Cubit in System Loja, following Clean Architecture, ResultStatus, and small-widget practices. Use when implementing screens, forms, lists, dialogs, UI states, presentation/domain/data boundaries, or reducing large files without losing readability."
argument-hint: "Describe the screen/flow and expected behavior"
---

# Flutter Bloc Widget Builder

## Objective

Implement and refactor Flutter UI with BLoC/Cubit in the System Loja context, maintaining layer separation, predictable states, and maintainable code.

## When to Use

- Create a new screen with state and events.
- Refactor a large screen into smaller widgets.
- Adjust loading, success, empty, and error flows.
- Migrate UI to follow Clean Architecture boundaries.

## Process

1. Understand the feature flow and identify the required UI states.
2. Check the current feature structure and preserve existing project patterns when appropriate.
3. Define layer boundaries:
   - presentation: screens, BLoC/Cubit, widgets, and UI interactions.
   - domain/core: contracts, entities, and business rules.
   - data: DTOs, Drift, mappers, and persistence.
4. Implement explicit presentation states (loading, success, empty, error).
5. Extract widgets when a `build` method becomes long, dense, or mixes responsibilities.
6. Apply project error-handling and repository rules:
   - repositories return `ResultStatus`.
   - UI/BLoC handles results with `when`/`switch`, without `try/catch` around repository calls.
7. Use GetIt for dependency injection and avoid coupling presentation to concrete implementations.
8. Finish by checking readability and maintainability.

## System Loja-Specific Rules

- Follow Clean Architecture as defined by the workspace instructions.
- Do not put business rules in widgets.
- Do not call DAOs/Drift directly from the presentation layer.
- Avoid generic abstractions until a second concrete use case exists.
- Keep comments concise and in English, adding them only when the intent is not obvious.

## Quality Checklist

- The screen clearly renders loading, success, empty, and error states.
- BLoC/Cubit events and methods have explicit intent.
- Widgets have a single responsibility and clear parameters.
- Dependencies flow from presentation to contracts, not implementations.
- The final result is simpler than the initial state.

## References

- Suggested feature structure: [feature template](references/flutter-feature-template.md)
- Global project rules: `.github/copilot-instructions.md`
