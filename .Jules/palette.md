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
## 12-05-2024 - [Symmetrical Dialog Actions Constraints]
**Learning:** When arranging action buttons symmetrically inside a Flutter `AlertDialog`'s `actions` list using a `Row` and `Expanded` widgets, a `RenderFlex` exception can occur. This is because the default `OverflowBar` used internally for actions lacks explicit width constraints.
**Action:** Always wrap the `Row` containing the `Expanded` buttons in a `SizedBox(width: double.maxFinite)` to provide the necessary constraints and prevent the exception.

## 25-10-2023 - CardListItem Accessibility
**Learning:** Reusable card list items built around `ListTile` often cause disjointed reading experiences for screen reader users because the title and subtitle are read separately, and the touch target doesn't clearly convey its action.
**Action:** When wrapping a `ListTile` with `Semantics` to consolidate information using `excludeSemantics: true`, always extract the interaction callback (`onTap`) and assign it to BOTH the `Semantics` node and the inner `ListTile` to ensure the action is accessible while preserving native visual feedback (InkWell ripple). Use a descriptive `label` that combines the relevant text fields, set `button: true`, and provide an `onTapHint`.

## 25-10-2023 - Interactive Semantics with Trailing Actions
**Learning:** Using `excludeSemantics: true` on a parent `Semantics` widget effectively hides all inner semantics. If the widget contains multiple distinct semantic actions (e.g., a tap for details, and a trailing `IconButton` for deletion), the `excludeSemantics: true` approach breaks the secondary actions.
**Action:** When a composite widget needs to consolidate some text but preserve independent inner actions (like an `IconButton`), do not use `excludeSemantics: true` on the parent. Instead, use `MergeSemantics` at the root, provide the primary `label` and `onTap` on the main `Semantics` node, and selectively wrap the text elements in `ExcludeSemantics` while leaving the trailing interactive elements (like buttons) untouched.

## 25-10-2023 - Semantics Targeting in ListTiles
**Learning:** Wrapping a `ListTile` completely in `MergeSemantics` or `excludeSemantics` can inadvertently break independent interactive elements within the tile (like a trailing delete button).
**Action:** When a `ListTile` needs its text consolidated for screen readers but also contains independent actions (like an `IconButton`), do not wrap the entire tile in `Semantics`. Instead, wrap the primary text (usually the `title`) in `Semantics(label: ...)` to provide the full context, and wrap the auxiliary text (`subtitle`, `leading`) in `ExcludeSemantics`. This keeps the tile's main tap area and trailing buttons accessible and independent.
## 17-07-2024 - Active state feedback in selection dialogs
**Learning:** When users make a selection in dialogs, relying only on changing the internal state without clear visual feedback in the dialog itself makes it hard to remember the current selection, and missing `selected: true` in semantics hides this from screen readers.
**Action:** Always wrap `SimpleDialogOption` in `Semantics(selected: isSelected)` and add visual cues like bold text, active border colors, and a trailing checkmark for the currently selected item.
## 25-10-2023 - Interactive Semantics with Trailing Actions (Reviewed)
**Learning:** Using `excludeSemantics: true` on a parent `Semantics` widget effectively hides all inner semantics. If the widget contains multiple distinct semantic actions (e.g., a tap for details, and a trailing `IconButton` for deletion), the `excludeSemantics: true` approach breaks the secondary actions.
**Action:** When a composite widget needs to consolidate some text but preserve independent inner actions (like an `IconButton`), do not use `excludeSemantics: true` on the parent. Instead, use `ExcludeSemantics` on the specific child elements to hide them, and use a `Semantics` widget with a combined label on a primary text element to provide the full context, leaving the independent interactive elements untouched.

## 20-07-2026 - Semantic System Error Theme Color
**Learning:** Hardcoding `Colors.red` for destructive actions or error states violates system theme consistency, specifically failing to adapt cleanly to dark mode, and missing the necessary foreground contrast color for accessible button text.
**Action:** Always use `Theme.of(context).colorScheme.error` instead of hardcoding red. For filled buttons (like `ElevatedButton`) that override the `backgroundColor` with the error theme, always pair it with `foregroundColor: Theme.of(context).colorScheme.onError` to guarantee accessible text contrast.

