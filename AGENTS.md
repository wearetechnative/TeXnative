<!-- OPENSPEC:START -->
# OpenSpec Instructions

These instructions are for AI assistants working in this project.

Always open `@/openspec/AGENTS.md` when the request:
- Mentions planning or proposals (words like proposal, spec, change, plan)
- Introduces new capabilities, breaking changes, architecture shifts, or big performance/security work
- Sounds ambiguous and you need the authoritative spec before coding

Use `@/openspec/AGENTS.md` to learn:
- How to create and apply change proposals
- Spec format and conventions
- Project structure and guidelines

Keep this managed block so 'openspec update' can refresh the instructions.

<!-- OPENSPEC:END -->

# TeXnative Extension Architecture

## Quarto Extension Structure

The TeXnative extension lives in `_extensions/texnative/` with this structure:

```
_extensions/texnative/
├── _extension.yml          # Extension configuration (filters, partials, defaults)
├── texnative.lua           # Main Lua filter
├── texnative_core.lua      # Shared Lua utilities (require'd by other Lua files)
├── texnative_dcl.lua       # Data classification label filter
├── texnative-pre.lua       # Pre-processing filter
├── pandoc.tex              # Main template partial (calls other partials)
├── header.tex              # Custom header includes (currently empty)
├── before-body.tex         # Content before document body
└── partials/               # LaTeX partial templates
    ├── document-colors.tex
    ├── document-background.tex
    ├── document-header-footer.tex
    ├── document-text-style.tex
    ├── page-cover.tex
    ├── page-title.tex
    └── toc.tex
```

## Critical: How Template Partials Work

### The Problem
Quarto's `template-partials` in `_extension.yml` **only override existing Pandoc partial names**. Custom partial names (like `document-colors.tex`) are NOT automatically included in the LaTeX output.

### How This Extension Works
1. **`pandoc.tex`** is a standard Pandoc partial name that gets processed
2. Our `pandoc.tex` explicitly calls custom partials using `$partial-name.tex()$` syntax:
   ```latex
   $document-colors.tex()$
   $document-background.tex()$
   $document-header-footer.tex()$
   ```
3. These custom partials must be listed in `template-partials` in `_extension.yml`

### Adding New LaTeX Content

**Option 1: Via Existing Partial (Recommended for simple additions)**
Add your LaTeX code to an existing partial like `document-colors.tex` or `document-header-footer.tex`.

**Option 2: Via Lua Filter + header-includes (Recommended for dynamic content)**
Generate LaTeX in a Lua filter and inject it into `header-includes`:
```lua
function Meta(meta)
  local latex_code = "\\usepackage{mypackage}\n..."
  local raw_block = pandoc.RawBlock('latex', latex_code)
  
  if not meta['header-includes'] then
    meta['header-includes'] = pandoc.MetaList({})
  end
  meta['header-includes']:insert(pandoc.MetaBlocks({raw_block}))
  
  return meta
end
```
This approach:
- Works reliably (bypasses template-partial complexity)
- Allows conditional logic in Lua
- Can use metadata values to generate dynamic LaTeX

**Option 3: New Partial (More complex)**
1. Create `partials/my-partial.tex`
2. Add to `template-partials` list in `_extension.yml`
3. Add `$my-partial.tex()$` call in `pandoc.tex`

### Common Pitfalls

1. **Partial not appearing in output**: Check that `pandoc.tex` calls your partial AND it's in `template-partials`

2. **Template variables not resolved**: `include-in-header` files are included as raw LaTeX - they do NOT process Pandoc template syntax like `$if(var)$`. Use partials or Lua `header-includes` injection instead.

3. **Lua module naming**: Use underscores (`texnative_dcl.lua`) not hyphens for Lua files that need to be `require()`d in tests.

4. **Filter return value**: Lua filters must return `{ {Meta = Meta} }` format for Quarto, but can return a module table `M` for unit testing:
   ```lua
   if quarto then
     return { { Meta = Meta } }
   else
     return M  -- For unit testing
   end
   ```

## Unit Testing

Tests live in `tests/unit/` using the Busted framework:
- Mock Pandoc via `tests/mocks/pandoc.lua`
- Run with: `busted tests/unit/`
- Pattern: `*_spec.lua`

Test setup pattern:
```lua
package.path = 'tests/mocks/?.lua;' .. package.path
_G.pandoc = require('pandoc')
package.path = '_extensions/texnative/?.lua;' .. package.path
local module = require('module_name')
```