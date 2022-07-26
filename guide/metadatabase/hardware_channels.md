<sup>**← [List of Tables](../README.md/#metadatabase-schema)**</sup>

# Hardware Channels

Table name: `HardwareChannels`.

| Column                                                     | Data Type | Nullable | Description                                      |
| ---------------------------------------------------------- | --------- | -------- | ------------------------------------------------ |
| [`○ ◌ hardware_configuration`](hardware_configurations.md) | Integer   | False    | Identifies a deployment configuration.           |
| [`○ ◌ second_stage`](second_stages.md)                     | Integer   | False    | Identifies a second stage electronics enclosure. |
| [`○ ◌ component_group`](component_groups.md)               | Integer   | False    | Identifies a component group.                    |
| [`○ ◌ channel_orientation`](channel_orientations.md)       | Integer   | False    | Identifies a channel orientation.                |
| [`○ ◌ array_element`](array_elements.md)                   | Integer   | False    | Identifies an array element.                     |

<sup>**Legend**: [`○`](hardware_channels.md) Foreign Key, [`◌`](hardware_channels.md) Composite Key.</sup>
