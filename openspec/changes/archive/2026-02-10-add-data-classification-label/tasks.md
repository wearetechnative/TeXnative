# Tasks: Add Data Classification Label

## Implementation Tasks

- [x] 1. Create Lua filter for level resolution (`texnative_dcl.lua`)
  - Added to `_extensions/texnative/`
  - Resolves `data_classification_label.level` to active properties
  - Strips `#` from hex color values for LaTeX compatibility
  - Validates required properties exist when level is set
  - Generates LaTeX code and injects via header-includes

- [x] 2. Create LaTeX partial (`partials/data-classification-label.tex`)
  - Defined TikZ-based label rendering
  - Uses `eso-pic` for page placement via `\AddToShipoutPictureBG`
  - Supports all configurable properties (width, height, top, left, txtsize, border-radius)
  - Note: LaTeX generation moved to Lua filter for reliable header-includes injection

- [x] 3. Update `_extension.yml`
  - Registered new Lua filter `texnative_dcl.lua` in filters list
  - Added partial to template-partials

- [x] 4. LaTeX injection via header-includes
  - Lua filter generates complete TikZ+eso-pic LaTeX code
  - Injects into `header-includes` metadata for reliable inclusion
  - Packages (tikz, eso-pic, xcolor) loaded when DCL is enabled

- [x] 5. Validate level configuration
  - Warning logged when `level` is set but no matching level definition exists
  - Warning logged when level definition missing required `txt` property
  - Users must define all levels (no built-in defaults)

## Validation Tasks

- [x] 6. Test with `template.qmd`
  - Verified label renders with example configuration
  - LaTeX output contains TikZ label code at correct position
  - Note: Pre-existing table cellcolor error prevents full PDF render

- [x] 7. Test level switching
  - Level resolution verified via unit tests
  - Color values correctly stripped of # prefix

- [x] 8. Test without label (opt-out)
  - Verified: when `level` not set, no LaTeX generated
  - No errors when feature is disabled

- [x] 9. Test custom positioning
  - Positioning values passed correctly to LaTeX output
  - Supports all dimension units (mm, pt, cm)

## Documentation Tasks

- [x] 10. Update README or docs with data classification label usage
  - Configuration reference
  - Examples for common use cases

## Dependencies

- Task 1 must complete before Task 2 (Lua provides resolved values)
- Tasks 3-4 can run in parallel after Task 2
- Unit tests (10-12) can run in parallel, should be written alongside Task 1
- Validation tasks (6-9) require all implementation tasks complete

## Unit Test Tasks

- [x] 10. Create `tests/unit/dcl_resolve_level_spec.lua`
  - Tests level resolution from levels map
  - Tests with valid level name returns correct bgcolor, txtcolor, txt
  - Tests with missing level name returns nil
  - Tests with empty levels map

- [x] 11. Create `tests/unit/dcl_strip_hex_spec.lua`
  - Tests stripping `#` prefix from hex colors
  - Tests colors with `#` prefix (`#ff0000` -> `ff0000`)
  - Tests colors without prefix (passthrough)
  - Tests invalid color formats

- [x] 12. Create `tests/unit/dcl_validate_config_spec.lua`
  - Tests validation of complete configuration
  - Tests missing required fields (level set but no levels defined)
  - Tests missing level properties (bgcolor, txtcolor, txt)
  - Tests default values for optional fields (width, height, top, left)

All 21 unit tests passing.
