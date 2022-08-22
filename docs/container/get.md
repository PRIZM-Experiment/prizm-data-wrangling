<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `get`

Extracts the data partition associated with the input instrument and channel.

### Signature
```python
get(data, instrument, channel, partition)
```

### Examples
```python
data.get(data='pol', instrument='100MHz', channel='EW', partition='antenna')
```
```python
data.get(data='time_sys_start', instrument='100MHz', channel='EW', partition='antenna')
```
