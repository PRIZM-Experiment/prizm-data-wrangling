<sup>**← [List of Tables](../../README.md#metadatabase-schema)**</sup>

# Component Groups

Table name: `ComponentGroups`.

| Column                                           | Data Type | Nullable | Description                                                 |
| ------------------------------------------------ | --------- | -------- | ----------------------------------------------------------- |
| [`○ component_group`](component_group_index.md)  | Integer   | False    | Identifies a group of hardware components.                  |
| [`○ hardware_component`](hardware_components.md) | Integer   | False    | Identifies a hardware component.                            |
| `component_position`                             | Integer   | False    | Specifies the hardware component's position within a group. |

<sup>**Legend**: [`○`](component_groups.md) Foreign Key.</sup>
