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
