# Proposal: Add Data Classification Label

## Why

Business documents often require data classification labels to indicate the sensitivity level of the content (e.g., Confidential, Internal, Public). This is a common compliance requirement in many industries. Currently, TeXnative has no built-in support for rendering these labels, forcing users to manually add them or use workarounds.

## What Changes

This proposal adds a new `data_classification_label` option to the TeXnative PDF format that:

1. **Global Configuration** - Define classification levels with their visual styling (background color, text color, label text) in `_quarto.yml` or document frontmatter
2. **Per-Document Level Selection** - Set `data_classification_label.level` to select which predefined level to display
3. **Customizable Positioning** - Configure label dimensions (width, height), position (top, left), text size, and border radius
4. **Page Placement** - Render the label on every page in a fixed position using LaTeX's `tikz` package

### Configuration Structure

```yaml
data_classification_label:
  level: confidential           # Active level for this document
  
  levels:                       # Predefined levels (can be in _quarto.yml)
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL
    public:
      bgcolor: '#70ac45'
      txtcolor: '#000000'
      txt: PUBLIC
  
  # Global styling (can be overridden per-document)
  border-radius: 2pt
  txtsize: small
  width: 40mm
  height: 10mm
  top: 20mm
  left: 20mm
```

## Impact

- **New Capability**: Adds data classification labeling to all TeXnative documents
- **No Breaking Changes**: Feature is opt-in; documents without `data_classification_label.level` render unchanged
- **Dependencies**: Uses existing `tikz` and `xcolor` LaTeX packages (already commonly available)
- **Files Modified**:
  - `_extensions/texnative/_extension.yml` - Add new template-partials entry
  - `_extensions/texnative/partials/data-classification-label.tex` - New partial for label rendering
  - `_extensions/texnative/partials/document-header-footer.tex` - Include label in page header
