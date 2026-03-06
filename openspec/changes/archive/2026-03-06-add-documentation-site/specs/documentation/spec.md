# documentation Spec Delta

## ADDED Requirements

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

## MODIFIED Requirements

### Requirement: Documentation Directory Structure
The project SHALL maintain documentation in a `documentation/` subdirectory as a Quarto website project, with the `docs/` folder deprecated.

#### Scenario: Documentation files organized as Quarto website
- **WHEN** a user looks for detailed documentation
- **THEN** configuration reference, table formatting, and other docs are found in `documentation/*.qmd`

#### Scenario: Root README remains minimal
- **WHEN** a user views the project root
- **THEN** README.md contains project overview, install command, and links to the hosted documentation site
