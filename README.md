# PRIZM Metadatabase

The PRIZM metadatabase leverages SQLite and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilitates calibration and analysis by allowing complex data intersections to be retrieved in a straightforward fashion.

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
chmod +x build.sh
./build.sh
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

Below the Data, Hardware, and Index tables which make up the PRIZM metadatabase are listed. Select a table to learn more about its structure and relationship to other tables in the schema. For an interactive diagram, click [here](https://dbdiagram.io/d/6221828954f9ad109a58a8b9).

| Data | Hardware | Index |
| ---- | -------- | ----- |
| [Data Diretories](guide/data_directories.md)<br/> [Data Categories](guide/data_categories.md)<br/> [Data Types](guide/data_types.md)<br/> [Data Files](guide/data_files.md)<br/> [Data Notes](guide/data_notes.md)<br/><br/><br/><br/><br/><br/><br/><br/><br/> | [Hardware Configurations](guide/hardware_configurations.md)<br/> [Array Elements](guide/array_elements.md)<br/> [Hardware Components](guide/hardware_components.md)<br/> [Component Groups](guide/component_groups.md)<br/> [Component Groupings](guide/component_groupings.md)<br/> [First Stages](guide/first_stages.md)<br/> [Second Stages](guide/second_stages.md)<br/> [First Stage Groups](guide/first_stage_groups.md)<br/> [Second Stage Groups](guide/second_stage_groups.md)<br/> [Channel Orientations](guide/channel_orientations.md)<br/> [Hardware Channels](guide/hardware_channels.md)<br/> [Channel Groups](guide/channel_groups.md)<br/> [Hardware Notes](guide/hardware_notes.md) | [Component Group Index](guide/component_group_index.md)<br/> [Component Grouping Index](guide/component_grouping_index.md)<br/> [First Stage Group Index](guide/first_stage_group_index.md)<br/> [Second Stage Group Index](guide/second_stage_group_index.md)<br/> [Channel Group Index](guide/channel_group_index.md)<br/><br/><br/><br/><br/><br/><br/><br/><br/> |

### Usage

The usage examples covered below assume the PRIZM metadatabase module has been imported under the following alias. 
```python
import metadatabase as mdb
```

#### Retrieving Metadata

SQLite queries can be executed against the metadatabase using the `retrieve` function. For instance, the following construction can be used to retrieve the model number and description of every hardware component listed in the PRIZM metadatabase.
```python
mdb.retrieve("SELECT component_model, component_description FROM HardwareComponents")
```

```python
[('VAT-3+',   '3 dB Fixed Attenuator, DC - 6000 MHz, 50 Ohm.'),
 ('6A',       '3 dB Fixed Coaxial Attenuator, SMA Models A, DC - 6000 MHz.'),
 ('SLP-200+', 'Lumped LC Low Pass Filter, DC - 190 MHz, 50 Ohm.'),
 ('SHP-25+',  'Lumped LC High Pass Filter, 27.5 MHz - 800 MHz.'),
 ...
 ('HIbiscus', 'HIbiscus Four-Square Antenna.')]
```

As an example of a more complex query, the directory addresses and file names associated with the east-west polarization data gathered by the 100MHz PRIZM antenna during the first half of 2018 can be retrieved in chronological order as follows.
```python
mdb.retrieve(("SELECT DataDirectories.directory_address, DataTypes.file_name, "
              "FROM   DataDirectories "
              "JOIN   DataCategories "
              "ON     DataDirectories.data_category = DataCategories.data_category "
              "AND    DataCategories.category_name = 'Antenna' "
              "JOIN   DataFiles "
              "ON     DataDirectories.data_directory = DataFiles.data_directory "
              "AND    DataDirectories.time_start <= strftime('%s','2018-07-01 00:00:00') "
              "AND    DataDirectories.time_stop >= strftime('%s','2018-01-01 00:00:00') "
              "JOIN   DataTypes "
              "ON     DataFiles.data_file = DataTypes.data_file "
              "JOIN   ChannelGroups "
              "ON     DataFiles.channel_group = ChannelGroups.channel_group "
              "JOIN   ChannelOrientations "
              "ON     ChannelOrientations.channel_orientation = ChannelGroups.channel_orientation "
              "AND    ChannelOrientations.orientation_name = 'EW' "
              "JOIN   ArrayElements "
              "ON     ArrayElements.array_element = ChannelGroups.array_element "
              "AND    ArrayElements.element_name = '100MHz' "
              "ORDER  BY DataDirectories.time_start "))
```

```python
[('/marion2018/data_100MHz/15236/1523601399', 'acc_cnt1.raw'),
 ('/marion2018/data_100MHz/15236/1523601399', 'acc_cnt2.raw'),
 ('/marion2018/data_100MHz/15236/1523601399', 'cross_imag.scio.bz2'),
 ('/marion2018/data_100MHz/15236/1523601399', 'cross_real.scio.bz2'),
 ...
 ('/marion2018/data_100MHz/15302/1530293230', 'time_sys_stop.raw')]
```

#### Loading Data

PRIZM data can be loaded through the metadatabase using the `load` function. This function receives lists as arguments, and returns a dictionary containing the data matching all combinations of these input lists' elements. This is illustrated below, where absolutely all data collected around April 22-23, 2018 is loaded.
```python
mdb.load(categories=['Antenna', 'Switch', 'Temperature'],
         instruments=['100MHz', '70MHz'],
         channels=['EW', 'NS'],
         intervals=[(1524400000.0,1524500000.0), ],
         quality=['1', '0', 'NULL'],
         integrity=['1', '0', 'NULL'],
         completeness=['1', '0', 'NULL'])
```
