## 1. Shortcode Resolution Infrastructure
- [x] 1.1 Add `resolve_meta_path()` to walk dotted paths (e.g. `sla.availability`) through Pandoc metadata
- [x] 1.2 Add `build_shortcode_map()` to parse source `.qmd`, strip fenced code blocks, and assign sequential IDs matching Quarto's numbering
- [x] 1.3 Wire up shortcode map and resolver closure in `Meta()` filter, attaching to `core.shortcode_resolver`

## 2. Span Handler in render_inline_latex
- [x] 2.1 Add `M.shortcode_resolver` field to `texnative_core.lua`
- [x] 2.2 Add `Span` case in `render_inline_latex()` that checks for `__quarto_custom_type == 'Shortcode'` and resolves via `shortcode_resolver`
- [x] 2.3 Handle regular Spans by recursively rendering children
- [x] 2.4 Fallback to `pandoc.utils.stringify` for empty Spans

## 3. Date Formatter Guard
- [x] 3.1 Guard date reformatting in `Meta()` so it only triggers on `YYYY-MM-DD` pattern matches

## 4. Validation
- [x] 4.1 Verify `{{< meta ... >}}` shortcodes render correctly in table cells
- [x] 4.2 Verify shortcodes still work in normal (non-table) text
- [x] 4.3 Verify tables without shortcodes are unaffected
