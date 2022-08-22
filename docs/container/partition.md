<sup>**← [List of Functionalities](../../README.md#Container-Design)**</sup>

# `partition`

Produces partitions which slice the data according to the instrument's switch states.

### Signature
```python
partition(instruments, channels, buffer)
```

### Example
```python
data.partition(instruments=['100MHz', '70MHz'], channels=['EW', 'NS'], buffer=(1,1))
```

