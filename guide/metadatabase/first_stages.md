<sup>**← [List of Tables](../README.md/#metadatabase-schema)**</sup>

# First Stages

Table name: `FirstStages`.

| Column                                                   | Data Type | Nullable | Description                                                                              |
| -------------------------------------------------------- | --------- | -------- | ---------------------------------------------------------------------------------------- |
| [`● first_stage`](first_stages.md)                       | Integer   | False    | Uniquely labels each first stage electronics enclosure.                                  |
| `stage_name`                                             | Text      | False    | Specifies the name of the first stage electronics enclosure.                             |
| [`○ array_element`](array_elements.md)                   | Integer   | False    | Identifies the array element associated with the first stage electronics enclosure.      |
| [`○ component_grouping`](component_groupings.md)         | Integer   | False    | Identifies the component grouping associated with the first stage electronics enclosure. |

<sup>**Legend**: [`●`](first_stages.md) Primary Key, [`○`](first_stages.md) Foreign Key.</sup>
