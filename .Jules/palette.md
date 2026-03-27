## 27-03-2024 - Accessible tooltips for destructive list actions
**Learning:** Found that `IconButton` instances in dynamic list tiles (like invoice items) used for destructive actions (e.g., delete) were lacking `tooltip` properties. Without a tooltip, screen readers just announce "button" or the icon name, lacking context of *which* item is affected.
**Action:** Always provide context-aware tooltips for destructive actions inside lists (e.g. `tooltip: 'Remover ${item.name}'`) to ensure screen reader users have clear feedback on the exact item they are modifying or deleting.
