# Data Directories

The `DataDirectories` table stores the properties of all data directory addresses, including their relationships to different data categories and deployment configurations.

| Column                                               | Data Type | Nullable | Description                                                                                       |
| ---------------------------------------------------- | ----------| -------- | ------------------------------------------------------------------------------------------------- |
| ***data_directory***                                 | Integer   | False    | A number labeling each directory address                                                          |
| directory_address                                    | Text      | False    | The directory address string.                                                                     |
| [data_category](data_categories.md)                  | Integer   | False    | The data category associated with a particular directory address.                                 |
| [hardware_configuration](hardware_configurations.md) | Integer   | False    | The experiment's deployment configuration associated with the data stored in a directory address. |
| time_start                                           | Real      | False    | The time at which the data stored in a directory address started being taken.                     |
| time_stop                                            | Real      | False    | The time at which the data stored in a directory address stopped being recorded.                  |
| directory_completeness                               | Boolean   | False    | Whether the directory is missing files.                                                           |

<sup>Legend: ***Primary Keys***, [Foreign Keys]().</sup>
