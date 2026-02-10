
<p align="center">
    <img width="300" alt="logo TeXnative" src="./media/TeXnative-logo.svg">
</p>

<p align="center">
  <a href="./docs">Documentation</a> ·
  <a href="https://discord.gg/PzyFgtPXfh">Discord (channel: # texnative)</a>
</p>

> Create professional business reports, manuals, quotations, letters, and more using plain understandable Markdown.

# TeXnative PDF Format

**_Quarto PDF format Extension_**

Elegant documents with dark/light themes, custom branding, and advanced table styling.

## Installing

```bash
quarto use template wearetechnative/texnative
```

This installs the extension and creates an starter temmplate-qmd file to kickoff your document.

## Features

- Modern business document for many purposes.
- Light and dark example themes.
- Customizable letterhead.
- Customizable cover page.
- Data classification labels (e.g., CONFIDENTIAL, INTERNAL, PUBLIC).
- Including a Quarto filter for advanced table styling.
- Actively maintained.

![](./media/Screenshot-TexNative.png)

![](./media/Screenshot-white.png)

## Using

Include this in your front matter.

```yaml
format: texnative-pdf
filters:
  - texnative
```

Have a look at the `template.qmd`. This generates [this pdf](template.pdf).

## Documentation

For detailed documentation, see:

- **[Configuration Reference](docs/configuration.md)** - All YAML front matter options
- **[Data Classification Labels](docs/data-classification-label.md)** - Add security labels to documents
- **[Table Formatting](docs/table-formatting.md)** - Professional table styling guide
- **[Documentation Index](docs/index.md)** - Complete documentation overview

## Quick Start

### Optional Frontmatter

When set, these values are used in the cover page.

```yaml
subtitle: Agreement for a typical business case
author: Jane Dean
date: last-modified
type: Report
document_version: 1
document_number: ABC013
```

### Custom letterhead

Change `letterhead_img`, `letterhead_img_darkbg`, `cover_illustration_img` and
`cover_illustration_img_darkbg` with images which fit your Corporate Identity.

## Examples

| Example | Description |
|:--------|:------------|
| [example_markdown_tables.qmd](./example_markdown_tables.qmd) | Markdown table examples ([PDF](./example_markdown_tables.pdf)) |
| [example_grid_tables.qmd](./example_grid_tables.qmd) | Pandoc grid table examples ([PDF](./example_grid_tables.pdf)) |
| [example_tables_frontmatter_configured.qmd](./example_tables_frontmatter_configured.qmd) | Document-level table styling ([PDF](./example_tables_frontmatter_configured.pdf)) |
| [example_data_classification_label.qmd](./example_data_classification_label.qmd) | Data classification labels ([PDF](./example_data_classification_label.pdf)) |

## Credits

Illustration is created by Illustrations.co from the 'Life' collection.
