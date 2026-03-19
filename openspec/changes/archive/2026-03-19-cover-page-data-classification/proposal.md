## Why

When a document has a data classification level configured (e.g., "confidential") and uses a cover page, users expect the classification to be clearly visible on the cover page itself — not just as the overlay label, but as a textual entry in the cover page metadata table. This improves document traceability and meets common compliance formatting requirements.

## What Changes

- Add a "Data Classification" row to the cover page metadata table (in `page-cover.tex`) that displays when both `data_classification_label.level` is set and `cover_page` is enabled
- The row appears below the "Version" row, showing the resolved `txt` value from the active classification level (e.g., "CONFIDENTIAL")
- A Lua filter resolves the classification text and injects it as a metadata field for the LaTeX template to consume

## Capabilities

### New Capabilities

### Modified Capabilities
- `data-classification-label`: Add requirement for displaying classification text on the cover page metadata table when cover page is enabled

## Impact

- `_extensions/texnative/partials/page-cover.tex`: Add conditional row after Version
- `_extensions/texnative/texnative_dcl.lua`: Expose resolved `txt` value as a top-level metadata field for template consumption
