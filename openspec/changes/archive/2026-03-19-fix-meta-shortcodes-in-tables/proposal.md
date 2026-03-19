# Change: Fix Meta Shortcodes in Tables

## Why
Quarto `{{< meta ... >}}` shortcodes resolve correctly in normal text but produce empty/garbled output inside tables. The texnative table filter bypasses Quarto's inline resolution pipeline by replacing entire tables with raw LaTeX blocks, so unresolved shortcode Spans are lost.

## What Changes
- Add a shortcode resolver that re-reads the source `.qmd` file, maps sequential shortcode IDs to their meta paths, and resolves them from document metadata
- Add a `Span` handler in `render_inline_latex()` to detect unresolved Quarto shortcode spans and resolve them via the new resolver
- Guard the date reformatter so it only acts on `YYYY-MM-DD` patterns (prevents errors when `meta.date` contains a shortcode or pre-formatted string)

## Impact
- Affected specs: `table-formatting`
- Affected code: `_extensions/texnative/texnative.lua` (Meta function, shortcode map builder), `_extensions/texnative/texnative_core.lua` (render_inline_latex Span handler)
