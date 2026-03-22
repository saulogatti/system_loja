# Flutter Feature Template

Use this template when creating a new feature or cleaning up a mixed structure.

## Suggested Structure

```text
feature_name/
  presentation/
    bloc/
      feature_bloc.dart
      feature_event.dart
      feature_state.dart
    pages/
      feature_page.dart
    widgets/
      feature_view.dart
      feature_header.dart
      feature_list.dart
      feature_list_item.dart
  domain/
    entities/
      feature_entity.dart
    repositories/
      feature_repository.dart
    usecases/
      get_feature.dart
  data/
    datasources/
      feature_remote_datasource.dart
    models/
      feature_model.dart
    repositories/
      feature_repository_impl.dart
```

## Implementation Notes

- Let `feature_page.dart` provide the bloc and define screen-level composition.
- Let `feature_view.dart` orchestrate the main layout from smaller widgets.
- Keep list items, form sections, and status widgets separated when they can be understood independently.
- Let the bloc call one or more use cases and emit explicit UI states.
- Let repository interfaces live in `domain` and implementations live in `data`.

## Good Default State Shape

Use a state model that makes rendering obvious. For example:

- initial
- loading
- success with data
- empty
- error with message

## Split Rules

Split a widget into a new file when one of these happens:

- The `build` method becomes long enough that scanning it is tiring.
- The widget mixes layout, item rendering, and side effects.
- A subsection has a meaningful name such as `FilterBar` or `OrderSummary`.
- The same visual pattern appears in more than one place with only small differences.

## Avoid

- Business rules inside widgets
- Repositories called directly from UI
- A single file containing page, bloc, state, event, and many helper widgets without a strong reason
- Reusable abstractions created before a second real use case exists