## 21-07-2024 - [Local Form Loading States in Dialogs]
**Learning:** Flutter `AlertDialog`s do not automatically rebuild when the underlying screen's BLoC state changes, making it hard to provide visual loading feedback (like a disabled button and spinner) during async actions like form submissions.
**Action:** A reusable UX pattern is to instantiate a local `ValueNotifier<bool>(false)` inside the dialog's builder method and wrap the dialog's actions in `ValueListenableBuilder`s. This provides immediate, localized visual feedback and prevents duplicate submissions without needing a separate StatefulWidget.

## 24-07-2026 - Accessible Text Contrast
**Learning:** Hardcoded colors like `Colors.grey` or `Colors.grey[600]` fail contrast requirements in dark mode and break the app's visual consistency.
**Action:** Always use `Theme.of(context).colorScheme.onSurfaceVariant` or `outlineVariant` for secondary text, icons, and borders to ensure they adapt automatically to light/dark themes and maintain proper contrast.

## 25-07-2026 - Trailing Chevron on ListTiles
**Learning:** Interactive `ListTile`s intended for navigation or dialog-opening lack visual interaction affordance if they are missing a trailing icon, even if they have an `onTap` property. This reduces the intuitive usability of the interface for touch interaction and visually separates them from other standard ListTiles that have chevrons.
**Action:** Add `trailing: Icon(Icons.chevron_right)` to interactive `ListTile`s (like 'Limpar logs', 'Realizar backup', or theme color selection) to provide a clear, universally understood visual cue that the row is tappable and will result in an action/navigation.

## 27-07-2024 - [AutoValidateMode Form UX]
**Learning:** Relying on default form validation behavior forces users to wait until submission to see errors, reducing confidence and form completion speed.
**Action:** Use `autovalidateMode: AutovalidateMode.onUserInteraction` on `Form` widgets to provide immediate visual feedback on validation errors as the user interacts with the fields.

