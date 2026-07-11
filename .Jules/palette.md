# Palette of Accessibility Learnings and Actions

## 20-06-2024 - Form Text Capitalization Defaults
**Learning:** Forgetting to set `textCapitalization` in form fields leads to unnecessary friction for mobile users filling out names or descriptions.
**Action:** Always set `textCapitalization: TextCapitalization.words` for names/titles and `TextCapitalization.sentences` for multiline descriptions in `TextFormField` to utilize the native OS keyboard's auto-capitalization features.

## 16-06-2024 - Auto-capitalization in Flutter text fields
**Learning:** `textCapitalization` is an excellent, frequently overlooked micro-UX property in Flutter for mobile devices. Using `TextCapitalization.words` for names/titles and `TextCapitalization.sentences` for multiline descriptions significantly reduces friction by displaying the correct OS keyboard layout automatically, instead of requiring the user to manually trigger the shift key.
**Action:** When implementing or reviewing `TextFormField` widgets, default to applying the appropriate `textCapitalization` based on the context of the field (words for names, sentences for descriptions, characters for codes/acronyms).

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

## 24-04-2026 - Empty States lacking Semantics

**Learning:** Standard "empty state" implementations (e.g., using `SliverToBoxAdapter` + `Center` + `Icon`/`Text`) often lack a unified `Semantics` wrapper, resulting in screen readers either ignoring them entirely or reading them piecemeal without proper context.
**Action:** Always wrap empty state visual components in a `Semantics` widget with an explicit `label` to ensure screen readers provide users with immediate feedback that a list or container is empty.

## 08-04-2026 - Consolidating Empty States Semantics

**Learning:** When creating reusable empty states containing both icons and multiple lines of text, screen readers natively read the elements sequentially and disjointedly. Using `excludeSemantics: true` on a parent `Semantics` wrapper combines the elements into a single cohesive announcement.
**Action:** Use `excludeSemantics: true` in custom reusable widgets (like `EmptyWidget`) alongside an explicit, combined `label` string to prevent redundant readouts for complex states.

## 13-04-2026 - Standardizing Empty States with EmptyWidget

**Learning:** Found that scattered empty states were using custom, complex widget trees (like nested Columns inside Centers and Slivers) with incomplete accessibility semantics, missing `excludeSemantics: true`.
**Action:** Consistently replace these custom visual layouts with the project's standard `EmptyWidget`, which simplifies the widget tree and ensures cohesive screen reader behavior across the app.

## 24-04-2026 - Empty States semantic Label overriding

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

## 24-04-2026 - Address Form Field Flow and Autofill

**Learning:** Address forms containing multiple sequential text fields (like Street, ZIP code, Neighborhood, City) can be tedious to fill manually, especially on mobile devices. If these fields lack `textInputAction: TextInputAction.next`, users are forced to dismiss the keyboard or manually tap the next field. Furthermore, missing `autofillHints` prevents the OS from automatically filling in the user's saved address.
**Action:** Always provide `textInputAction: TextInputAction.next` on all fields of a sequential form except the last one. Additionally, apply appropriate `autofillHints` (e.g., `AutofillHints.streetAddressLine1`, `AutofillHints.postalCode`, `AutofillHints.addressCity`) to address fields to leverage OS-level form filling capabilities.

## 03-05-2026 - Form Field Keyboard UX

**Learning:** Proper use of `keyboardType`, `autofillHints`, and `textInputAction` (especially ending with `TextInputAction.done` linked to `onFieldSubmitted`) drastically reduces friction for users filling out forms, as it keeps their hands on the virtual keyboard instead of requiring them to search for a separate submit button.
**Action:** When creating or modifying forms, always ensure fields flow sequentially via `TextInputAction.next` and end with `TextInputAction.done` that triggers form submission.

## 28-04-2026 - Form Field Keyboard UX

**Learning:** Proper use of `keyboardType`, `autofillHints`, and `textInputAction` (especially ending with `TextInputAction.done` linked to `onFieldSubmitted`) drastically reduces friction for users filling out forms, as it keeps their hands on the virtual keyboard instead of requiring them to search for a separate submit button.
**Action:** When creating or modifying forms, always ensure fields flow sequentially via `TextInputAction.next` and end with `TextInputAction.done` that triggers form submission. Multiline fields should omit `textInputAction` to preserve line break behavior.

## 02-05-2024 - [Visual Affordance in Dialog Lists]

**Learning:** ListTiles inside selection dialogs often look like static data. Without a trailing action icon (like `add_circle_outline` or `chevron_right`), users might not realize the entire row is tappable to make a selection.
**Action:** Always add a trailing icon to ListTiles used for single-item selection in dialogs to provide clear visual interaction cues.

## 03-05-2026 - Affordance in Single-Item Selection Dialogs

