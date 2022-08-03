<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `lst`

Produces local sidereal time entries for each input instrument and channel. The default location is set to PRIZM's deployment site at Marion island.

### Signature
```python
lst(instruments, channels, location)
```

### Example
```python
data.lst(instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], location=('37.819638d', '-46.88694d'))
```