## 28-07-2026 - Consolidating Key-Value Reading in Data Rows
**Learning:** When displaying information rows that present a key and a value separately in the UI (e.g., in a `Row` with a label and its corresponding text), screen readers often read them disjointedly. This forces the user to navigate twice to understand the relationship.
**Action:** Use `Semantics(label: '$label: $value', excludeSemantics: true)` around the structural widget (like `Row`) containing the pair. This merges the information into a single cohesive spoken announcement for screen readers.
## 06-08-2026 - [Placeholder Text Accessibility]
**Learning:** Missing placeholder (hint) text in TextFields reduces form usability by forcing users to guess the expected data format. While labelText identifies the field, hintText provides a concrete example.
**Action:** Always include a 'hintText' in the InputDecoration of TextFields (e.g., 'Ex: João da Silva') to improve data entry clarity and screen reader context.
## 24-05-2024 - Contextual Hints in Forms
**Learning:** Users often hesitate when filling out abstract form fields (like codes or names). Missing placeholder (hintText) text in TextFields reduces form usability.
**Action:** Always include `hintText` with concrete examples (e.g., 'Ex: Smartphone') in `TextFormField` widgets alongside `labelText` to guide user input.
## 07-08-2026 - [Form Input Guidance]
**Learning:** While `labelText` identifies a field's purpose, omitting `hintText` in `TextFormField`s leaves users guessing the expected format or level of detail (e.g., whether to include prefixes in codes or how descriptive to be). This increases friction in data entry.
**Action:** Always include a contextual `hintText` providing a concrete example (e.g., 'Ex: Smartphone', 'Ex: PROD-001') within the `InputDecoration` of form fields to improve usability and reduce cognitive load.
## 10-08-2026 - Trailing Chevron Affordance on Log System ListTiles
**Learning:** Found that the interactive `ListTile` for system error logs lacked a trailing visual cue, making it unclear to users that the row could be tapped to reveal full error details via a dialog.
**Action:** Consistently apply `trailing: const Icon(Icons.chevron_right)` to `ListTile`s designed for opening dialogs or navigating, particularly in technical sections like log analysis, to provide immediate visual interaction affordance.
## 12-08-2024 - [Consistent Hint Text in Dialogs and Specialized Fields]
**Learning:** Missing placeholder (hint) text in `TextFormField`s within dialogs (like `InvoiceQuantityDialog`) or specialized input fields (like `InvoiceNumberField`) forces users to guess the expected data format. While `labelText` identifies the field's purpose, omitting `hintText` leaves users without a concrete example, increasing friction in data entry.
**Action:** Always include a contextual `hintText` providing a concrete example (e.g., 'Ex: 1', 'Ex: 123456') within the `InputDecoration` of all form fields, including those in dialogs and specialized components, to improve usability and reduce cognitive load.
## 25-10-2026 - [Form Loading State in BottomSheets/Dialogs]
**Learning:** Re-evaluating form submission within Flutter dialogs reveals a common pain point: state changes from cubits or outer contexts do not easily refresh the inner UI of a , often leaving action buttons enabled during submission or lacking visual progress indicators, causing double-submissions.
**Action:** Always extract an isolated local state for dialog submissions using `final isSubmitting = ValueNotifier<bool>(false);`. Wrap action buttons (like 'Criar', 'Cancelar') inside a `ValueListenableBuilder<bool>`, disable them when `loading` is true, and conditionally swap the action label with a `CircularProgressIndicator`. Ensure `isSubmitting.dispose()` is called after the `showDialog` completes.
## 25-10-2026 - [Form Loading State in BottomSheets/Dialogs]
**Learning:** Re-evaluating form submission within Flutter dialogs reveals a common pain point: state changes from cubits or outer contexts do not easily refresh the inner UI of a `showDialog`, often leaving action buttons enabled during submission or lacking visual progress indicators, causing double-submissions.
**Action:** Always extract an isolated local state for dialog submissions using `final isSubmitting = ValueNotifier<bool>(false);`. Wrap action buttons (like 'Criar', 'Cancelar') inside a `ValueListenableBuilder<bool>`, disable them when `loading` is true, and conditionally swap the action label with a `CircularProgressIndicator`. Ensure `isSubmitting.dispose()` is called after the `showDialog` completes.

## 25-10-2026 - [Global Form Guidance with hintText]
**Learning:** Found multiple specialized and auto-generated fields (like Name, CNPJ, and Config properties) where `labelText` correctly labeled the input but failed to provide an example using `hintText`. This creates a poor UX because it leaves users wondering about formatting, especially for system parameters like "Período padrão".
**Action:** Consistently enforce the presence of `hintText: 'Ex: [Value]'` in the `InputDecoration` across ALL editable text fields within the app to reduce cognitive load and enhance form usability.
## 26-10-2026 - [Data Visualization Screen Reader Consolidation]
**Learning:** Adding a `Semantics(button: true)` to an interactive chart (like `SalesPurchaseDonutCard`) allows it to be tapped via accessibility tools, but if it lacks `container: true`, `excludeSemantics: true` and a comprehensive `label`, the screen reader will disjointedly read every nested text element (e.g., labels, values, percentages) instead of treating the chart as a single cohesive unit.
**Action:** When making complex data visualizations (like summary cards or custom charts) accessible, wrap them in a `Semantics(container: true, excludeSemantics: true, label: '...')` widget providing a comprehensive, merged label that describes all the meaningful child data. This merges the multiple widget components into a single cohesive node and prevents screen readers from disjointedly reading individual visual elements.
## 19-08-2024 - [Text Capitalization for Measurement Units]
**Learning:** Text fields intended for standard abbreviations (like measurement units: UN, KG, CX) often lack formatting enforcement, forcing users to manually capitalize their input or resulting in visually inconsistent data.
**Action:** Always apply `textCapitalization: TextCapitalization.characters` to `TextField`s or `TextFormField`s that are meant for abbreviations or codes to improve data entry consistency and reduce user friction.

