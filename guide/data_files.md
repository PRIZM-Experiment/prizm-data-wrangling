<sup>**← [List of Tables](schema.md)**</sup>

# Data Files 

The `DataFiles` table ...

| Column                                    | Data Type | Nullable | Description                               |
| ------------------------------------------| --------- | -------- | ----------------------------------------- |
| [`data_directory`](data_directories.md)   | Integer   | False    | A number labeling each directory address. |
| [`directory_file`](data_types.md)         | Integer   | False    |                                           |
| [`channel_group`](channel_group_index.md) | Integer   | False    |                                           |
| `data_integrity`                          | Boolean   | False    | Whether the file is corrupted.            |
| `data_quality`                            | Boolean   | True     | Whether the data is of good quality.      |

<sup>Legend: ***`Primary Key`***, [`Foreign Key`](data_files.md).</sup>
