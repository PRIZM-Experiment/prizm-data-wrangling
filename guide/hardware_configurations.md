<sup>**← [List of Tables](../README.md#schema)**</sup>

# Hardware Configurations

Table name: `HardwareConfigurations`.

| Column                                                   | Data Type | Nullable | Description                                                                                               |
| -------------------------------------------------------- | --------- | -------- | --------------------------------------------------------------------------------------------------------- |
| [`● hardware_configuration`](hardware_configurations.md) | Integer   | False    | Uniquely labels the experiment's deployment configuration.                                                |
| `configuration_name`                                     | Text      | False    | Specifies the configuration name.                                                                         |
| [`○ first_stage_group`](first_stage_group_index.md)      | Integer   | False    | Identifies the group of first stage electronics enclosures associated with the deployment configuration.  |
| [`○ second_stage_group`](second_stage_group_index.md)    | Integer   | False    | Identifies the group of second stage electronics enclosures associated with the deployment configuration. |

<sup>**Legend**: [`●`](hardware_configurations.md) Primary Key, [`○`](hardware_configurations.md) Foreign Key.</sup>