**Learning:** ListTiles in dialogs used for single-item selection often lack visual cues that they are tappable. Users might think they need to tap the text precisely or look for a confirmation button that doesn't exist.
**Action:** Always add a trailing icon (like `Icons.add_circle_outline` or `Icons.chevron_right`) to `ListTile` widgets in selection dialogs to provide clear visual affordance and interaction cues indicating the entire row is tappable and will trigger an action.

## 24-05-2024 - [Consolidating Form Actions into Suffix Icons]

**Learning:** Placing field-specific actions (like auto-generating values) in an external IconButton breaks the visual grouping and wastes horizontal space, especially in forms.
**Action:** Always prefer `suffixIcon` in `TextFormField` or `InputDecoration` for actions strictly related to that field. Change the icon color to the primary color to indicate active states (e.g. `color: isActive ? Theme.of(context).colorScheme.primary : null`). Update the `tooltip` to reflect the current state (e.g., "Generate" vs. "Disable generation").

## 05-05-2026 - [Consistent Analytics Empty States]

**Learning:** Found plain Text widgets acting as empty states inside analytics cards (like DonutCard and ProductsCountChartCard) which visually clash with the rest of the application's empty states and lack proper semantics.
**Action:** Use the global EmptyWidget across all analytics and reporting empty states to maintain a11y and visual harmony.

## 06-05-2024 - Missing Semantics on Custom InkWell Components
**Learning:** Custom interactive widgets built directly with `InkWell` (e.g. interactive cards, custom header filters) often lack automatic accessibility attributes, making them opaque to screen readers despite their visual affordance.
**Action:** Always verify that standalone `InkWell` or `GestureDetector` widgets have adequate `Semantics` wrappers. This is especially true for items like `_InvoiceTile` and `_SectionHeader`, ensuring they use `Semantics(button: true, label: '...', excludeSemantics: true)` when visual content needs to be combined into a single accessible node.
## 07-05-2025 - Loading State in Forms
**Learning:** Adding a boolean `isLoading` flag to forms with explicit visual dimming via `enabled: false` on inputs and a `CircularProgressIndicator` on the submit button significantly improves perceived responsiveness and prevents duplicate submissions during asynchronous operations.
**Action:** When creating or updating form widgets that trigger database or API calls, always verify if `BlocBuilder` can be used to pass a loading state into the form to disable fields and show visual feedback on the main action button.

## 25-05-2024 - [Disabling Autocorrect on System Keys]
**Learning:** Text fields intended for exact alphanumeric codes (like license keys or activation tokens) can become highly frustrating if the OS keyboard attempts to autocorrect or suggest dictionary words, potentially altering a valid code right before submission.
**Action:** Always apply `autocorrect: false` and `enableSuggestions: false` to `TextField` or `TextFormField` inputs that handle system keys, tokens, or exact codes.

