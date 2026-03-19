## ADDED Requirements

### Requirement: Meta Shortcode Resolution in Tables

The table filter SHALL resolve Quarto `{{< meta ... >}}` shortcodes within table cells, producing the corresponding metadata value in the LaTeX output. The resolver SHALL support dotted paths for nested metadata (e.g., `sla.availability`).

#### Scenario: Simple meta shortcode in table cell

- **GIVEN** a document with YAML metadata `company: "Acme Corp"`
- **WHEN** a table cell contains `{{< meta company >}}`
- **THEN** the LaTeX output SHALL include the escaped text "Acme Corp" in that cell

#### Scenario: Nested meta shortcode in table cell

- **GIVEN** a document with YAML metadata `sla: { availability: "99.9%" }`
- **WHEN** a table cell contains `{{< meta sla.availability >}}`
- **THEN** the LaTeX output SHALL include the escaped text "99.9\%" in that cell

#### Scenario: Multiple shortcodes in same table

- **GIVEN** a document with multiple metadata fields
- **WHEN** a table contains cells with different `{{< meta ... >}}` shortcodes
- **THEN** each cell SHALL resolve to its corresponding metadata value

#### Scenario: Shortcode with undefined meta path

- **GIVEN** a document where the referenced meta path does not exist
- **WHEN** a table cell contains `{{< meta nonexistent.field >}}`
- **THEN** the cell SHALL render without error (empty or omitted value)

#### Scenario: Shortcodes inside code blocks are ignored

- **GIVEN** a document with `{{< meta ... >}}` inside a fenced code block
- **WHEN** the shortcode map is built
- **THEN** the shortcode inside the code block SHALL NOT be assigned an ID and SHALL NOT affect ID sequencing for other shortcodes

### Requirement: Span Element Rendering in Tables

The table filter's inline renderer SHALL handle Pandoc `Span` elements, rendering their child content recursively rather than falling through to the generic stringify fallback.

#### Scenario: Regular Span with formatted content

- **GIVEN** a table cell containing a Span element wrapping bold text
- **WHEN** the cell is rendered to LaTeX
- **THEN** the Span's children SHALL be rendered with their formatting preserved (e.g., `\textbf{text}`)

#### Scenario: Empty Span element

- **GIVEN** a table cell containing an empty Span element
- **WHEN** the cell is rendered to LaTeX
- **THEN** the Span SHALL be stringified without error
