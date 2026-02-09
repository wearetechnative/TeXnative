# TeXnative Documentation

TeXnative is a modern, customizable Quarto PDF format extension for creating clean business documents such as reports, quotations, and letters.

## Getting Started

### Installation

```bash
quarto use template wearetechnative/texnative
```

This installs the extension and creates an example `.qmd` file as a starting point.

### Basic Usage

Add this to your document's front matter:

```yaml
format: texnative-pdf
filters:
  - texnative
```

See the [template.qmd](../template.qmd) file for a complete example, which renders to [template.pdf](../template.pdf).

## Documentation

- **[Configuration Reference](configuration.md)** - All YAML front matter options for customizing your documents
- **[Table Formatting](table-formatting.md)** - Professional table styling with colors, borders, and advanced features
- **[Data Classification Labels](data-classification-label.md)** - Add security classification labels to every page

## Features

- Modern business document styling
- Dark and light background themes
- Custom letterhead and cover page images
- Professional table filter with advanced styling
- Rich text formatting in table cells
- Configurable column widths and alignments
- Data classification labels on every page

## Examples

Example files are available in the repository root:

| File | Description |
|:-----|:------------|
| [example_markdown_tables.qmd](../example_markdown_tables.qmd) | Markdown table examples ([PDF](../example_markdown_tables.pdf)) |
| [example_grid_tables.qmd](../example_grid_tables.qmd) | Pandoc grid table examples ([PDF](../example_grid_tables.pdf)) |
| [example_tables_frontmatter_configured.qmd](../example_tables_frontmatter_configured.qmd) | Document-level table styling ([PDF](../example_tables_frontmatter_configured.pdf)) |
| [example_data_classification_label.qmd](../example_data_classification_label.qmd) | Data classification label demo ([PDF](../example_data_classification_label.pdf)) |

## Credits

Illustration is created by Illustrations.co from the 'Life' collection.
