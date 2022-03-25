# PRIZM Metadatabase

The PRIZM metadatabase leverages `SQLite` and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilitates calibration and analysis by allowing complex data intersections to be retrieved in a straightfoward fashion.

## Dependencies

- [SQLite](https://www.sqlite.org/) version 3.36 or superior.
- [Python](http://www.python.org/) version 3.0 or superior.
- [Scio](https://pypi.org/project/pbio/) version 0.0.2 or superior.

## Installation

Clone this repository within the directory of your choice.
```bash
git clone https://github.com/PRIZM-Experiment/prizm-data-wrangling.git
```

Run the following commmand within the repository's directory.
```bash
sqlite3 < build.sql
```

If successful, after a few minutes a binary file named `metadatabase.db` will have been generated. This file encapsulates all of PRIZM's metadata, and can be placed in whichever directory is most convenient for the user.

Next, edit the directory addresses in `settings.json` to reflect the chosen locations for the `metadatabase.db` file and the PRIZM data itself. As an example, for a user accessing PRIZM data through Niagara and keeping their `metadatabase.db` within a `prizm-data-wrangling` repository cloned to their root directory, the settings should be as follows.
```json
{
    "data": "/project/s/sievers/prizm",
    "metadata": "~/prizm-data-wrangling"
}
```

Finally, to conclude the installation, ensure your `PYTHONPATH` environment variable points to the location of the `prizm-data-wrangling` repository.

## Documentation

### Schema

Below the Data, Hardware, and Index tables which make up the metadatabase schema are listed. Click any table to access more details about its contents and relationships to other tables in the schema. For an interactive diagram of the metadatabase schema, click [here](https://dbdiagram.io/d/6221828954f9ad109a58a8b9).

- **Data**
    - [Data Diretories](guide/data_directories.md)
    - [Data Categories](guide/data_categories.md)
    - [Data Types](guide/data_types.md)
    - [Data Files](guide/data_files.md)
    - [Data Notes](guide/data_notes.md)
- **Hardware**
    - [Hardware Configurations](guide/hardware_configurations.md)
    - [Array Elements](guide/array_elements.md)
    - [Hardware Components](guide/hardware_components.md)
    - [Component Groups](guide/component_groups.md)
    - [Component Groupings](guide/component_groupings.md)
    - [First Stages](guide/first_stages.md)
    - [Second Stages](guide/second_stages.md)
    - [First Stage Groups](guide/first_stage_groups.md)
    - [Second Stage Groups](guide/second_stage_groups.md)
    - [Channel Orientations](guide/channel_orientations.md)
    - [Hardware Channels](guide/hardware_channels.md)
    - [Channel Groups](guide/channel_groups.md)
    - [Hardware Notes](guide/hardware_notes.md)
- **Index**
    - [Component Group Index](guide/component_group_index.md)
    - [Component Grouping Index](guide/component_grouping_index.md)
    - [First Stage Group Index](guide/first_stage_group_index.md)
    - [Second Stage Group Index](guide/second_stage_group_index.md)
    - [Channel Group Index](guide/channel_group_index.md)

### Usage

The usage examples covered below assume that the metadatabase Python module has been imported as follows.
```python
import metadatabase as mdb
```

#### Querying Metadata

```python
mdb.retrieve("SELECT * FROM HardwareComponents")
```

```python
[(0, 'VAT-3+', 'Mini-Circuits', '3 dB Fixed Attenuator, DC - 6000 MHz, 50 Ohm.'),
 (1, '6A', 'APITech Inmet', '3 dB Fixed Coaxial Attenuator, SMA Models A, DC - 6000 MHz.'),
 (2, 'SLP-200+', 'Mini-Circuits', 'Lumped LC Low Pass Filter, DC - 190 MHz, 50 Ohm.'),
 (3, 'SHP-25+', 'Mini-Circuits', 'Lumped LC High Pass Filter, 27.5 MHz - 800 MHz.'),
 ...
 (10, 'HIbiscus', 'RhoTech and Pinion & Adams', 'HIbiscus Four-Square Antenna.')]
```
#### Loading Data
(Under Construction)