## 26-10-2026 - [Trailing Chevron Affordance in Dialogs]
**Learning:** Found that interactive `ListTile`s used for item selection within dialogs (like product selection for an invoice) lack visual interaction affordance if they only have a state icon (like a stock warning). Users might not immediately realize the row is tappable to make a selection.
**Action:** Always append a trailing chevron (`Icon(Icons.chevron_right)`) alongside other state icons within a `Row(mainAxisSize: MainAxisSize.min)` on interactive `ListTile`s in selection dialogs to provide clear, consistent navigation/selection cues.

## 24-08-2026 - [Consolidating Data Row Reading in Invoice Bottom Sheet]
**Learning:** When displaying dynamic data lists (like invoice items) or simple key-value pairs in a BottomSheet, failing to wrap the structural  with merged Semantics causes screen readers to disjointedly announce the quantity, pause, announce the name, pause, and then the total, frustrating the user.
**Action:** Use `Semantics(label: '$label: $value', excludeSemantics: true)` around the structural `Row` to consolidate the information into a single cohesive spoken announcement for screen readers. Apply this pattern to any repeating list of data rows or key-value summary rows.

## 24-08-2026 - [Consolidating Data Row Reading in Invoice Bottom Sheet]
**Learning:** When displaying dynamic data lists (like invoice items) or simple key-value pairs in a BottomSheet, failing to wrap the structural row with merged Semantics causes screen readers to disjointedly announce the quantity, pause, announce the name, pause, and then the total, frustrating the user.
**Action:** Use Semantics(label: '$label: $value', excludeSemantics: true) around the structural row to consolidate the information into a single cohesive spoken announcement for screen readers. Apply this pattern to any repeating list of data rows or key-value summary rows.

## 26-08-2026 - [SegmentedButton Tooltips]
**Learning:** ButtonSegments within SegmentedButton widgets often rely solely on their label or icon to convey meaning, which can be insufficient for screen readers or when icons are ambiguous. Unlike IconButtons, ButtonSegments do not have a default tooltip behavior.
**Action:** Always provide a descriptive `tooltip` property to `ButtonSegment` widgets to enhance accessibility context and provide helpful hover text for desktop/web users.
## 25-10-2026 - [Form Input Guidance - HelperText vs HintText]
**Learning:** Found that some form fields (like Price and Stock in ProductForm) used `helperText` to show input examples. This unnecessarily consumes vertical space below the field and clutters the UI before the user even interacts with it.
**Action:** Consistently use `hintText` instead of `helperText` for input examples (like 'Ex: 10,50') across form fields to save vertical space and provide the example exactly where the user is typing.

## 28-10-2026 - [Screen Reader Consolidation in Custom Report Cards]
**Learning:** Found that custom reporting cards containing visual hierarchies (e.g., `Icon`, `Text` for title, `Text` for value, `Text` for quantity inside a `Card` or `Row`) are announced by screen readers as completely separate items. For instance, reading "Entradas", pause, "R$ 1500.00", pause, "5 notas". This severely degrades accessibility.
**Action:** Always wrap the root `Card` or container in custom reporting widgets (like `_ResumoCard` or `_SummaryLine`) with `Semantics(container: true, excludeSemantics: true, label: '$titulo: R\$ $valor. $quantidade notas')` to consolidate all visual data into one cohesive sentence for screen readers.
## 04-09-2026 - [Form Input Guidance - HelperText vs HintText]
**Learning:** Consolidating form guidance examples from `helperText` into `hintText` improves UX by keeping input examples exactly where the user will type and saves vertical space in forms.
**Action:** Consistently use `hintText` for input examples across form fields, removing redundant `helperText` instances when they serve the exact same purpose.
