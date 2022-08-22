<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `via_metadatabase`

Loads all data files matching the input arguments via the PRIZM metadatabase.

### Signature
```python
via_metadatabase(categories, instruments, channels, intervals, quality, integrity, completeness, selection)
```

### Examples
```python
from data import Data

data = Data.via_metadatabase(categories=['Antenna', 'Switch', 'Temperature'],
                             instruments=['100MHz', '70MHz'],
                             channels=['EW', 'NS'],
                             intervals=[(1524400000.0,1524500000.0),],
                             quality=[1, 0, 'NULL'],
                             integrity=[1, 0, 'NULL'],
                             completeness=[1, 0, 'NULL'])
```
```python
from data import Data

data = Data.via_metadatabase(selection='./selections/2018_100MHz_EW.p')
```


