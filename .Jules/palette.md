## 24-05-2024 - Adding Context to Destructive Actions in Lists
**Learning:** Screen readers reading raw `IconButton` widgets within lists (like `InvoiceLineTile`) often lack context, simply announcing "button" or repeating an unclear label. Users need to know exactly *what* item is being deleted, not just that a delete button exists.
**Action:** Always wrap `IconButton` instances in lists that perform destructive actions with a `Semantics` widget, providing a specific, contextual label (e.g., `'Remover ${product.name}'`).
## 27-03-2024 - Accessible tooltips for destructive list actions
**Learning:** Found that `IconButton` instances in dynamic list tiles (like invoice items) used for destructive actions (e.g., delete) were lacking `tooltip` properties. Without a tooltip, screen readers just announce "button" or the icon name, lacking context of *which* item is affected.
**Action:** Always provide context-aware tooltips for destructive actions inside lists (e.g. `tooltip: 'Remover ${item.name}'`) to ensure screen reader users have clear feedback on the exact item they are modifying or deleting.
## 26-03-2026 - [Merging Semantics in Complex Cards]
**Learning:** In complex Flutter list items like `InvoiceCard` containing multiple text elements, screen readers natively read every text separately, causing excessive swipes for users to get context.
**Action:** Use a `Semantics` wrapper around the container with `excludeSemantics: true` and provide a comprehensive `label` that concatenates the most relevant information for quick context.
## 01-04-2026 - Missing Tooltips on Custom IconButtons
**Learning:** Custom interactive widgets, specifically icon-only `IconButton`s, frequently lack semantics or `tooltip` properties in this codebase, which severely impacts screen reader accessibility and desktop hover states.
**Action:** Always review newly added or existing icon-only buttons for `tooltip` properties to ensure a11y compliance, applying `tooltip` to all `IconButton`s as standard practice.

## 25-10-2023 - Empty States lacking Semantics
**Learning:** Standard "empty state" implementations (e.g., using `SliverToBoxAdapter` + `Center` + `Icon`/`Text`) often lack a unified `Semantics` wrapper, resulting in screen readers either ignoring them entirely or reading them piecemeal without proper context.
**Action:** Always wrap empty state visual components in a `Semantics` widget with an explicit `label` to ensure screen readers provide users with immediate feedback that a list or container is empty.
## 07-04-2026 - [Unified Empty States]
**Learning:** Wrapping complex empty state widgets (containing both icons and text) in a `Semantics` widget with `excludeSemantics: true` prevents screen readers from reading each element individually. This creates a unified, cleaner auditory experience.
**Action:** Use a reusable `EmptyWidget` with properly configured `Semantics` properties for all empty states to ensure consistent accessibility across the application.

## $(date +%d-%m-%Y) - Empty States lacking Semantics
**Learning:** Standard "empty state" implementations (e.g., using `SliverToBoxAdapter` + `Center` + `Icon`/`Text`) often lack a unified `Semantics` wrapper, resulting in screen readers either ignoring them entirely or reading them piecemeal without proper context.
**Action:** Always wrap empty state visual components in a `Semantics` widget with an explicit `label` to ensure screen readers provide users with immediate feedback that a list or container is empty.

## 08-04-2026 - Consolidating Empty States Semantics
**Learning:** When creating reusable empty states containing both icons and multiple lines of text, screen readers natively read the elements sequentially and disjointedly. Using `excludeSemantics: true` on a parent `Semantics` wrapper combines the elements into a single cohesive announcement.
**Action:** Use `excludeSemantics: true` in custom reusable widgets (like `EmptyWidget`) alongside an explicit, combined `label` string to prevent redundant readouts for complex states.

## 13-04-2026 - Standardizing Empty States with EmptyWidget
**Learning:** Found that scattered empty states were using custom, complex widget trees (like nested Columns inside Centers and Slivers) with incomplete accessibility semantics, missing `excludeSemantics: true`.
**Action:** Consistently replace these custom visual layouts with the project's standard `EmptyWidget`, which simplifies the widget tree and ensures cohesive screen reader behavior across the app.
## $(date +%d-%m-%Y) - Empty States semantic Label overriding
**Learning:** Utilizing a generic empty state widget can cause regressions in accessibility if the generic widget does not expose a way to inject specific semantic labels (e.g. replacing a fully customized empty state containing specific Semantics).
**Action:** The reusable `EmptyWidget` was updated to accept an optional `semanticLabel` parameter, which it then uses in its parent `Semantics` widget. Use this parameter whenever replacing a custom empty state that previously provided specifically tailored accessibility context.
## 14-04-2026 - Consolidating Reports Empty States Semantics
**Learning:** Previously, standard text-only empty states in reports lacked proper accessibility and consistency. Implementing the centralized EmptyWidget unifies the visual language and ensures that screen readers receive well-formatted and contextual semantics via excludeSemantics.
**Action:** Favor replacing custom local empty state widgets with the global EmptyWidget throughout the application to enforce accessibility and visual consistency.
## 19-04-2026 - Accessibility Regression with excludeSemantics
**Learning:** When wrapping widgets with `Semantics` to provide custom labels, using `excludeSemantics: true` on parent containers (like Cards or interactive Charts) is dangerous because it hides all meaningful child data from screen readers. In a donut chart card, doing this made the button read 'Ampliar gráfico de distribuição' but prevented the user from hearing the actual financial totals displayed inside the card.
**Action:** Use `hint` instead of `label` on the `Semantics` widget when adding context to an interactive container that already contains meaningful text, and NEVER use `excludeSemantics: true` unless you specifically want to hide ALL child semantics.
## 18-04-2026 - Redundant Semantics/Tooltip Wrappers on IconButton
**Learning:** Found that `IconButton` instances were sometimes wrapped explicitly in `Semantics` or `Tooltip` widgets to provide screen reader labels. This causes screen readers to double-read the button context or adds redundant widget nesting, since `IconButton` automatically provides accessibility semantics via its built-in `tooltip` property.
**Action:** Always prefer setting the `tooltip` property directly on `IconButton` instead of wrapping it in a `Semantics` or `Tooltip` widget, to keep the widget tree clean and prevent duplicate screen reader announcements.
## 24-05-2024 - [Fixed EmptyWidget Accessibility Regression]
**Learning:** Using `excludeSemantics: true` on a parent `Semantics` node that contains interactive children (like `action` buttons in `EmptyWidget`) completely hides those interactive elements from screen readers, creating a critical accessibility blocker.
**Action:** Apply `excludeSemantics: true` selectively only to the non-interactive informational content (text/icons) while leaving interactive children (buttons) outside the exclusion wrapper so they remain focusable and readable.
