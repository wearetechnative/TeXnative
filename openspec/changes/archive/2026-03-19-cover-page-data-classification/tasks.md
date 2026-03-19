## 1. Lua Filter — Expose resolved text as metadata

- [x] 1.1 In `texnative_dcl.lua`, set `meta.dcl_cover_text` to the resolved `txt` value when `data_classification_label.level` is set and resolves successfully
- [x] 1.2 Add test for `dcl_cover_text` metadata field being set when level is configured
- [x] 1.3 Add test that `dcl_cover_text` is NOT set when level is not configured

## 2. Cover Page Template — Add classification row

- [x] 2.1 In `partials/page-cover.tex`, add a conditional `$if(dcl_cover_text)$` block after the Version row that renders `{\bf Data Classification:} & $dcl_cover_text$`
- [x] 2.2 Verify rendering with a test document that has both `cover_page: true` and `data_classification_label.level` set
