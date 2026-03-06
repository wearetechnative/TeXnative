# Change Proposal: add-documentation-site

## Summary
Set up a GitHub Pages documentation website for TeXnative using Quarto, following the pattern established by quarto_titlepages.

## Problem Statement
TeXnative currently has documentation in a `docs/` folder as plain markdown files. Users cannot browse this documentation via a web interface. GitHub Issue #1 requests:
- Moving documentation to a proper structure
- GitHub Action to render a Quarto documentation site
- Improved structure and navigation
- README.md as a portal, not the docs itself

## Proposed Solution
Convert the existing `docs/` folder into a Quarto website project (`documentation/`) that renders to GitHub Pages. This follows the same pattern as nmfs-opensci/quarto_titlepages.

### Key Changes
1. **Create `documentation/` folder** with Quarto website structure
   - `_quarto.yml` for site configuration
   - Convert existing `.md` files to `.qmd` format with proper navigation
   - Add index.qmd as the landing page

2. **Update GitHub Action** 
   - The workflow at `.github/workflows/quarto-publish.yml` already exists but references a non-existent `documentation/` folder
   - Once the folder is created, the workflow will work automatically

3. **Improve documentation structure**
   - Organize content into logical sections (Getting Started, Features, Reference)
   - Add sidebar navigation
   - Cross-link related topics

4. **Clean up README.md**
   - Keep it minimal as a project portal
   - Point to the hosted documentation site
   - Remove detailed configuration info (moved to docs site)

## Out of Scope
- Moving example files (per existing documentation spec, they remain in root during transition)
- Creating new documentation content beyond restructuring existing content

## References
- GitHub Issue: https://github.com/wearetechnative/TeXnative/issues/1
- Example implementation: https://nmfs-opensci.github.io/quarto_titlepages/
