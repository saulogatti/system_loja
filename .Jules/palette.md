## 20-06-2024 - Form Text Capitalization Defaults
**Learning:** Forgetting to set `textCapitalization` in form fields leads to unnecessary friction for mobile users filling out names or descriptions.
**Action:** Always set `textCapitalization: TextCapitalization.words` for names/titles and `TextCapitalization.sentences` for multiline descriptions in `TextFormField` to utilize the native OS keyboard's auto-capitalization features.
