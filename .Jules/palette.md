## 24-05-2024 - Adding Context to Destructive Actions in Lists
**Learning:** Screen readers reading raw `IconButton` widgets within lists (like `InvoiceLineTile`) often lack context, simply announcing "button" or repeating an unclear label. Users need to know exactly *what* item is being deleted, not just that a delete button exists.
**Action:** Always wrap `IconButton` instances in lists that perform destructive actions with a `Semantics` widget, providing a specific, contextual label (e.g., `'Remover ${product.name}'`).
