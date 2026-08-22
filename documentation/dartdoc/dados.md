# DTOs e cache

JSON para importação/exportação e cache em arquivo — **não** é a persistência principal da loja.

- `lib/data/entry/` — DTOs `json_serializable`
- `lib/data/converter/` — ponte domínio ↔ JSON/Drift
- `lib/data/cache/` — cache e backup de arquivos
- `lib/data/models/` — modelos de persistência auxiliares
