# Design: Data Classification Label Implementation

## Context

TeXnative needs to render data classification labels (e.g., "CONFIDENTIAL", "INTERNAL", "PUBLIC") on every page of generated PDF documents. The label should be:

- Positioned at a fixed location on each page
- Styled with configurable background color, text color, dimensions, and border radius
- Configurable at both global (`_quarto.yml`) and document level

This design describes how to implement this using LaTeX with TikZ for rendering and Quarto's template variable system for configuration.

## Goals

1. Render a colored rectangular label with rounded corners and centered text
2. Position the label absolutely on each page (not affected by document flow)
3. Support multiple predefined classification levels
4. Allow global defaults in `_quarto.yml` with per-document overrides
5. Ensure the label appears on every page including cover page

## Non-Goals

- Watermarks (diagonal text across page)
- Multiple labels per page
- Different labels on different pages within same document
- Interactive/clickable labels

## Decisions

### D1: Use TikZ with `eso-pic` for Page Placement

**Decision**: Use TikZ for drawing the label box and `eso-pic` package for placing it on every page.

**Rationale**:
- TikZ provides `rounded corners` for border-radius and precise color control
- `eso-pic` package's `\AddToShipoutPictureBG` hook runs on every page automatically
- This combination is more reliable than `fancyhdr` for absolute positioning
- Already a common pattern in LaTeX documents

**Alternative Considered**: Using `fancyhdr` header/footer - rejected because positioning is relative to margins, not page edges.

### D2: Pure LaTeX Template (No Lua Required)

**Decision**: Implement entirely in LaTeX using Quarto's template variable substitution.

**Rationale**:
- The configuration is straightforward key-value pairs
- Quarto's `$if()$` and `$for()$` template syntax can handle the level lookup
- No complex document transformation needed (unlike tables which require AST manipulation)
- Simpler maintenance and debugging

**Trade-off**: If level lookup becomes complex (e.g., inheritance, computed values), Lua may be needed later. For now, we use a flattened approach where the active level's properties are directly accessible.

### D3: Color Format Using HTML Hex Codes

**Decision**: Accept colors in HTML hex format (`#ff0000`) and convert to LaTeX `HTML` color model.

**Rationale**:
- Hex colors are familiar to users
- Consistent with web/CSS conventions
- LaTeX's `xcolor` package supports `HTML` color model directly
- Example: `\definecolor{dcl-bgcolor}{HTML}{ff0000}`

**Implementation**: Strip the `#` prefix in the template using Quarto variable processing.

### D4: Configuration Structure

**Decision**: Use nested YAML with `levels` map and active `level` selector.

```yaml
data_classification_label:
  level: confidential        # Selector
  levels:                    # Definitions
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
  # Styling applies to all levels
  width: 40mm
  height: 10mm
  top: 20mm
  left: 20mm
  txtsize: small
  border-radius: 2pt
```

**Rationale**:
- Levels can be defined globally in `_quarto.yml`
- Documents only need to set `level` to select
- Styling properties can have sensible defaults

### D5: LaTeX Package Dependencies

**Packages Required**:
- `tikz` - Drawing the rounded rectangle and text
- `eso-pic` - Adding content to every page background
- `xcolor` - Color definitions (already used by TeXnative)

**Loading**: Add to `header.tex` or a new partial `data-classification-label.tex`.

## Implementation Approach

### LaTeX Template Structure

```latex
% In header/preamble (only if data_classification_label.level is set)
$if(data_classification_label.level)$
\usepackage{tikz}
\usepackage{eso-pic}

% Define colors from active level
\definecolor{dcl-bgcolor}{HTML}{$data_classification_label.active_bgcolor$}
\definecolor{dcl-txtcolor}{HTML}{$data_classification_label.active_txtcolor$}

% Add label to every page
\AddToShipoutPictureBG{%
  \begin{tikzpicture}[remember picture, overlay]
    \node[
      fill=dcl-bgcolor,
      text=dcl-txtcolor,
      rounded corners=$data_classification_label.border-radius$,
      minimum width=$data_classification_label.width$,
      minimum height=$data_classification_label.height$,
      font=\$data_classification_label.txtsize$
    ] at ([xshift=$data_classification_label.left$, yshift=-$data_classification_label.top$]current page.north west) 
    {$data_classification_label.active_txt$};
  \end{tikzpicture}%
}
$endif$
```

### Level Resolution Challenge

Quarto templates cannot do dynamic map lookups (`levels[level]`). Two solutions:

**Option A: Lua Pre-processor (Recommended)**
A small Lua filter resolves the level and flattens active properties:
```lua
function Meta(meta)
  local dcl = meta.data_classification_label
  if dcl and dcl.level then
    local level_name = pandoc.utils.stringify(dcl.level)
    local level_config = dcl.levels[level_name]
    if level_config then
      dcl.active_bgcolor = level_config.bgcolor
      dcl.active_txtcolor = level_config.txtcolor
      dcl.active_txt = level_config.txt
    end
  end
  return meta
end
```

**Option B: Template Iteration**
Use `$for()$` with `$if()$` matching - verbose and error-prone.

**Decision**: Use Option A (Lua pre-processor) for clean separation of concerns.

## Risks and Trade-offs

| Risk | Mitigation |
|------|------------|
| TikZ package conflicts | TikZ is widely used; test with existing documents |
| Label overlaps content | Default position (top-left) typically safe; user can adjust |
| Color parsing errors | Validate hex format in Lua; provide clear error messages |
| Performance overhead | `eso-pic` adds minimal overhead; TikZ node is simple |

## Migration Plan

Not applicable - this is a new feature with no existing behavior to migrate.

## Resolved Questions

1. **Default values**: Should we provide built-in level definitions, or require users to define all levels?
   - **Decision**: Require user-defined levels. Users must explicitly define all levels in `_quarto.yml` or document frontmatter. This avoids implicit behavior and ensures organizations define their own classification taxonomy.

2. **Position anchor**: Should `top` and `left` be from page edge or from margins?
   - **Decision**: From page edge (absolute positioning). This provides predictable placement regardless of margin configuration.

3. **Cover page behavior**: Should the label appear on the cover page?
   - **Decision**: Yes, appear on all pages including cover. This ensures compliance consistency across the entire document.
