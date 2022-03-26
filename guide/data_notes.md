<sup>**← [List of Tables](schema.md)**</sup>

# Data Notes

Table name: `DataNotes`. 

| Column                                                   | Data Type | Nullable | Description |
| -------------------------------------------------------- | --------- | -------- | ----------- |
| [`○ hardware_configuration`](hardware_configurations.md) | Integer   | False    | Identifies the experiment's hardware configuration associated with the note. |
| [`○ data_directory`](data_directories.md)                | Integer   | True     | Identifies the directory address associated with the note.                   |
| [`○ data_file`](data_types.md)                           | Integer   | True     | Identifies the data file associated with the note.                           |
| `note_author`                                            | Text      | False    | The note author's name.                                                      |
| `note_date`                                              | Text      | False    | The note's date and time.                                                    |
| `note_content`                                           | Text      | False    | The note's content.                                                          |

<sup>**Legend**: [`●`](data_notes.md) Primary Key, [`○`](data_notes.md) Foreign Key.</sup>
