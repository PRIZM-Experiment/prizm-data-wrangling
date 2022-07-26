<sup>**← [List of Tables](../../README.md#metadatabase-schema)**</sup>

# Data Files

Table name: `DataFiles`.

| Column                                      | Data Type | Nullable | Description                                                       |
| --------------------------------------------| --------- | -------- | ----------------------------------------------------------------- |
| [`○ ◌ data_directory`](data_directories.md) | Integer   | False    | Identifies the file's directory address.                          |
| [`○ ◌ data_file`](data_types.md)            | Integer   | False    | Identifies the file name.                                         |
| [`○ channel_group`](channel_group_index.md) | Integer   | False    | Identifies the polarization channels associated with the file.    |
| `data_integrity`                            | Boolean   | False    | Specifies whether the file is corrupted.                          |
| `data_quality`                              | Boolean   | True     | Specifies whether the data stored by the file is of good quality. |

<sup>**Legend**: [`○`](data_files.md) Foreign Key, [`◌`](data_files.md) Composite Key.</sup>
