<sup>**← [List of Tables](../../README.md#Metadatabase-Schema)**</sup>

# Data Types

Table name: `DataTypes`.

| Column                         | Data Type | Nullable | Description                                                         | 
| ------------------------------ | --------- | -------- | ------------------------------------------------------------------- |
| [`● data_file`](data_types.md) | Integer   | False    | Uniquely labels each data file name.                                |
| `file_name`                    | Text      | False    | Specifies the file name.                                            | 
| `file_alias`                   | Text      | False    | Matches equivalent files whose naming convention changed over time. | 
| `data_type`                    | Text      | False    | Specifies the type of data stored by the file.                      |
| `data_description`             | Text      | False    | A short description of data file.                                   |

<sup>**Legend**: [`●`](data_types.md) Primary Key.</sup>
