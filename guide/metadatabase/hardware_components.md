<sup>**← [List of Tables](../../README.md/#Metadatabase-Schema)**</sup>

# Hardware Components

Table name: `HardwareComponents`.

| Column                                                   | Data Type | Nullable | Description                                    |
| -------------------------------------------------------- | --------- | -------- | ---------------------------------------------- |
| [`● hardware_component`](hardware_components.md)         | Integer   | False    | Uniquely labels each hardware component.       |
| `component_model`                                        | Text      | False    | Specifies the component model.                 |
| `component_manufacturer`                                 | Text      | True     | Specifies the component manufacturer.          |
| `component_description`                                  | Text      | True     | A short description of the hardware component. |

<sup>**Legend**: [`●`](hardware_components.md) Primary Key.</sup>
