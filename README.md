
<p align="center">
    <img width="300" alt="logo TeXnative" src="./media/TeXnative-logo.svg">
</p>

<p align="center">
  <a href="https://wearetechnative.github.io/TeXnative/">Documentation</a> ·
  <a href="https://discord.gg/PzyFgtPXfh">Discord (channel: # texnative)</a>
</p>

> Create professional business reports, manuals, quotations, letters, and more using plain understandable Markdown.

# TeXnative PDF Format

**_Quarto PDF format Extension_**

Elegant documents with dark/light themes, custom branding, and advanced table styling.

## Quick Start

```bash
quarto use template wearetechnative/texnative
```

This installs the extension and creates a starter template-qmd file to kickoff your document.

Add this to your front matter:

```yaml
format: texnative-pdf
filters:
  - texnative
```

## Features

- Modern business document for many purposes
- Light and dark example themes
- Customizable letterhead and cover page
- Data classification labels (e.g., CONFIDENTIAL, INTERNAL, PUBLIC)
- Advanced table styling with custom colors

![](./media/Screenshot-TexNative.png)

![](./media/Screenshot-white.png)

## Documentation

For comprehensive documentation, visit the **[TeXnative Documentation Site](https://wearetechnative.github.io/TeXnative/)**.

- [Getting Started](https://wearetechnative.github.io/TeXnative/getting-started.html) - Installation and basic usage
- [Configuration Reference](https://wearetechnative.github.io/TeXnative/configuration.html) - All YAML front matter options
- [Table Formatting](https://wearetechnative.github.io/TeXnative/table-formatting.html) - Professional table styling guide
- [Data Classification Labels](https://wearetechnative.github.io/TeXnative/data-classification-label.html) - Security labels for documents

## Examples

| Example | Description |
|:--------|:------------|
| [example_markdown_tables.qmd](./example_markdown_tables.qmd) | Markdown table examples ([PDF](./example_markdown_tables.pdf)) |
| [example_grid_tables.qmd](./example_grid_tables.qmd) | Pandoc grid table examples ([PDF](./example_grid_tables.pdf)) |
| [example_tables_frontmatter_configured.qmd](./example_tables_frontmatter_configured.qmd) | Document-level table styling ([PDF](./example_tables_frontmatter_configured.pdf)) |
| [example_data_classification_label.qmd](./example_data_classification_label.qmd) | Data classification labels ([PDF](./example_data_classification_label.pdf)) |

## Credits

Illustration is created by Illustrations.co from the 'Life' collection.
