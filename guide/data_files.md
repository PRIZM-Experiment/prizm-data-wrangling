<sup>**← [List of Tables](schema.md)**</sup>

# Data Files 

Table name: `DataFiles`.

| Column                                      | Data Type | Nullable | Description                                                       |
| --------------------------------------------| --------- | -------- | ----------------------------------------------------------------- |
| [`○ data_directory`](data_directories.md)   | Integer   | False    | Labels the file's directory address.                              |
| [`○ data_file`](data_types.md)              | Integer   | False    | Specifies the file name.                                          |
| [`○ channel_group`](channel_group_index.md) | Integer   | False    | Identifies the polarization channels associated with this file.   |
| `data_integrity`                            | Boolean   | False    | Specifies whether the file is corrupted.                          |
| `data_quality`                              | Boolean   | True     | Specifies whether the data stored by the file is of good quality. |

<sup>**Legend**: [`●`](data_directories.md) Primary Key, [`○`](data_directories.md) Foreign Key.</sup>
