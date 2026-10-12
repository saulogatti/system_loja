# DTOs and Cache

JSON for import/export and file caching — **not** the store's primary persistence mechanism.

- `lib/data/entry/` — `json_serializable` DTOs
- `lib/data/converter/` — domain ↔ JSON/Drift bridge
- `lib/data/cache/` — file cache and backup
- `lib/data/models/` — supporting persistence models
