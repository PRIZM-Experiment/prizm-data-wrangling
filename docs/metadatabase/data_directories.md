<sup>**← [List of Tables](../../README.md/#Metadatabase-Schema)**</sup>

# Data Directories

Table name: `DataDirectories`.

| Column                                                   | Data Type | Nullable | Description                                                                                  |
| -------------------------------------------------------- | --------- | -------- | -------------------------------------------------------------------------------------------- |
| [`● data_directory`](data_directories.md)                | Integer   | False    | Uniquely labels each directory address.                                                      |
| `directory_address`                                      | Text      | False    | Specifies the directory address.                                                             |
| [`○ data_category`](data_categories.md)                  | Integer   | False    | Identifies the data category associated with the directory address.                          |
| [`○ hardware_configuration`](hardware_configurations.md) | Integer   | False    | Identifies the experiment's deployment configuration associated with the directory address.  |
| `time_start`                                             | Real      | False    | Specifies the time at which the data stored in the directory address started being taken.    |
| `time_stop`                                              | Real      | False    | Specifies the time at which the data stored in the directory address stopped being recorded. |
| `directory_completeness`                                 | Boolean   | False    | Specifies whether the directory is missing files.                                            |

<sup>**Legend**: [`●`](data_directories.md) Primary Key, [`○`](data_directories.md) Foreign Key.</sup>
