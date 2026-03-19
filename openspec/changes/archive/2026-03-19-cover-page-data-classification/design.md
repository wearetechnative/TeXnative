## Context

The cover page template (`page-cover.tex`) renders a metadata table with fields like Client, Author, Date, Version. The DCL Lua filter (`texnative_dcl.lua`) currently resolves the classification level and generates a TikZ overlay label for every page. However, there is no mechanism to show the classification text as a row in the cover page metadata table.

The resolved `txt` value (e.g., "CONFIDENTIAL") is available in the Lua filter but is not exposed as a top-level metadata field that the LaTeX template can access via Pandoc's `$variable$` syntax.

## Goals / Non-Goals

**Goals:**
- Show a "Data Classification" row on the cover page when both `cover_page` and `data_classification_label.level` are set
- The row displays below the Version row using the resolved `txt` value from the active level
- Reuse the existing DCL Lua filter to resolve and expose the value

**Non-Goals:**
- Changing the TikZ overlay label behavior
- Adding classification text to non-cover title pages
- Making the row position configurable (it goes after Version)

## Decisions

**Decision 1: Expose resolved text as `dcl_cover_text` metadata field**

The Lua filter already resolves the level config. We extend it to set `meta.dcl_cover_text` to the resolved `txt` value when `data_classification_label.level` is set. The template can then use `$dcl_cover_text$`.

*Alternative*: Pass the entire level config as metadata — rejected as unnecessary complexity; the template only needs the text string.

**Decision 2: Conditional row in `page-cover.tex` using `$if(dcl_cover_text)$`**

Add a conditional block after the Version row that renders `{\bf Data Classification:} & $dcl_cover_text$` when the metadata field exists. This follows the same pattern as all other conditional rows in the template.

*Alternative*: Use a separate partial template — rejected as over-engineering for a single row.

## Risks / Trade-offs

- [Minimal risk] The metadata field name `dcl_cover_text` could conflict with user-defined metadata → Mitigation: The `dcl_` prefix makes collision unlikely.
- [Trade-off] The row always appears after Version when present; users cannot reorder → Acceptable for now; matches how all other cover page rows work.
