# Data Classification Labels

Add security classification labels to your PDF documents. The label appears on every page, helping to indicate the sensitivity level of the document content.

## Quick Start

Add a classification label by including `data_classification_label` in your document's YAML front matter:

```yaml
data_classification_label:
  level: confidential
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#ffffff'
      txt: CONFIDENTIAL
```

## Configuration Options

### Level Selection

The `level` field selects which classification to display:

```yaml
data_classification_label:
  level: internal          # Must match a key in 'levels'
```

### Defining Levels

Define one or more classification levels under `levels`:

```yaml
data_classification_label:
  levels:
    confidential:
      bgcolor: '#ff0000'   # Background color (hex)
      txtcolor: '#ffffff'  # Text color (hex)
      txt: CONFIDENTIAL    # Label text

    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL

    public:
      bgcolor: '#70ac45'
      txtcolor: '#000000'
      txt: PUBLIC
```

Each level requires:
- `bgcolor` - Background color in hex format (e.g., `'#ff0000'`)
- `txtcolor` - Text color in hex format (e.g., `'#ffffff'`)
- `txt` - The text displayed in the label

### Position and Size

Control where the label appears and its dimensions:

```yaml
data_classification_label:
  level: confidential
  levels: { ... }

  # Position (from page edges)
  top: 10mm              # Distance from top edge
  left: 10mm             # Distance from left edge

  # Dimensions
  width: 35mm            # Label width
  height: 8mm            # Label height

  # Styling
  txtsize: small         # Font size
  border-radius: 3pt     # Corner rounding
```

#### Position Reference

The label is positioned using absolute coordinates from the page edges:

```
┌─────────────────────────────┐
│  ↓ top                      │
│ → ┌──────────┐              │
│   │  LABEL   │              │
│   └──────────┘              │
│ left                        │
│                             │
└─────────────────────────────┘
```

#### Available Text Sizes

The `txtsize` option accepts LaTeX font size commands:
- `tiny`
- `scriptsize`
- `footnotesize`
- `small` (default)
- `normalsize`
- `large`

### Default Values

| Option | Default |
|--------|---------|
| `width` | `30mm` |
| `height` | `8mm` |
| `top` | `10mm` |
| `left` | `10mm` |
| `txtsize` | `small` |
| `border-radius` | `2pt` |

## Global Configuration

Define classification levels once in `_quarto.yml` and reference them in individual documents:

**_quarto.yml:**
```yaml
data_classification_label:
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#ffffff'
      txt: CONFIDENTIAL
    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL
    public:
      bgcolor: '#70ac45'
      txtcolor: '#000000'
      txt: PUBLIC

  # Default styling
  width: 35mm
  height: 8mm
  top: 10mm
  left: 10mm
  txtsize: small
  border-radius: 3pt
```

**document.qmd:**
```yaml
data_classification_label:
  level: confidential
```

This approach ensures consistent label definitions across all documents in your project.

## Examples

### Minimal Configuration

```yaml
data_classification_label:
  level: internal
  levels:
    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL
```

### Custom Positioning

Place the label in the top-right corner:

```yaml
data_classification_label:
  level: confidential
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#ffffff'
      txt: CONFIDENTIAL
  top: 10mm
  left: 165mm              # A4 width (210mm) - label width - margin
  width: 35mm
```

### Large Label

```yaml
data_classification_label:
  level: confidential
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#ffffff'
      txt: CONFIDENTIAL
  width: 50mm
  height: 12mm
  txtsize: normalsize
  border-radius: 5pt
```

### Corporate Classification Scheme

```yaml
data_classification_label:
  level: restricted
  levels:
    top-secret:
      bgcolor: '#000000'
      txtcolor: '#ff0000'
      txt: TOP SECRET
    restricted:
      bgcolor: '#8b0000'
      txtcolor: '#ffffff'
      txt: RESTRICTED
    internal:
      bgcolor: '#ff8c00'
      txtcolor: '#000000'
      txt: INTERNAL USE ONLY
    public:
      bgcolor: '#228b22'
      txtcolor: '#ffffff'
      txt: PUBLIC
```

## Disabling the Label

To disable the classification label, either:

1. Remove the `data_classification_label` section entirely
2. Remove or comment out the `level` field:

```yaml
data_classification_label:
  # level: confidential    # Commented out - no label shown
  levels: { ... }
```

## Technical Notes

- The label uses TikZ for rendering and `eso-pic` for page placement
- Labels appear on all pages including the cover page (if enabled)
- Colors must be specified in hex format with the `#` prefix
- Position is calculated from the page edge, not the text margins
