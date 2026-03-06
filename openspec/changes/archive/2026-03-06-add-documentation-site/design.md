# Design: add-documentation-site

## Architecture Decision: Quarto Website in documentation/ Folder

### Context
The existing GitHub workflow already targets a `documentation/` folder path. Following the quarto_titlepages pattern maintains consistency with successful Quarto extension documentation practices.

### Decision
Use Quarto's built-in website project type with the following structure:

```
documentation/
├── _quarto.yml           # Site configuration
├── index.qmd             # Landing page
├── getting-started.qmd   # Installation and quick start
├── configuration.qmd     # YAML frontmatter reference
├── table-formatting.qmd  # Table styling guide
└── data-classification-label.qmd  # DCL feature docs
```

### Site Configuration (_quarto.yml)

```yaml
project:
  type: website

website:
  title: "TeXnative"
  navbar:
    left:
      - href: index.qmd
        text: Home
      - href: getting-started.qmd
        text: Getting Started
  sidebar:
    style: "docked"
    contents:
      - section: "Getting Started"
        contents:
          - getting-started.qmd
      - section: "Features"
        contents:
          - table-formatting.qmd
          - data-classification-label.qmd
      - section: "Reference"
        contents:
          - configuration.qmd

format:
  html:
    theme: cosmo
    toc: true
```

### Rationale

1. **Consistency**: Matches the pattern used by quarto_titlepages and other Quarto extensions
2. **Minimal Configuration**: Leverages existing GitHub workflow without modifications
3. **User Experience**: Provides searchable, navigable documentation with sidebar
4. **Maintainability**: Standard Quarto website structure, easy to extend

### Alternatives Considered

1. **Keep docs/ as markdown**: No web interface, harder to navigate
2. **Use MkDocs or other SSG**: Requires additional tooling, doesn't leverage Quarto ecosystem
3. **In-repo GitHub wiki**: Separate from code, harder to version control

### Migration Path

1. Create new `documentation/` folder (parallel to existing `docs/`)
2. Convert and enhance content
3. Verify deployment works
4. Remove old `docs/` folder
5. Update README links to point to GitHub Pages site
