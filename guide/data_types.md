<sup>**← [List of Tables](schema.md)**</sup>

# Data Types 

Table name: `DataTypes`.

| Column                         | Data Type | Nullable | Description                                                        | 
| ------------------------------ | --------- | -------- | ------------------------------------------------------------------ |
| [`● data_file`](data_types.md) | Integer   | False    | Uniquely labels each data file name.                               |
| `file_name`                    | Text      | False    | The data file name.                                                | 
| `file_alias`                   | Text      | False    | Matches files of the same type which have changed names over time. | 
| `data_type`                    | Text      | False    | Specifies the type of data stored by the file.                     |
| `data_description`             | Text      | False    | A short description of data file.                                  |

<sup>**Legend**: [`●`](data_types.md) Primary Key, [`○`](data_types.md) Foreign Key.</sup>
