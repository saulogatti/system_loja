<!-- TODO: verify whether this documentation is out of date -->
# Flutter Feature Template

Use this template to create a new feature or reorganize a mixed structure.

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

## Notes

- `feature_page.dart` assembles the BLoC and the main composition.
- `feature_view.dart` orchestrates the layout with smaller widgets.
- List items, form sections, and state widgets should be separated when doing so improves readability.
- The BLoC calls use cases and emits explicit UI states.
- The repository interface belongs in the domain; its implementation belongs in the data layer.

## Suggested State Model

- initial
- loading
- success with data
- empty
- error with a message

## Widget-Splitting Rules

Move a widget to a new file when:

- The `build` method becomes difficult to read.
- The widget mixes layout, item rendering, and side effects.
- A section has a clear domain name, such as `FilterBar` or `OrderSummary`.
- The same visual pattern appears in more than one place with minor variations.

## Avoid

- Business rules in widgets.
- Calling repositories directly from the UI.
- A single file containing the page, BLoC, state, event, and many unnecessary helper widgets.
- Creating a reusable abstraction before a second real use case exists.
