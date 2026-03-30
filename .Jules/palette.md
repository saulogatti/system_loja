## 26-03-2026 - [Merging Semantics in Complex Cards]
**Learning:** In complex Flutter list items like `InvoiceCard` containing multiple text elements, screen readers natively read every text separately, causing excessive swipes for users to get context.
**Action:** Use a `Semantics` wrapper around the container with `excludeSemantics: true` and provide a comprehensive `label` that concatenates the most relevant information for quick context.
