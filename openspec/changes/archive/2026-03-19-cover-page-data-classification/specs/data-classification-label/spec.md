## ADDED Requirements

### Requirement: Display Classification Text on Cover Page

The system SHALL display the data classification text as a row in the cover page metadata table when both `cover_page` is enabled and `data_classification_label.level` is set.

#### Scenario: Classification row shown on cover page

- **WHEN** a document has the following configuration:
```yaml
cover_page: true
data_classification_label:
  level: confidential
  levels:
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
```
- **THEN** the cover page metadata table SHALL include a row with label "Data Classification:" and value "CONFIDENTIAL"
- **AND** the row SHALL appear below the "Version" row

#### Scenario: Classification row not shown without cover page

- **WHEN** a document has `data_classification_label.level` set but `cover_page` is not enabled
- **THEN** the cover page metadata table SHALL NOT be rendered (no cover page exists)
- **AND** the classification text SHALL NOT appear in the document title area

#### Scenario: Classification row not shown without level

- **WHEN** a document has `cover_page: true` but no `data_classification_label.level` set
- **THEN** the cover page SHALL render without a "Data Classification" row

#### Scenario: Classification text matches resolved level

- **WHEN** a document has:
```yaml
cover_page: true
data_classification_label:
  level: internal
  levels:
    internal:
      bgcolor: '#ee7d2f'
      txtcolor: '#000000'
      txt: INTERNAL
    confidential:
      bgcolor: '#ff0000'
      txtcolor: '#000000'
      txt: CONFIDENTIAL
```
- **THEN** the cover page metadata table SHALL display "Data Classification:" with value "INTERNAL"
