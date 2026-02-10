# data-classification-label Specification

## Purpose
TBD - created by archiving change add-data-classification-label. Update Purpose after archive.
## Requirements
### Requirement: Display Data Classification Label

The system SHALL render a data classification label on every page of the PDF document when `data_classification_label.level` is configured.

#### Scenario: Render confidential label on all pages

**WHEN** a document has the following configuration:
```yaml
data_classification_label:
  level: confidential
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
```

**THEN** every page of the rendered PDF SHALL display a label with:
- Text "CONFIDENTIAL" centered within the label
- Red background color (#ff0000)
- Black text color (#000000)

---

### Requirement: Position Label Absolutely on Page

The system SHALL position the data classification label at an absolute position from the page edges, not relative to content margins.

#### Scenario: Label positioned at top-left of page

**WHEN** a document has the configuration:
```yaml
data_classification_label:
  level: confidential
  top: 20mm
  left: 20mm
```

**THEN** the label SHALL be positioned 20mm from the top edge and 20mm from the left edge of every page.

---

### Requirement: Support Configurable Label Dimensions

The system SHALL support configurable width, height, text size, and border radius for the label.

#### Scenario: Custom label dimensions

**WHEN** a document has the configuration:
```yaml
data_classification_label:
  level: internal
  width: 50mm
  height: 12mm
  txtsize: footnotesize
  border-radius: 3pt
```

**THEN** the label SHALL render with:
- Width of 50mm
- Height of 12mm
- Text in footnotesize
- Rounded corners with 3pt radius

---

### Requirement: Level Lookup from Predefined Levels

The system SHALL look up the active level's styling from the `levels` map using the `level` key as selector.

#### Scenario: Select internal level from predefined levels

**WHEN** a document has the configuration:
```yaml
data_classification_label:
  level: internal
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL
```

**THEN** the label SHALL display with:
- Text "INTERNAL"
- Orange background color (#ee7d2f)
- Black text color (#000000)

---

### Requirement: Global Level Definitions with Document Override

The system SHALL support defining classification levels globally in `_quarto.yml` and selecting or overriding at the document level.

#### Scenario: Document selects level defined in project config

**WHEN** `_quarto.yml` contains:
```yaml
data_classification_label:
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#ffffff'
      txt: CONFIDENTIAL
```

**AND** a document frontmatter contains:
```yaml
data_classification_label:
  level: confidential
```

**THEN** the document SHALL render the confidential label using the globally defined styling.

---

### Requirement: No Label When Level Not Set

The system SHALL NOT render any data classification label when `data_classification_label.level` is not set or is empty.

#### Scenario: Document without classification level

**WHEN** a document has no `data_classification_label.level` configured

**THEN** no classification label SHALL appear on any page
**AND** no LaTeX errors SHALL occur due to missing label configuration

---

### Requirement: Label Appears on Cover Page

The system SHALL render the data classification label on the cover page when the document has both `cover_page: true` and a classification level configured.

#### Scenario: Label on cover page

**WHEN** a document has:
```yaml
cover_page: true
data_classification_label:
  level: confidential
```

**THEN** the classification label SHALL appear on the cover page at the configured position.