## 31-05-2026 - Multiline Text Fields Input Constraints
**Learning:** For multiline text fields like descriptions, always use `keyboardType: TextInputType.multiline` to provide proper native keyboard behavior. Without it, the OS keyboard may not show a proper return key or optimize for long-form text entry. Adding a character limit (e.g., `maxLength: 500`) also automatically provides users with a character counter below the field, improving the UX without breaking existing validation logic. Note that missing `maxLines: null` or setting it incorrectly can limit the multiline UX.
**Action:** When updating or creating multiline text fields, ensure both `keyboardType: TextInputType.multiline` and a relevant `maxLength` are set to maximize native keyboard capability and visual feedback.
## 12-06-2024 - Semantic Colors for Destructive Actions
**Learning:** Hardcoded colors like `Colors.red` for delete actions violate theme support (especially dark mode) and standard accessibility patterns.
**Action:** Always use `Theme.of(context).colorScheme.error` for destructive actions and `Theme.of(context).colorScheme.primary` for standard actions to ensure consistent, theme-aware visual feedback.
## 06-06-2026 - Explicit Semantics for InkWell widgets
**Learning:** Custom interactive widgets built directly with InkWell or GestureDetector may not implicitly expose themselves as buttons to screen readers, especially when other widgets (like Tooltip) try to exclude semantics. Relying entirely on inner hints or implicit states can lead to incomplete accessibility contexts.
**Action:** Always verify that interactive container widgets like InkWell are properly wrapped in Semantics with `button: true` explicitly set, particularly when complex widget trees or semantic exclusions are involved.
## 15-06-2026 - Button Contrast with Semantic Backgrounds
**Learning:** When explicitly setting `backgroundColor` on buttons like `ElevatedButton` to semantic colors (e.g. `Theme.of(context).colorScheme.error`), the button text might lack sufficient contrast if the `foregroundColor` isn't updated simultaneously.
**Action:** Always provide the corresponding `foregroundColor` (e.g. `Theme.of(context).colorScheme.onError`) when overriding a button's `backgroundColor` to maintain accessible text contrast.
## 22-06-2026 - Auto-capitalization for Names and Descriptions
**Learning:** Setting `textCapitalization: TextCapitalization.words` on name fields and `textCapitalization: TextCapitalization.sentences` on descriptions reduces friction by automatically capitalizing inputs, while correctly setting `keyboardType: TextInputType.multiline` improves the native keyboard interface for long-form inputs.
**Action:** Always include appropriate `textCapitalization` alongside `keyboardType` properties (like `TextInputType.multiline`) for text fields dealing with proper nouns or natural language.
## 18-06-2026 - [Merge Semantics for Complex Analytics Cards]
**Learning:** Complex layout elements presenting statistical data, like summary cards or custom bar charts built with primitive widgets (Columns, Texts, CustomPaints), cause screen readers to read scattered, individual pieces of text and formatting out of context.
**Action:** Use `Semantics(container: true, excludeSemantics: true, label: '[Cohesive summary]')` to merge multi-widget components into a single, cohesive, properly contextualized accessibility node.
## 24-06-2026 - Enhancing Form Field UX with TextCapitalization
**Learning:** Text inputs capturing user names or multi-line descriptions often require manual capitalization, increasing typing friction and hindering the user flow. Using native keyboard support to auto-capitalize correctly enhances the feeling of polish.
**Action:** Always provide `textCapitalization: TextCapitalization.words` for proper nouns (like item names, categories, and people) and `textCapitalization: TextCapitalization.sentences` for multiline descriptions or notes, letting the system keyboard do the heavy lifting automatically.
## 24-06-2026 - Balanced Form Actions and Secondary Button Styling\n**Learning:** Hardcoding `ElevatedButton` with a grey background for secondary actions like "Cancelar" creates visual imbalance and violates standard Material guidelines. Furthermore, when form footers lack equal spacing (e.g. not wrapping actions in `Expanded`), it breaks the aesthetic rhythm of the form.\n**Action:** Use `OutlinedButton` for secondary/cancel actions. Always wrap grouped form actions (like Save and Cancel) in `Expanded` widgets within a `Row` to ensure equal width distribution, resulting in a cleaner and more professional UI.
## 26-06-2024 - Auto-expanding Multiline Text Fields

**Learning:** Forcing multiline fields like "descriptions" to a fixed `maxLines` limits the input area and forces users to scroll within a small box. Using `minLines` together with `maxLines: null` makes the field auto-expand gracefully as the user types, improving native-like form usability.
**Action:** When working with description fields or similar multiline inputs, pair `keyboardType: TextInputType.multiline` with `minLines: 3` and `maxLines: null` for a better typing experience without eating up screen space when empty.
## 29-06-2026 - Missing Interactive Actions in Semantics
**Learning:** When wrapping interactive widgets (like `ListTile` with `onTap`) in a `Semantics` widget and using `excludeSemantics: true` to provide a consolidated accessibility label, the semantic actions (like the tap action) of the child are stripped from the accessibility tree. This breaks screen reader interaction and keyboard navigation (Tab/Enter) on Flutter Web/Desktop.
**Action:** Always redefine interaction properties (e.g., `onTap`, `onTapHint`, `onLongPress`) directly on the `Semantics` widget when using `excludeSemantics: true` around interactive child widgets.
## 12-07-2026 - Standardizing Semantics for Interactive List Items
**Learning:** Wrapping interactive list items (like logs with an `onTap` dialog) inside `Semantics(excludeSemantics: true)` consolidates screen reader reading, but it strips the inner `onTap` from the accessibility tree, breaking screen reader interactivity if the callback is not explicitly provided to the `Semantics` node.
**Action:** Always extract the interaction logic (e.g., a local function `showDialog`) and assign it to BOTH the inner widget's `onTap` and the parent `Semantics` widget's `onTap` property. Ensure `button: true` and a helpful `onTapHint` are also defined on the `Semantics` node.
## 03-07-2024 - Semantic Wrapper Interaction Fix
**Learning:** When using `Semantics(excludeSemantics: true)` around an interactive composite widget (like `Card` containing an `InkWell`), any native semantic actions are dropped. To preserve accessibility, `onTap` and `onTapHint` must be explicitly declared directly on the `Semantics` widget itself.
**Action:** Always replicate `onTap` functionality and provide a clear `onTapHint` in the `Semantics` properties when wrapping custom clickable widgets to ensure full screen reader support.
## 25-07-2024 - [Visual Affordance on Interactive List Items]
**Learning:** When using `ListTile` widgets for interactive elements (e.g., selection dialogs, navigation, or opening bottom sheets), relying solely on the `onTap` property and implicit interaction (like Ink ripples) may not be enough visual affordance for users to realize the entire row is tappable.
**Action:** Always add a trailing icon (like `Icons.add_circle_outline` for selection or `Icons.chevron_right` for details/navigation) to provide clear visual affordance indicating the row is tappable.
