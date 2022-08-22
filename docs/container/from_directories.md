<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `from_directories`

Loads the cataloged files located under the input directory addresses, organizing them according to the input catalogues.

**Important:** This constructor assumes that the data directory structure is headed by an instrument directory (e.g. `../data_70MHz`) containing sub-directories for that instrument's antenna data (e.g. `../data_70MHz/16348`, etc.), switch data (e.g. `../data_70MHz/switch`), and temperature data (e.g. `../data_70MHz/temperature`).

### Signature
```python
from_directories(directory_addresses, classification_catalogue, file_catalogue)
```

### Example
```python
from data import Data

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
    'noise.scio': ('float',['Switch'],'noise'),
    'res50.scio': ('float',['Switch'],'res50'),
    'res100.scio': ('float',['Switch'],'res100'),
    'antenna.scio': ('float',['Switch'],'antenna'),
    'open.scio.bz2': ('float',['Switch'],'open'),
    'short.scio.bz2': ('float',['Switch'],'short'),
    'noise.scio.bz2': ('float',['Switch'],'noise'),
    'res50.scio.bz2': ('float',['Switch'],'res50'),
    'res100.scio.bz2': ('float',['Switch'],'res100'),
    'antenna.scio.bz2': ('float',['Switch'],'antenna'),
}

data = Data.from_directories(directory_addresses=['/project/s/sievers/prizm/marion2022/prizm-100/data_100MHz/16348',
                                                  '/project/s/sievers/prizm/marion2022/prizm-100/data_100MHz/switch/16348'],
                             classification_catalogue=classification_catalogue,
                             file_catalogue=file_catalogue)
```

