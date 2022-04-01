<sup>**← [List of Tables](../README.md#schema)**</sup>

# Hardware Notes

Table name: `HardwareNotes`.

| Column                                                   | Data Type | Nullable | Description                                                                  |
| -------------------------------------------------------- | --------- | -------- | ---------------------------------------------------------------------------- |
| [`○ hardware_configuration`](hardware_configurations.md) | Integer   | False    | Identifies the experiment's hardware configuration associated with the note. | 
| [`○ array_element`](array_elements.md)                   | Integer   | True     | Identifies the array element associated with the note.                       | 
| [`○ first_stage`](first_stages.md)                       | Integer   | True     | Identifies the first stage electronics enclosure associated with the note.   |
| [`○ second_stage`](second_stage.md)                      | Integer   | True     | Identifies the second stage electronics enclosure associated with the note.  |
| [`○ component_grouping`](component_groupings.md)         | Integer   | True     | Identifies the component grouping associated with the note.                  |
| [`○ component_group`](component_groups.md)               | Integer   | True     | Identifies the component group associated with the note.                     |
| [`○ hardware_component`](hardware_components.md)         | Integer   | True     | Identifies the hardware component associated with the note.                  |
| `note_author`                                            | Text      | False    | Specifies the note author's name.                                            |
| `note_date`                                              | Text      | False    | Specifies the note's date and time.                                          |
| `note_content`                                           | Text      | False    | The note's content.                                                          |

<sup>**Legend**: [`○`](hardware_notes.md) Foreign Key.</sup>
