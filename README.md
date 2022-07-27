# Data Wrangling for PRIZM

This repository hosts both the PRIZM metadatabase and data container. The PRIZM metadatabase leverages SQLite and Python's `sqlite3` module to keep track of the experiment's data and deployment configurations. It provides scalability, ensures data consistency, and facilitates calibration and analysis by allowing complex data intersections to be retrieved in a straightforward fashion. The PRIZM data container combines the `collections.UserDict` and `numpy.array` objects into an intuitive hierarchical data structure which also enjoys the benefits of vectorization. It can hold data loaded via the metadatabase or directly loaded from a list of directories, and comes equipped with several convenience methods for data manipulation, analysis, and visualization.

## Dependencies

- [SQLite](https://www.sqlite.org/) version 3.36 or superior.
- [Python](http://www.python.org/) version 3.0 or superior.
- [Scio](https://pypi.org/project/pbio/) version 0.0.2 or superior.

## Installation

Clone this repository within the directory of your choice.
```bash
git clone https://github.com/PRIZM-Experiment/prizm-data-wrangling.git
```

Run the following commmands within the repository's directory.
```bash
chmod +x install.sh
./install.sh
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

### Metadatabase Schema

Below the Data, Hardware, and Index tables which make up the PRIZM metadatabase are listed. Select a table to learn more about its structure and relationship to other tables in the schema. For an interactive diagram, click [here](https://dbdiagram.io/d/6221828954f9ad109a58a8b9).

| Data | Hardware | Index |
| ---- | -------- | ----- |
| [Data Diretories](guide/metadatabase/data_directories.md)<br/> [Data Categories](guide/metadatabase/data_categories.md)<br/> [Data Types](guide/metadatabase/data_types.md)<br/> [Data Files](guide/metadatabase/data_files.md)<br/> [Data Notes](guide/metadatabase/data_notes.md)<br/><br/><br/><br/><br/><br/><br/><br/><br/> | [Hardware Configurations](guide/metadatabase/hardware_configurations.md)<br/> [Array Elements](guide/metadatabase/array_elements.md)<br/> [Hardware Components](guide/metadatabase/hardware_components.md)<br/> [Component Groups](guide/metadatabase/component_groups.md)<br/> [Component Groupings](guide/metadatabase/component_groupings.md)<br/> [First Stages](guide/metadatabase/first_stages.md)<br/> [Second Stages](guide/metadatabase/second_stages.md)<br/> [First Stage Groups](guide/metadatabase/first_stage_groups.md)<br/> [Second Stage Groups](guide/metadatabase/second_stage_groups.md)<br/> [Channel Orientations](guide/metadatabase/channel_orientations.md)<br/> [Hardware Channels](guide/metadatabase/hardware_channels.md)<br/> [Channel Groups](guide/metadatabase/channel_groups.md)<br/> [Hardware Notes](guide/metadatabase/hardware_notes.md) | [Component Group Index](guide/metadatabase/component_group_index.md)<br/> [Component Grouping Index](guide/metadatabase/component_grouping_index.md)<br/> [First Stage Group Index](guide/metadatabase/first_stage_group_index.md)<br/> [Second Stage Group Index](guide/metadatabase/second_stage_group_index.md)<br/> [Channel Group Index](guide/metadatabase/channel_group_index.md)<br/><br/><br/><br/><br/><br/><br/><br/><br/> |

### Container Design

Below is a list of the PRIZM container's functionalities. Select a constructor or method to learn more details about its functioning and usage.

| Constructors | Methods |
| ------------ | --------|
| [via_metadatabase](guide/container/via_metadatabase.md)<br/> [from_directories](guide/container/from_directories.md)<br/><br/><br/> | [lst](guide/container/lst.md)<br/> [partition](guide/container/partition.md)<br/> [get](guide/container/get.md)<br/> [interpolate](guide/container/interpolate.md)|

The structure of the PRIZM data container is also schematized below. While the container is organized in a nested dictionary structure, each data entry is stored as a `numpy.ndarray`.
```python
{
    '100MHz':
    {
        'EW':
        {
            'pol': numpy.ndarray,
            'time_sys_start': numpy.ndarray,
            ...
        },

        'NS':
        {
            'pol': numpy.ndarray,
            'time_sys_start': numpy.ndarray,
            ...
        },

        'Switch':
        {
            'antenna': numpy.ndarray,
            'short': numpy.ndarray,
            ...
        },

        'Housekeeping':
        {
            'cross_real': numpy.ndarray,
            'temp_100_ambient': numpy.ndarray,
            ...
        },

    '70MHz':
    {
        ...
    }
}
```
The container's primary keys, `100MHz` and `70MHz`, refer to the two PRIZM instruments. The data associated with a particular polarization channel are listed under the appropriate channel key, as examplified by the `pol` and `time_sys_start` entries under both the `EW` and `NS` keys. Meanwhile, the data describing the instrument's switching cadence are listed under the `Switch` key, as illustrated above by the `antenna` and `short` entries. Finally, the data related to both polarization channels are listed under the `Housekeeping` key, as shown by the `cross_real` and `temp_100_ambient` entries.

### Usage

The usage examples covered below assume that the PRIZM metadatabase and data container have been imported as follows. 
```python
import metadatabase as mdb
from data import Data
```

For an interactive version of this section, click [here](guide/Tutorial.ipynb). 

#### Retrieving Metadata

SQLite queries can be executed against the metadatabase using the `execute` function. For instance, the following construction can be used to retrieve the model number and description of every hardware component listed in the PRIZM metadatabase.
```python
mdb.execute("SELECT component_model, component_description FROM HardwareComponents")
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
mdb.execute(("SELECT DataDirectories.directory_address, DataTypes.file_name "
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

#### Loading Data via the Metadatabase

PRIZM data can be loaded through the metadatabase using the data container's `via_metadatabase` constructor. This function receives lists as arguments, and returns a data container holding the data matching all combinations of these input lists' elements. This is illustrated below, where absolutely all data collected around April 22–23, 2018 is loaded.
```python
data = Data.via_metadatabase(categories=['Antenna', 'Switch', 'Temperature'],
                             instruments=['100MHz', '70MHz'],
                             channels=['EW', 'NS'],
                             intervals=[(1524400000.0,1524500000.0),],
                             quality=[1, 0, 'NULL'],
                             integrity=[1, 0, 'NULL'],
                             completeness=[1, 0, 'NULL'])
```

Alternatively, curated data selections suitable for specific analyses can be loaded through the metadatabase by referencing certain pickle files, such as those available under this repository's [`../selections`](selections/) subdirectory. As demonstrated below, the pickle file `../selections/2018_100MHz_EW.p` can be referenced to load all the good-quality east-west polarization data gathered by the 100MHz antenna in 2018.
```python
data = Data.via_metadatabase(selection='./selections/2018_100MHz_EW.p')
```

#### Loading Data from Directories

PRIZM data can be loaded directly from a list of directories using the data container's `from_directories` constructor. Because this approach does not make use of the metadatabase, it requires a substantial amount of additional information as inputs in order to make sense of the file and directory structure the data will be read from. User-defined catalogues are used for that purpose. Below an example of such catalogues is shown.
```python
classification_catalogue = {
    'data_70MHz': '70MHz',
    'data_100MHz': '100MHz',
}

file_catalogue = {
    'pol1.scio': ('float',['NS'],'pol'),
    'pol1.scio.bz2': ('float',['NS'],'pol'),
    'pol0.scio': ('float',['EW'],'pol'),
    'pol0.scio.bz2': ('float',['EW'],'pol'),
    'time_sys_stop.raw': ('float',['EW','NS'],'time_sys_stop'),
    'time_sys_start.raw': ('float',['EW','NS'],'time_sys_start'),
    'open.scio': ('float',['Switch'],'open'),
    'short.scio': ('float',['Switch'],'short'),
    'res50.scio': ('float',['Switch'],'res50'),
    'res100.scio': ('float',['Switch'],'res100'),
    'antenna.scio': ('float',['Switch'],'antenna'),
    'open.scio.bz2': ('float',['Switch'],'open'),
    'short.scio.bz2': ('float',['Switch'],'short'),
    'res50.scio.bz2': ('float',['Switch'],'res50'),
    'res100.scio.bz2': ('float',['Switch'],'res100'),
    'antenna.scio.bz2': ('float',['Switch'],'antenna'),
}
```
While the `classification_catalogue` connects parent directory names to the primary data container keys, the `file_catalogue` lists every file of interest along with its respective data type, container hierarchy levels, and container key. Notice, however, that the above examples are neither definitive nor exhaustive, and would need to be manually edited to accommodate additional data, different file names, and/or different parent directory names.

In addition to the above catalogues, the `from_directories` constructor also receives a list of directory addresses as an argument, and returns a data container holding the data matching all cataloged files found within every subdirectory of the input directory addresses. This is illustrated below, where some of the data collected by the 100MHz instrument around October 21–22, 2021 is loaded.
```python
data = Data.from_directories(directory_addresses=['/project/s/sievers/prizm/marion2022/prizm-100/data_100MHz/16348',
                                                  '/project/s/sievers/prizm/marion2022/prizm-100/data_100MHz/switch/16348'],
                             classification_catalogue=classification_catalogue,
                             file_catalogue=file_catalogue)
```
