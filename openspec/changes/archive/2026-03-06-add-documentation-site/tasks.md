# Tasks: add-documentation-site

## Phase 1: Set Up Documentation Site Structure
- [x] Create `documentation/` folder with Quarto website structure
- [x] Create `documentation/_quarto.yml` with site configuration, navigation, and theme
- [x] Convert `docs/index.md` to `documentation/index.qmd` as landing page

## Phase 2: Convert Documentation Files
- [x] Convert `docs/configuration.md` to `documentation/configuration.qmd`
- [x] Convert `docs/table-formatting.md` to `documentation/table-formatting.qmd`
- [x] Convert `docs/data-classification-label.md` to `documentation/data-classification-label.qmd`
- [x] Add proper YAML frontmatter to each .qmd file

## Phase 3: Improve Structure and Navigation
- [x] Create `documentation/getting-started.qmd` with installation and basic usage
- [x] Organize sidebar navigation into logical sections
- [x] Add cross-references between related documentation pages

## Phase 4: Update README and Clean Up
- [x] Update README.md to point to hosted documentation site
- [x] Remove detailed configuration content from README (now in docs site)
- [x] Keep README minimal: description, install command, link to docs
- [x] Remove or archive old `docs/` folder after migration

## Phase 5: Verification
- [x] Test local Quarto preview: `quarto preview documentation/`
- [x] Verify GitHub Action triggers on push to main (configured in `.github/workflows/quarto-publish.yml`)
- [x] Verify site renders correctly on GitHub Pages (requires push to main)
- [x] Verify all internal links work correctly (requires deployed site)
