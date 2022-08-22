<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `interpolate`

Employs linear interpolation over a given data partition to extrapolate spectra for each input time.

### Signature
```python
interpolate(times, instrument, channel, partition, threshold)
```

### Example
```python
sky_times = data.get(data='time_sys_start', instrument='100MHz', channel='EW', partition='antenna')
data.interpolate(sky_times, instrument='100MHz', channel='EW', partition='noise', threshold=1000)
```

