# documentation Specification

## Purpose
TBD - created by archiving change consolidate-documentation. Update Purpose after archive.
## Requirements
### Requirement: Documentation Directory Structure
The project SHALL maintain documentation in a `documentation/` subdirectory as a Quarto website project, with the `docs/` folder deprecated.

#### Scenario: Documentation files organized as Quarto website
- **WHEN** a user looks for detailed documentation
- **THEN** configuration reference, table formatting, and other docs are found in `documentation/*.qmd`

#### Scenario: Root README remains minimal
- **WHEN** a user views the project root
- **THEN** README.md contains project overview, install command, and links to the hosted documentation site

### Requirement: Configuration Reference Documentation
The project SHALL provide a dedicated configuration reference document at `docs/configuration.md`.

#### Scenario: YAML frontmatter options documented
- **WHEN** a user needs to configure the TexNative extension
- **THEN** they can find all YAML options documented in `docs/configuration.md`

### Requirement: Table Formatting Documentation
The project SHALL provide table formatting documentation at `docs/table-formatting.md`.

#### Scenario: Table styling options documented
- **WHEN** a user wants to style tables in their document
- **THEN** they can find table formatting syntax and options in `docs/table-formatting.md`

### Requirement: Example Files Location
Example files (example_*.qmd) SHALL remain in the project root during the transition period.

#### Scenario: Published example links preserved
- **WHEN** external links point to example files in the repository root
- **THEN** the example files are accessible at their current root location

### Requirement: Quarto Documentation Website
The project SHALL provide a Quarto-based documentation website hosted on GitHub Pages.

#### Scenario: Documentation site accessible via web
- **WHEN** a user navigates to the GitHub Pages URL for TeXnative
- **THEN** they see a rendered documentation website with navigation

#### Scenario: Documentation site auto-deploys on changes
- **WHEN** changes are pushed to the `documentation/` folder on main branch
- **THEN** the GitHub Action renders and deploys the updated site to GitHub Pages

### Requirement: Documentation Site Structure
The documentation website SHALL be organized with sidebar navigation grouping content into logical sections.

#### Scenario: Getting Started section exists
- **WHEN** a new user visits the documentation site
- **THEN** they find a "Getting Started" section with installation and basic usage instructions

#### Scenario: Features section exists
- **WHEN** a user wants to learn about specific features
- **THEN** they find a "Features" section with pages for table formatting and data classification labels

#### Scenario: Reference section exists
- **WHEN** a user needs configuration details
- **THEN** they find a "Reference" section with complete YAML configuration options

### Requirement: Documentation Source Location
The documentation source files SHALL be located in a `documentation/` folder in the repository root.

#### Scenario: Quarto project in documentation folder
- **WHEN** a developer looks for documentation source files
- **THEN** they find Quarto .qmd files in `documentation/`

#### Scenario: Site configuration in documentation folder
- **WHEN** a developer needs to modify site configuration
- **THEN** they find `documentation/_quarto.yml` with website settings

